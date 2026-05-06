import 'dart:async';
import 'dart:developer' as dev;
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/exceptions.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

// ─────────────────────────────────────────────────────────
// Message types for isolate communication
// ─────────────────────────────────────────────────────────

/// Data sent FROM main → isolate.
class InferenceRequest {
  final int id;
  final Uint8List imageBytes;

  /// Face bounding box [left, top, width, height] in the ML Kit preview coordinate space.
  final List<double> faceBbox;

  /// ML Kit preview image size [width, height].
  final List<double> imageSize;

  /// Stored embeddings from local DB: [ {userId, embedding}, ... ]
  final List<Map<String, dynamic>> storedEmbeddings;

  /// Cosine similarity threshold.
  final double matchThreshold;

  /// Anti-spoofing confidence threshold.
  final double livenessThreshold;

  InferenceRequest({
    required this.id,
    required this.imageBytes,
    required this.faceBbox,
    required this.imageSize,
    required this.storedEmbeddings,
    this.matchThreshold = 0.55,
    this.livenessThreshold = 0.70,
  });
}

/// Result sent FROM isolate → main.
class InferenceResponse {
  final int requestId;
  final bool success;
  final String? error;

  // Anti-spoofing results
  final bool? isReal;
  final double? livenessScore;

  // Embedding + match results
  final List<double>? embedding;
  final String? matchedUserId;
  final double? similarityScore;
  final bool? isRecognized;

  InferenceResponse({
    required this.requestId,
    required this.success,
    this.error,
    this.isReal,
    this.livenessScore,
    this.embedding,
    this.matchedUserId,
    this.similarityScore,
    this.isRecognized,
  });
}

// ─────────────────────────────────────────────────────────
// Isolate entry point (runs on background thread)
// ─────────────────────────────────────────────────────────

/// Data needed to initialize the background isolate.
class _IsolateInitData {
  final SendPort mainSendPort;

  /// Pre-loaded model bytes (loaded from assets on the main isolate).
  final Uint8List spoof1Bytes;
  final Uint8List spoof2Bytes;
  final Uint8List recognizerBytes;

  _IsolateInitData({
    required this.mainSendPort,
    required this.spoof1Bytes,
    required this.spoof2Bytes,
    required this.recognizerBytes,
  });
}

/// This function runs entirely in the background isolate.
/// Models are received as raw bytes — no Flutter binding needed.
Future<void> _inferenceIsolateEntryPoint(_IsolateInitData initData) async {
  final mainSendPort = initData.mainSendPort;
  final ReceivePort isolateReceivePort = ReceivePort();
  mainSendPort.send(isolateReceivePort.sendPort);

  Interpreter? spoof1;
  Interpreter? spoof2;
  Interpreter? recognizer;

  try {
    final options = InterpreterOptions()..threads = 2;

    // Create interpreters from raw bytes — no asset bundle needed
    spoof1 = Interpreter.fromBuffer(initData.spoof1Bytes, options: options);
    spoof2 = Interpreter.fromBuffer(initData.spoof2Bytes, options: options);
    recognizer = Interpreter.fromBuffer(initData.recognizerBytes, options: options);

    mainSendPort.send('READY');
  } catch (e) {
    mainSendPort.send('ERROR:$e');
    return;
  }

  // Listen for jobs
  await for (final message in isolateReceivePort) {
    if (message == 'SHUTDOWN') {
      spoof1.close();
      spoof2.close();
      recognizer.close();
      break;
    }

    if (message is InferenceRequest) {
      final response = _processJob(
        message,
        spoof1,
        spoof2,
        recognizer,
      );
      mainSendPort.send(response);
    }
  }

  Isolate.exit();
}

