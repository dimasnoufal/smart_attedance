import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

/// Wraps Google ML Kit face detection with platform-specific image conversion.
///
/// Key design decisions:
/// - [FaceDetectorMode.fast] for real-time performance.
/// - Classification enabled for anti-spoofing (eye open, smile probability).
/// - Tracking enabled for face identity consistency across frames.
/// - Image conversion handles NV21 (Android) and BGRA8888 (iOS) formats.
@lazySingleton
class FaceDetectorService {
  late final FaceDetector _faceDetector;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  /// Initializes the ML Kit face detector with optimized settings.
  void initialize() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableTracking: true,
        enableLandmarks: false,
        enableContours: false,
        performanceMode: FaceDetectorMode.fast,
        minFaceSize: 0.15,
      ),
    );
    _isInitialized = true;
  }

  /// Processes an input image and returns detected faces.
  Future<List<Face>> processImage(InputImage inputImage) async {
    if (!_isInitialized) {
      throw StateError('FaceDetectorService not initialized');
    }
    return _faceDetector.processImage(inputImage);
  }

  /// Converts a [CameraImage] to ML Kit's [InputImage].
  /// Returns null if conversion fails (unsupported format/platform).
  InputImage? buildInputImageFromCameraImage(
    CameraImage image,
    CameraDescription camera,
  ) {
    final rotation = _resolveRotation(camera);
    if (rotation == null) return null;

    final format = _resolveFormat(image);
    if (format == null) return null;

    final bytes = _concatenateImagePlanes(image);

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  /// Concatenates all image planes into a single byte buffer.
  /// For NV21 (Android), all planes must be combined.
  /// For BGRA8888 (iOS), only the first plane is needed.
  Uint8List _concatenateImagePlanes(CameraImage image) {
    if (Platform.isIOS) {
      return image.planes.first.bytes;
    }

    final allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  /// Resolves the image rotation based on camera sensor orientation.
  InputImageRotation? _resolveRotation(CameraDescription camera) {
    final sensorOrientation = camera.sensorOrientation;

    if (Platform.isIOS) {
      return InputImageRotationValue.fromRawValue(sensorOrientation);
    }

    // Android front camera: rotation needs compensation
    return InputImageRotationValue.fromRawValue(sensorOrientation);
  }

  /// Resolves the image format based on platform.
  InputImageFormat? _resolveFormat(CameraImage image) {
    if (Platform.isIOS) {
      return InputImageFormat.bgra8888;
    }
    return InputImageFormat.nv21;
  }

  /// Releases ML Kit resources.
  Future<void> dispose() async {
    if (_isInitialized) {
      await _faceDetector.close();
      _isInitialized = false;
    }
  }
}
