import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_detection_result.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_validation_status.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/recognition_result_entity.dart';

part 'face_detection_event.freezed.dart';

/// Events driving the face detection state machine.
@freezed
abstract class FaceDetectionEvent with _$FaceDetectionEvent {
  /// User opened the face detection page.
  const factory FaceDetectionEvent.started() = FaceDetectionStarted;

  /// Camera has been successfully initialized.
  const factory FaceDetectionEvent.cameraInitialized() =
      FaceDetectionCameraInitialized;

  /// A camera frame has been received and needs processing.
  const factory FaceDetectionEvent.frameReceived({
    required FaceDetectionResult result,
    required Size imageSize,
  }) = FaceDetectionFrameReceived;

  /// Face validation result is ready.
  const factory FaceDetectionEvent.validationCompleted({
    required FaceValidationStatus status,
    DetectedFaceEntity? face,
  }) = FaceDetectionValidationCompleted;

  /// A liveness step was successfully completed.
  const factory FaceDetectionEvent.livenessStepCompleted() =
      FaceDetectionLivenessStepCompleted;

  /// Auto-capture timer completed — capture now.
  const factory FaceDetectionEvent.captureTriggered() =
      FaceDetectionCaptureTriggered;

  /// Capture completed successfully.
  const factory FaceDetectionEvent.captureCompleted({
    required CapturedFrame frame,
  }) = FaceDetectionCaptureCompleted;

  /// Face recognition matching completed.
  const factory FaceDetectionEvent.recognitionCompleted({
    required RecognitionResultEntity result,
  }) = FaceDetectionRecognitionCompleted;

  /// An error occurred.
  const factory FaceDetectionEvent.errorOccurred({
    required String message,
  }) = FaceDetectionErrorOccurred;

  /// User or lifecycle requested stop.
  const factory FaceDetectionEvent.stopped() = FaceDetectionStopped;

  /// Reset after capture for retry.
  const factory FaceDetectionEvent.resetRequested() =
      FaceDetectionResetRequested;
}
