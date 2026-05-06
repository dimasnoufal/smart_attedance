import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/exceptions.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

@lazySingleton
class TFLiteRecognizerService {
  Interpreter? _interpreter;
  static const String _modelPath = 'assets/buffalo_l_recognition_fp16.tflite';
  static const int _inputSize = 112;

  bool get isInitialized => _interpreter != null;

  Future<void> initialize() async {
    try {
      final options = InterpreterOptions()..threads = 4;
      _interpreter = await Interpreter.fromAsset(_modelPath, options: options);
    } catch (e) {
      throw CameraServiceException('Failed to load TFLite model: $e');
    }
  }

  /// Processes the captured frame, crops the face, runs TFLite inference,
  /// and returns the 512-dimension vector embedding.
  Future<List<double>> extractEmbedding(CapturedFrame frame) async {
    if (_interpreter == null) {
      await initialize();
    }

    try {
      // 1. Decode original image
      // Note: CapturedFrame.imageBytes is currently a JPEG from Android/iOS.
      final originalImage = img.decodeImage(frame.imageBytes);
      if (originalImage == null) {
        throw const CameraServiceException('Failed to decode captured image');
      }

      // 2. Crop the face based on the ML Kit bounding box
      final bbox = frame.face.boundingBox;

      // Calculate coordinate scale ratio since ML Kit preview size differs from captured JPEG size
      double scaleX = originalImage.width / frame.imageSize.width;
      double scaleY = originalImage.height / frame.imageSize.height;

      // Handle edge cases where width/height might be swapped due to rotation metadata
      if ((originalImage.width > originalImage.height) !=
          (frame.imageSize.width > frame.imageSize.height)) {
        scaleX = originalImage.width / frame.imageSize.height;
        scaleY = originalImage.height / frame.imageSize.width;
      }

      // Ensure we don't crop outside image boundaries
      int left = (bbox.left * scaleX).toInt().clamp(0, originalImage.width);
      int top = (bbox.top * scaleY).toInt().clamp(0, originalImage.height);
      int width = (bbox.width * scaleX).toInt();
      int height = (bbox.height * scaleY).toInt();

      if (left + width > originalImage.width)
        width = originalImage.width - left;
      if (top + height > originalImage.height)
        height = originalImage.height - top;

      final faceCrop = img.copyCrop(
        originalImage,
        x: left,
        y: top,
        width: width,
        height: height,
      );

      // 3. Resize to 112x112 for the model input
      final resizedFace = img.copyResize(
        faceCrop,
        width: _inputSize,
        height: _inputSize,
      );

      // 4. Convert image to NHWC float32 tensor (1, 112, 112, 3)
      // buffalo_s_recognition expects normalized pixels usually (-1 to 1) or (0 to 1).
      // Assuming standard normalization: (pixel - 127.5) / 127.5
      var input = List.generate(
        1,
        (b) => List.generate(
          _inputSize,
          (y) => List.generate(_inputSize, (x) => List.filled(3, 0.0)),
        ),
      );

      for (int y = 0; y < _inputSize; y++) {
        for (int x = 0; x < _inputSize; x++) {
          final pixel = resizedFace.getPixel(x, y);
          input[0][y][x][0] = (pixel.r - 127.5) / 127.5; // Red
          input[0][y][x][1] = (pixel.g - 127.5) / 127.5; // Green
          input[0][y][x][2] = (pixel.b - 127.5) / 127.5; // Blue
        }
      }

      // 5. Prepare output tensor (1, 512)
      var output = List.generate(1, (i) => List.filled(512, 0.0));

      // 6. Run Inference
      _interpreter!.run(input, output);

      return output[0];
    } catch (e) {
      throw FaceDetectionProcessException('Inference failed: $e');
    }
  }

  void dispose() {
    _interpreter?.close();
  }
}
