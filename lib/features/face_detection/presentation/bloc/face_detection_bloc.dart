import 'dart:async';
import 'dart:developer' as dev;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:smart_attedance/core/constants/face_detection_constants.dart';
import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart';
import 'package:smart_attedance/features/face_detection/data/services/face_detector_service.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_validation_status.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/liveness_step.dart';
import 'package:smart_attedance/features/face_detection/domain/usecases/capture_frame_usecase.dart';
import 'package:smart_attedance/features/face_detection/domain/usecases/detect_faces_usecase.dart';
import 'package:smart_attedance/features/face_detection/domain/usecases/validate_face_usecase.dart';
import 'package:smart_attedance/features/face_detection/domain/usecases/verify_liveness_usecase.dart';
import 'package:smart_attedance/features/face_recognition/domain/usecases/extract_embedding_usecase.dart';
import 'package:smart_attedance/features/face_recognition/domain/usecases/match_face_usecase.dart';
import 'face_detection_event.dart';
import 'face_detection_state.dart';

/// Bloc orchestrating the face detection feature.
///
/// Performance strategy:
/// - Frame throttling via [_lastProcessedTime] — skips frames within interval.
/// - [_isProcessingFrame] flag prevents concurrent ML Kit processing.
/// - Auto-capture uses [Timer] to ensure face stays valid for required duration.
/// - Proper resource cleanup on [close].
@injectable
class FaceDetectionBloc
    extends Bloc<FaceDetectionEvent, FaceDetectionState> {
  final CameraService _cameraService;
  final FaceDetectorService _faceDetectorService;
  final DetectFacesUseCase _detectFacesUseCase;
  final ValidateFaceUseCase _validateFaceUseCase;
  final VerifyLivenessUseCase _verifyLivenessUseCase;
  final CaptureFrameUseCase _captureFrameUseCase;
  final ExtractEmbeddingUseCase _extractEmbeddingUseCase;
  final MatchFaceUseCase _matchFaceUseCase;

  /// Prevents concurrent frame processing.
  bool _isProcessingFrame = false;

  /// Timestamp of last processed frame for throttling.
  DateTime? _lastProcessedTime;

  /// Timer for auto-capture delay after stable valid detection.
  Timer? _captureTimer;

  /// Tracks capture progress for UI animation.
  Timer? _progressTimer;

  FaceDetectionBloc(
    this._cameraService,
    this._faceDetectorService,
    this._detectFacesUseCase,
    this._validateFaceUseCase,
    this._verifyLivenessUseCase,
    this._captureFrameUseCase,
    this._extractEmbeddingUseCase,
    this._matchFaceUseCase,
  ) : super(const FaceDetectionState(
          livenessSequence: [
            LivenessStep.smile,
            LivenessStep.turnRight,
            LivenessStep.turnLeft,
            LivenessStep.lookStraight,
          ],
        )) {
    on<FaceDetectionStarted>(_onStarted);
    on<FaceDetectionCameraInitialized>(_onCameraInitialized);
    on<FaceDetectionFrameReceived>(_onFrameReceived);
    on<FaceDetectionValidationCompleted>(_onValidationCompleted);
    on<FaceDetectionLivenessStepCompleted>(_onLivenessStepCompleted);
    on<FaceDetectionCaptureTriggered>(_onCaptureTriggered);
    on<FaceDetectionCaptureCompleted>(_onCaptureCompleted);
    on<FaceDetectionRecognitionCompleted>(_onRecognitionCompleted);
    on<FaceDetectionErrorOccurred>(_onErrorOccurred);
    on<FaceDetectionStopped>(_onStopped);
    on<FaceDetectionResetRequested>(_onResetRequested);
  }

  /// Initializes camera and face detector, then starts streaming.
  Future<void> _onStarted(
    FaceDetectionStarted event,
    Emitter<FaceDetectionState> emit,
  ) async {
    emit(state.copyWith(cameraStatus: CameraStatus.initializing));

    try {
      // Initialize face detector
      if (!_faceDetectorService.isInitialized) {
        _faceDetectorService.initialize();
      }

      // Initialize camera (front camera for attendance)
      await _cameraService.initialize(
        direction: CameraLensDirection.front,
      );

      emit(state.copyWith(cameraStatus: CameraStatus.ready));
      add(const FaceDetectionEvent.cameraInitialized());
    } catch (e) {
      emit(state.copyWith(
        cameraStatus: CameraStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Starts the camera image stream after initialization.
  Future<void> _onCameraInitialized(
    FaceDetectionCameraInitialized event,
    Emitter<FaceDetectionState> emit,
  ) async {
    try {
      await _cameraService.startImageStream(_onCameraFrame);
      emit(state.copyWith(cameraStatus: CameraStatus.streaming));
    } catch (e) {
      emit(state.copyWith(
        cameraStatus: CameraStatus.error,
        errorMessage: 'Failed to start image stream: $e',
      ));
    }
  }

  /// Callback from camera image stream — throttled and guarded.
  void _onCameraFrame(CameraImage image) {
    // Guard: skip if already processing or captured
    if (_isProcessingFrame || state.isCaptured) return;

    // Throttle: skip if within interval
    final now = DateTime.now();
    if (_lastProcessedTime != null &&
        now.difference(_lastProcessedTime!).inMilliseconds <
            FaceDetectionConstants.frameProcessingIntervalMs) {
      return;
    }
    _lastProcessedTime = now;
    _isProcessingFrame = true;

    // Process frame asynchronously
    _processFrame(image);
  }

  /// Processes a single camera frame through ML Kit.
  Future<void> _processFrame(CameraImage image) async {
    try {
      final camera = _cameraService.currentCamera;
      if (camera == null) {
        _isProcessingFrame = false;
        return;
      }

      final result = await _detectFacesUseCase(
        DetectFacesParams(image: image, camera: camera),
      );

      result.fold(
        (failure) {
          // Throttled or transient error — silently skip
          _isProcessingFrame = false;
        },
        (detectionResult) {
          final imageSize = Size(
            image.width.toDouble(),
            image.height.toDouble(),
          );

          // Validate the detection result
          final validationStatus = _validateFaceUseCase(
            ValidateFaceParams(
              result: detectionResult,
              imageSize: imageSize,
              isLivenessActive: state.isLivenessActive,
            ),
          );

          if (!isClosed) {
            add(FaceDetectionEvent.frameReceived(
              result: detectionResult,
              imageSize: imageSize,
            ));
            
            // If we are active in liveness sequence and face is still valid
            if (state.isLivenessActive && validationStatus == FaceValidationStatus.valid) {
              if (state.currentLivenessStepIndex < state.livenessSequence.length) {
                final currentStep = state.livenessSequence[state.currentLivenessStepIndex];
                final isStepPassed = _verifyLivenessUseCase(
                  VerifyLivenessParams(
                    step: currentStep,
                    face: detectionResult.faces.first,
                  ),
                );
                
                if (isStepPassed) {
                  // Only add event if we are not already waiting in a timer
                  if (_captureTimer == null || !_captureTimer!.isActive) {
                    add(const FaceDetectionEvent.livenessStepCompleted());
                  }
                }
              }
            } else {
              // Not in liveness or face became invalid (user moved away)
              add(FaceDetectionEvent.validationCompleted(
                status: validationStatus,
                face: detectionResult.faces.isNotEmpty
                    ? detectionResult.faces.first
                    : null,
              ));
            }
          }

          _isProcessingFrame = false;
        },
      );
    } catch (e) {
      _isProcessingFrame = false;
      dev.log('Frame processing error: $e', name: 'FaceDetectionBloc');
    }
  }

  /// Updates state with latest detection result.
  void _onFrameReceived(
    FaceDetectionFrameReceived event,
    Emitter<FaceDetectionState> emit,
  ) {
    emit(state.copyWith(
      detectedFaces: event.result.faces,
      imageSize: event.imageSize,
    ));
  }

  /// Handles validation result — starts/cancels capture timer.
  Future<void> _onCaptureCompleted(
    FaceDetectionCaptureCompleted event,
    Emitter<FaceDetectionState> emit,
  ) async {
    emit(state.copyWith(
      isCaptured: true,
      capturedFrame: event.frame,
      isRecognizing: true, // Start recognition loading
    ));

    // The stream is already stopped by the capture use case

    // 1. Extract Embedding
    final extractResult = await _extractEmbeddingUseCase(event.frame);
    
    await extractResult.fold(
      (failure) async {
        add(FaceDetectionEvent.errorOccurred(message: failure.message));
      },
      (embedding) async {
        // 2. Match Face
        final matchResult = await _matchFaceUseCase(
          MatchFaceParams(capturedEmbedding: embedding),
        );

        matchResult.fold(
          (failure) {
            add(FaceDetectionEvent.errorOccurred(message: failure.message));
          },
          (result) {
            add(FaceDetectionEvent.recognitionCompleted(result: result));
          },
        );
      },
    );
  }

  void _onRecognitionCompleted(
    FaceDetectionRecognitionCompleted event,
    Emitter<FaceDetectionState> emit,
  ) {
    emit(state.copyWith(
      isRecognizing: false,
      recognitionResult: event.result,
    ));
  }

  void _onValidationCompleted(
    FaceDetectionValidationCompleted event,
    Emitter<FaceDetectionState> emit,
  ) {
    emit(state.copyWith(validationStatus: event.status));

    if (event.status == FaceValidationStatus.valid && !state.isCaptured) {
      // Enter liveness mode if not already
      if (!state.isLivenessActive) {
        emit(state.copyWith(
          isLivenessActive: true,
          currentLivenessStepIndex: 0,
          captureProgress: 0.0,
        ));
      }
    } else {
      // Face is invalid, reset liveness and capture countdown
      _cancelCaptureCountdown();
      emit(state.copyWith(
        isLivenessActive: false,
        currentLivenessStepIndex: 0,
        captureProgress: 0.0,
      ));
    }
  }

  void _onLivenessStepCompleted(
    FaceDetectionLivenessStepCompleted event,
    Emitter<FaceDetectionState> emit,
  ) {
    if (state.currentLivenessStepIndex >= state.livenessSequence.length - 1) {
      // All steps completed, proceed to capture
      emit(state.copyWith(
        currentLivenessStepIndex: state.currentLivenessStepIndex + 1,
      ));
      _startCaptureCountdown();
    } else {
      // Move to next step
      emit(state.copyWith(
        currentLivenessStepIndex: state.currentLivenessStepIndex + 1,
      ));
    }
  }

  /// Starts the auto-capture countdown timer.
  void _startCaptureCountdown() {
    _cancelCaptureCountdown();

    const totalMs = FaceDetectionConstants.captureStabilityDelayMs;
    const tickMs = 50; // Update progress every 50ms for smooth animation
    var elapsed = 0;

    _progressTimer = Timer.periodic(
      const Duration(milliseconds: tickMs),
      (timer) {
        elapsed += tickMs;
        final progress = (elapsed / totalMs).clamp(0.0, 1.0);

        if (!isClosed) {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(state.copyWith(captureProgress: progress));
        }
      },
    );

    _captureTimer = Timer(
      const Duration(milliseconds: totalMs),
      () {
        _progressTimer?.cancel();
        if (!isClosed && !state.isCaptured) {
          add(const FaceDetectionEvent.captureTriggered());
        }
      },
    );
  }

  /// Cancels the auto-capture countdown.
  void _cancelCaptureCountdown() {
    _captureTimer?.cancel();
    _captureTimer = null;
    _progressTimer?.cancel();
    _progressTimer = null;
  }

  /// Captures the current frame.
  Future<void> _onCaptureTriggered(
    FaceDetectionCaptureTriggered event,
    Emitter<FaceDetectionState> emit,
  ) async {
    if (state.detectedFaces.isEmpty) return;

    emit(state.copyWith(isProcessingFrame: true));

    final result = await _captureFrameUseCase(
      CaptureFrameParams(face: state.detectedFaces.first, imageSize: state.imageSize!),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isProcessingFrame: false,
          errorMessage: failure.toString(),
        ));
        // Restart stream for retry
        _restartStream();
      },
      (capturedFrame) {
        add(FaceDetectionEvent.captureCompleted(frame: capturedFrame));
      },
    );
  }

  /// Handles errors.
  void _onErrorOccurred(
    FaceDetectionErrorOccurred event,
    Emitter<FaceDetectionState> emit,
  ) {
    emit(state.copyWith(
      errorMessage: event.message,
      cameraStatus: CameraStatus.error,
    ));
  }

  /// Stops camera and cleans up.
  Future<void> _onStopped(
    FaceDetectionStopped event,
    Emitter<FaceDetectionState> emit,
  ) async {
    _cancelCaptureCountdown();
    await _cameraService.stopImageStream();
    emit(state.copyWith(cameraStatus: CameraStatus.disposed));
  }

  /// Resets state for retry after capture.
  Future<void> _onResetRequested(
    FaceDetectionResetRequested event,
    Emitter<FaceDetectionState> emit,
  ) async {
    _cancelCaptureCountdown();
    _isProcessingFrame = false;
    _lastProcessedTime = null;

    emit(const FaceDetectionState(
      cameraStatus: CameraStatus.ready,
      livenessSequence: [
        LivenessStep.smile,
        LivenessStep.turnRight,
        LivenessStep.turnLeft,
        LivenessStep.lookStraight,
      ],
    ));

    // Restart stream
    _restartStream();
  }

  /// Restarts the camera image stream.
  Future<void> _restartStream() async {
    try {
      if (_cameraService.isStreamingImages) {
        await _cameraService.stopImageStream();
      }
      await _cameraService.startImageStream(_onCameraFrame);
    } catch (e) {
      dev.log('Failed to restart stream: $e', name: 'FaceDetectionBloc');
    }
  }

  @override
  Future<void> close() async {
    _cancelCaptureCountdown();
    await _faceDetectorService.dispose();
    await _cameraService.dispose();
    return super.close();
  }
}
