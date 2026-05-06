import 'dart:math' as math;
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/exceptions.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:developer' as dev;

/// Result of the dual-model anti-spoofing ensemble.
class LivenessResult {
  final bool isReal;
  final double score;

  const LivenessResult({required this.isReal, required this.score});

  @override
  String toString() => 'LivenessResult(isReal: $isReal, score: ${score.toStringAsFixed(4)})';
}

@lazySingleton
class AntiSpoofingService {
  Interpreter? _interpreter1; // MiniFASNetV2 (scale 2.7)
  Interpreter? _interpreter2; // MiniFASNetV1SE (scale 4.0)

  static const String _model1Path =
      'assets/2.7_80x80_MiniFASNetV2_simplified_float16.tflite';
  static const String _model2Path =
      'assets/4_0_0_80x80_MiniFASNetV1SE_simplified_float16.tflite';
  static const int _inputSize = 80;

  bool get isInitialized => _interpreter1 != null && _interpreter2 != null;

  Future<void> initialize() async {
    if (isInitialized) return;
    try {
      final options = InterpreterOptions()..threads = 4;
      _interpreter1 = await Interpreter.fromAsset(_model1Path, options: options);
      _interpreter2 = await Interpreter.fromAsset(_model2Path, options: options);
      dev.log(
        'AntiSpoofingService initialized (dual-model ensemble).',
        name: 'AntiSpoofing',
      );
    } catch (e) {
      throw CameraServiceException(
        'Failed to load Anti-Spoofing TFLite models: $e',
      );
    }
  }

  /// Computes the scaled crop box for MiniFASNet models.
  ///
  /// Replicates the Python `getNewBox` logic exactly:
  /// scale the face bounding box by [scale], then clamp/shift to image bounds.
  List<int> _getNewBox(
    int srcW,
    int srcH,
    int bx,
    int by,
    int bw,
    int bh,
    double scale,
  ) {
    // Compute the effective scale (capped by image dimensions)
    final s = math.min(
      (srcH - 1) / bh,
      math.min((srcW - 1) / bw, scale),
    );

    final nw = bw * s;
    final nh = bh * s;
    final cx = bw / 2.0 + bx;
    final cy = bh / 2.0 + by;

    var x1 = cx - nw / 2.0;
    var y1 = cy - nh / 2.0;
    var x2 = cx + nw / 2.0;
    var y2 = cy + nh / 2.0;

    // Shift the box to fit within bounds (don't just clamp — shift)
    if (x1 < 0) {
      x2 -= x1;
      x1 = 0;
    }
    if (y1 < 0) {
      y2 -= y1;
      y1 = 0;
    }
    if (x2 > srcW) {
      x1 -= (x2 - srcW);
      x2 = srcW.toDouble();
    }
    if (y2 > srcH) {
      y1 -= (y2 - srcH);
      y2 = srcH.toDouble();
    }

    // Final safety clamp
    x1 = x1.clamp(0, srcW).toDouble();
    y1 = y1.clamp(0, srcH).toDouble();
    x2 = x2.clamp(0, srcW).toDouble();
    y2 = y2.clamp(0, srcH).toDouble();

    return [x1.toInt(), y1.toInt(), (x2 - x1).toInt(), (y2 - y1).toInt()];
  }

  /// Crops [image] to [box] (x,y,w,h), resizes to 80×80,
  /// and returns a Float32List in BGR order with raw [0–255] values.
  Float32List _preprocessPatch(img.Image image, List<int> box) {
    final cropped = img.copyCrop(
      image,
      x: box[0],
      y: box[1],
      width: box[2],
      height: box[3],
    );

    final resized = img.copyResize(
      cropped,
      width: _inputSize,
      height: _inputSize,
    );

    // Layout: [H, W, C] with BGR channel order, raw 0-255 floats
    final buffer = Float32List(_inputSize * _inputSize * 3);
    int idx = 0;
    for (int y = 0; y < _inputSize; y++) {
      for (int x = 0; x < _inputSize; x++) {
        final pixel = resized.getPixel(x, y);
        buffer[idx++] = pixel.b.toDouble(); // Blue
        buffer[idx++] = pixel.g.toDouble(); // Green
        buffer[idx++] = pixel.r.toDouble(); // Red
      }
    }

    return buffer;
  }