/// Processes a single inference job: anti-spoofing → embedding → match.
InferenceResponse _processJob(
  InferenceRequest req,
  Interpreter spoof1,
  Interpreter spoof2,
  Interpreter recognizer,
) {
  try {
    // 1. Decode JPEG image
    final originalImage = img.decodeImage(req.imageBytes);
    if (originalImage == null) {
      return InferenceResponse(
        requestId: req.id,
        success: false,
        error: 'Failed to decode image',
      );
    }

    final srcW = originalImage.width;
    final srcH = originalImage.height;

    // 2. Map face bbox from preview space → captured image space
    double scaleX = srcW / req.imageSize[0];
    double scaleY = srcH / req.imageSize[1];

    if ((srcW > srcH) != (req.imageSize[0] > req.imageSize[1])) {
      scaleX = srcW / req.imageSize[1];
      scaleY = srcH / req.imageSize[0];
    }

    final faceX = (req.faceBbox[0] * scaleX).toInt().clamp(0, srcW);
    final faceY = (req.faceBbox[1] * scaleY).toInt().clamp(0, srcH);
    final faceW = (req.faceBbox[2] * scaleX).toInt().clamp(1, srcW - faceX);
    final faceH = (req.faceBbox[3] * scaleY).toInt().clamp(1, srcH - faceY);

    // ── Anti-Spoofing ──
    final box1 = _getNewBox(srcW, srcH, faceX, faceY, faceW, faceH, 2.7);
    final box2 = _getNewBox(srcW, srcH, faceX, faceY, faceW, faceH, 4.0);

    final patch1 = _preprocessAntiSpoofPatch(originalImage, box1, 80);
    final patch2 = _preprocessAntiSpoofPatch(originalImage, box2, 80);

    final out1 = _runAntiSpoofModel(spoof1, patch1, 80);
    final out2 = _runAntiSpoofModel(spoof2, patch2, 80);

    // Ensemble: element-wise sum
    final ensemble = List<double>.generate(3, (i) => out1[i] + out2[i]);

    int label = 0;
    double maxVal = ensemble[0];
    for (int i = 1; i < ensemble.length; i++) {
      if (ensemble[i] > maxVal) {
        maxVal = ensemble[i];
        label = i;
      }
    }

    final isReal = label == 1;
    final livenessScore = ensemble[label] / 2.0;

    if (!isReal || livenessScore < req.livenessThreshold) {
      return InferenceResponse(
        requestId: req.id,
        success: true,
        isReal: false,
        livenessScore: livenessScore,
      );
    }

    // ── Embedding Extraction ──
    final faceCrop = img.copyCrop(
      originalImage,
      x: faceX,
      y: faceY,
      width: faceW,
      height: faceH,
    );

    final resizedFace = img.copyResize(faceCrop, width: 112, height: 112);

    var input = List.generate(
      1,
      (b) => List.generate(
        112,
        (y) => List.generate(112, (x) => List.filled(3, 0.0)),
      ),
    );

    for (int y = 0; y < 112; y++) {
      for (int x = 0; x < 112; x++) {
        final pixel = resizedFace.getPixel(x, y);
        input[0][y][x][0] = (pixel.r - 127.5) / 127.5;
        input[0][y][x][1] = (pixel.g - 127.5) / 127.5;
        input[0][y][x][2] = (pixel.b - 127.5) / 127.5;
      }
    }

    var embOutput = List.generate(1, (_) => List.filled(512, 0.0));
    recognizer.run(input, embOutput);
    final embedding = embOutput[0];

    // ── Cosine Similarity Match ──
    if (req.storedEmbeddings.isEmpty) {
      return InferenceResponse(
        requestId: req.id,
        success: true,
        isReal: true,
        livenessScore: livenessScore,
        embedding: embedding,
        isRecognized: false,
        similarityScore: 0.0,
      );
    }

    double highestScore = -1.0;
    String? matchedUserId;

    for (final record in req.storedEmbeddings) {
      final stored = (record['embedding'] as List).cast<double>();
      final score = _cosineSimilarity(embedding, stored);

      if (score > highestScore) {
        highestScore = score;
        matchedUserId = record['userId'] as String;
      }
    }

    final isRecognized =
        highestScore >= req.matchThreshold && matchedUserId != null;

    return InferenceResponse(
      requestId: req.id,
      success: true,
      isReal: true,
      livenessScore: livenessScore,
      embedding: embedding,
      isRecognized: isRecognized,
      matchedUserId: isRecognized ? matchedUserId : null,
      similarityScore: highestScore,
    );
  } catch (e) {
    return InferenceResponse(
      requestId: req.id,
      success: false,
      error: e.toString(),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Pure functions used inside the isolate
// ─────────────────────────────────────────────────────────

List<int> _getNewBox(
    int srcW, int srcH, int bx, int by, int bw, int bh, double scale) {
  final s = math.min((srcH - 1) / bh, math.min((srcW - 1) / bw, scale));
  final nw = bw * s;
  final nh = bh * s;
  final cx = bw / 2.0 + bx;
  final cy = bh / 2.0 + by;

  var x1 = cx - nw / 2.0;
  var y1 = cy - nh / 2.0;
  var x2 = cx + nw / 2.0;
  var y2 = cy + nh / 2.0;

  if (x1 < 0) { x2 -= x1; x1 = 0; }
  if (y1 < 0) { y2 -= y1; y1 = 0; }
  if (x2 > srcW) { x1 -= (x2 - srcW); x2 = srcW.toDouble(); }
  if (y2 > srcH) { y1 -= (y2 - srcH); y2 = srcH.toDouble(); }

  x1 = x1.clamp(0, srcW).toDouble();
  y1 = y1.clamp(0, srcH).toDouble();
  x2 = x2.clamp(0, srcW).toDouble();
  y2 = y2.clamp(0, srcH).toDouble();

  return [x1.toInt(), y1.toInt(), (x2 - x1).toInt(), (y2 - y1).toInt()];
}

Float32List _preprocessAntiSpoofPatch(
    img.Image image, List<int> box, int size) {
  final cropped =
      img.copyCrop(image, x: box[0], y: box[1], width: box[2], height: box[3]);
  final resized = img.copyResize(cropped, width: size, height: size);

  final buffer = Float32List(size * size * 3);
  int idx = 0;
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      final pixel = resized.getPixel(x, y);
      buffer[idx++] = pixel.b.toDouble(); // BGR order
      buffer[idx++] = pixel.g.toDouble();
      buffer[idx++] = pixel.r.toDouble();
    }
  }
  return buffer;
}

List<double> _runAntiSpoofModel(
    Interpreter interpreter, Float32List inputBuffer, int size) {
  final input = inputBuffer.reshape([1, size, size, 3]);
  final output = List.generate(1, (_) => List.filled(3, 0.0));
  interpreter.run(input, output);
  return output[0];
}

double _cosineSimilarity(List<double> a, List<double> b) {
  double normA = 0, normB = 0, dotProduct = 0;
  for (int i = 0; i < a.length; i++) {
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }
  normA = math.sqrt(normA);
  normB = math.sqrt(normB);
  if (normA == 0 || normB == 0) return 0.0;
  for (int i = 0; i < a.length; i++) {
    dotProduct += (a[i] / normA) * (b[i] / normB);
  }
  return dotProduct;
}

// ─────────────────────────────────────────────────────────
// Main-thread service (managed by DI)
// ─────────────────────────────────────────────────────────

/// Long-lived isolate service for running heavy AI inference off the UI thread.
///
/// Models are loaded once when the isolate starts and kept alive for the
/// entire session. Jobs are sent via SendPort and results returned via ReceivePort.
@lazySingleton
class InferenceIsolateService {
  Isolate? _isolate;
  SendPort? _isolateSendPort;
  StreamSubscription? _responseSubscription;

  final _responseController = StreamController<InferenceResponse>.broadcast();
  int _nextRequestId = 0;

  bool get isRunning => _isolate != null && _isolateSendPort != null;

  /// Starts the background isolate and loads all TFLite models.
  /// Should be called once during app/page initialization.
  Future<void> start() async {
    if (isRunning) return;

    final receivePort = ReceivePort();

    // Load model bytes on the main isolate (where Flutter binding is available)
    final spoof1Bytes = await rootBundle.load(
      'assets/2.7_80x80_MiniFASNetV2_simplified_float16.tflite',
    );
    final spoof2Bytes = await rootBundle.load(
      'assets/4_0_0_80x80_MiniFASNetV1SE_simplified_float16.tflite',
    );
    final recognizerBytes = await rootBundle.load(
      'assets/buffalo_l_recognition_fp16.tflite',
    );

    _isolate = await Isolate.spawn(
      _inferenceIsolateEntryPoint,
      _IsolateInitData(
        mainSendPort: receivePort.sendPort,
        spoof1Bytes: spoof1Bytes.buffer.asUint8List(),
        spoof2Bytes: spoof2Bytes.buffer.asUint8List(),
        recognizerBytes: recognizerBytes.buffer.asUint8List(),
      ),
    );

    final completer = Completer<void>();

    _responseSubscription = receivePort.listen((message) {
      if (message is SendPort) {
        _isolateSendPort = message;
      } else if (message is String) {
        if (message == 'READY') {
          dev.log('InferenceIsolate: models loaded, ready.', name: 'Isolate');
          if (!completer.isCompleted) completer.complete();
        } else if (message.startsWith('ERROR:')) {
          final err = message.substring(6);
          dev.log('InferenceIsolate: init error: $err', name: 'Isolate');
          if (!completer.isCompleted) {
            completer.completeError(
                CameraServiceException('Isolate init failed: $err'));
          }
        }
      } else if (message is InferenceResponse) {
        _responseController.add(message);
      }
    });

    return completer.future;
  }

  /// Sends a job to the isolate and returns the result.
  Future<InferenceResponse> runInference(InferenceRequest request) async {
    if (!isRunning) {
      await start();
    }

    final requestId = _nextRequestId++;
    final job = InferenceRequest(
      id: requestId,
      imageBytes: request.imageBytes,
      faceBbox: request.faceBbox,
      imageSize: request.imageSize,
      storedEmbeddings: request.storedEmbeddings,
      matchThreshold: request.matchThreshold,
      livenessThreshold: request.livenessThreshold,
    );

    _isolateSendPort!.send(job);

    // Wait for the response with our specific request ID
    return _responseController.stream
        .firstWhere((r) => r.requestId == requestId)
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () => InferenceResponse(
        requestId: requestId,
        success: false,
        error: 'Inference timeout (15s)',
      ),
    );
  }

  /// Shuts down the isolate and cleans up resources.
  Future<void> stop() async {
    if (_isolateSendPort != null) {
      _isolateSendPort!.send('SHUTDOWN');
    }
    await _responseSubscription?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _isolateSendPort = null;
    dev.log('InferenceIsolate: stopped.', name: 'Isolate');
  }

  void dispose() {
    stop();
    _responseController.close();
  }
}
