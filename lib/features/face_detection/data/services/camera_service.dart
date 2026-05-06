import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:smart_attedance/core/error/exceptions.dart';

/// Manages camera lifecycle: initialization, image streaming, and capture.
///
/// Design decisions:
/// - [ResolutionPreset.medium] balances quality vs performance on low-mid devices.
/// - Image format is platform-specific: NV21 (Android) / BGRA8888 (iOS).
/// - Only one image stream can be active at a time.
/// - Capture stops the stream temporarily, captures, then caller must restart.
@lazySingleton
class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isStreamingImages = false;

  /// Current camera controller — null before initialization.
  CameraController? get controller => _controller;

  /// Whether the camera has been successfully initialized.
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  /// Whether image streaming is currently active.
  bool get isStreamingImages => _isStreamingImages;

  /// The current camera description (needed for ML Kit rotation).
  CameraDescription? get currentCamera => _controller?.description;

  /// Initializes the camera with the specified lens direction.
  /// Defaults to front camera for attendance selfie mode.
  Future<void> initialize({
    CameraLensDirection direction = CameraLensDirection.front,
  }) async {
    try {
      if (_controller != null && isInitialized) {
        if (_controller!.description.lensDirection == direction) {
          // Already initialized with correct direction
          return;
        }
        // Need to switch camera, dispose old one first
        await dispose();
      }

      _cameras ??= await availableCameras();

      if (_cameras == null || _cameras!.isEmpty) {
        throw const CameraServiceException('No cameras available');
      }

      final camera = _cameras!.firstWhere(
        (c) => c.lensDirection == direction,
        orElse: () => _cameras!.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: defaultTargetPlatform == TargetPlatform.iOS
            ? ImageFormatGroup.bgra8888
            : ImageFormatGroup.nv21,
      );

      await _controller!.initialize();

      // Enable continuous auto-focus and auto-exposure for optimal face clarity
      try {
        await _controller!.setFocusMode(FocusMode.auto);
        await _controller!.setExposureMode(ExposureMode.auto);
      } catch (_) {
        // Some devices/cameras may not support these modes — safe to ignore
      }
    } catch (e) {
      if (e is CameraServiceException) rethrow;
      throw CameraServiceException('Failed to initialize camera: $e');
    }
  }

  /// Starts streaming camera frames for face detection processing.
  Future<void> startImageStream(
    void Function(CameraImage image) onImage,
  ) async {
    if (_controller == null || !isInitialized) {
      throw const CameraServiceException(
        'Camera not initialized',
      );
    }
    if (_isStreamingImages) return;

    await _controller!.startImageStream(onImage);
    _isStreamingImages = true;
  }

  /// Stops the image stream.
  Future<void> stopImageStream() async {
    if (!_isStreamingImages || _controller == null) return;

    try {
      await _controller!.stopImageStream();
    } catch (_) {
      // Swallow — stream may already be stopped
    }
    _isStreamingImages = false;
  }

  /// Captures the current frame as in-memory bytes.
  /// Stops the image stream if active (camera plugin requirement).
  Future<Uint8List?> captureImageBytes() async {
    if (_controller == null || !isInitialized) return null;

    try {
      if (_isStreamingImages) {
        await stopImageStream();
      }

      final xFile = await _controller!.takePicture();
      return await xFile.readAsBytes();
    } catch (e) {
      throw CameraServiceException('Failed to capture image: $e');
    }
  }

  /// Captures the current frame and returns the XFile.
  /// Useful when file path is needed for ML Kit processing.
  Future<XFile?> captureImageFile() async {
    if (_controller == null || !isInitialized) return null;

    try {
      if (_isStreamingImages) {
        await stopImageStream();
      }

      return await _controller!.takePicture();
    } catch (e) {
      throw CameraServiceException('Failed to capture image file: $e');
    }
  }

  /// Releases all camera resources. Must be called on dispose.
  Future<void> dispose() async {
    await stopImageStream();
    await _controller?.dispose();
    _controller = null;
    _isStreamingImages = false;
  }
}