  /// Runs inference on a single interpreter and returns the 3-element output.
  List<double> _runModel(Interpreter interpreter, Float32List inputBuffer) {
    // Reshape flat buffer into [1, 80, 80, 3] tensor
    final input = inputBuffer.reshape([1, _inputSize, _inputSize, 3]);

    // Output shape: [1, 3]
    final output = List.generate(1, (_) => List.filled(3, 0.0));

    interpreter.run(input, output);

    return output[0];
  }

  /// Evaluates whether the captured face is REAL using a dual-model ensemble.
  ///
  /// Returns a [LivenessResult] with `isReal` and a confidence `score`.
  Future<LivenessResult> evaluateLiveness(CapturedFrame frame) async {
    if (!isInitialized) {
      await initialize();
    }

    try {
      // 1. Decode the captured JPEG image
      final originalImage = img.decodeImage(frame.imageBytes);
      if (originalImage == null) {
        throw const CameraServiceException(
          'Failed to decode captured image for anti-spoofing',
        );
      }

      final srcW = originalImage.width;
      final srcH = originalImage.height;

      // 2. Map bounding box from ML Kit preview space to captured image space
      final bbox = frame.face.boundingBox;

      double scaleX = srcW / frame.imageSize.width;
      double scaleY = srcH / frame.imageSize.height;

      // Handle orientation mismatch (portrait preview → landscape JPEG or vice versa)
      if ((srcW > srcH) != (frame.imageSize.width > frame.imageSize.height)) {
        scaleX = srcW / frame.imageSize.height;
        scaleY = srcH / frame.imageSize.width;
      }

      final faceX = (bbox.left * scaleX).toInt().clamp(0, srcW);
      final faceY = (bbox.top * scaleY).toInt().clamp(0, srcH);
      final faceW = (bbox.width * scaleX).toInt().clamp(1, srcW - faceX);
      final faceH = (bbox.height * scaleY).toInt().clamp(1, srcH - faceY);

      dev.log(
        'Image: ${srcW}x$srcH, Face bbox: ($faceX, $faceY, $faceW, $faceH)',
        name: 'AntiSpoofing',
      );

      // 3. Compute crop boxes for each model
      final box1 = _getNewBox(srcW, srcH, faceX, faceY, faceW, faceH, 2.7);
      final box2 = _getNewBox(srcW, srcH, faceX, faceY, faceW, faceH, 4.0);

      dev.log('Model1 crop box (2.7): $box1', name: 'AntiSpoofing');
      dev.log('Model2 crop box (4.0): $box2', name: 'AntiSpoofing');

      // 4. Preprocess patches
      final patch1 = _preprocessPatch(originalImage, box1);
      final patch2 = _preprocessPatch(originalImage, box2);

      // 5. Run inference on both models
      final out1 = _runModel(_interpreter1!, patch1);
      final out2 = _runModel(_interpreter2!, patch2);

      dev.log('Model1 output: $out1', name: 'AntiSpoofing');
      dev.log('Model2 output: $out2', name: 'AntiSpoofing');

      // 6. Ensemble: element-wise sum
      final ensemble = List<double>.generate(
        3,
        (i) => out1[i] + out2[i],
      );

      // 7. Determine label via argmax
      int label = 0;
      double maxVal = ensemble[0];
      for (int i = 1; i < ensemble.length; i++) {
        if (ensemble[i] > maxVal) {
          maxVal = ensemble[i];
          label = i;
        }
      }

      final isReal = label == 1;
      final score = ensemble[label] / 2.0; // Normalize to 0..1

      dev.log(
        'Ensemble: $ensemble, label: $label, isReal: $isReal, score: ${score.toStringAsFixed(4)}',
        name: 'AntiSpoofing',
      );

      return LivenessResult(isReal: isReal, score: score);
    } catch (e) {
      throw FaceDetectionProcessException(
        'Anti-Spoofing Inference failed: $e',
      );
    }
  }

  void dispose() {
    _interpreter1?.close();
    _interpreter2?.close();
    _interpreter1 = null;
    _interpreter2 = null;
  }
}
