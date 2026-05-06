import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_validation_status.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/liveness_step.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/recognition_result_entity.dart';

part 'face_detection_state.freezed.dart';

/// Camera lifecycle status.
enum CameraStatus {
  uninitialized,
  initializing,
  ready,
  streaming,
  error,
  disposed,
}

/// Immutable state for the face detection feature.
@freezed
abstract class FaceDetectionState with _$FaceDetectionState {
  const factory FaceDetectionState({
    @Default(CameraStatus.uninitialized) CameraStatus cameraStatus,
    @Default(FaceValidationStatus.scanning) FaceValidationStatus validationStatus,
    @Default([]) List<DetectedFaceEntity> detectedFaces,
    @Default([]) List<LivenessStep> livenessSequence,
    @Default(0) int currentLivenessStepIndex,
    @Default(false) bool isLivenessActive,
    @Default(false) bool isProcessingFrame,
    @Default(false) bool isCaptured,
    @Default(false) bool isRecognizing,
    @Default(0.0) double captureProgress,
    CapturedFrame? capturedFrame,
    RecognitionResultEntity? recognitionResult,
    Size? imageSize,
    String? errorMessage,
  }) = _FaceDetectionState;
}
