import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/recognition_result_entity.dart';

part 'gate_detection_state.freezed.dart';

enum GateCameraStatus {
  initial,
  initializing,
  ready,
  streaming,
  error,
  disposed,
}

/// Simplified process pipeline status for KAI Gate passive flow.
enum GateProcessStatus {
  /// Actively scanning for faces — no face detected yet.
  scanning,

  /// A face is detected and being tracked, waiting for quality frame.
  faceDetected,

  /// Capturing a still frame for processing.
  capturing,

  /// Running anti-spoofing model.
  antiSpoofing,

  /// Running face embedding + matching.
  recognizing,

  /// Pipeline completed successfully (Face recognized, Attendance logic will follow).
  success,

  /// Pipeline failed at some step.
  failed,

  /// API Attendance call succeeded.
  attendanceSuccess,

  /// API Attendance call failed.
  attendanceFailed,
}

@freezed
abstract class GateDetectionState with _$GateDetectionState {
  const factory GateDetectionState({
    @Default(GateCameraStatus.initial) GateCameraStatus cameraStatus,
    @Default(GateProcessStatus.scanning) GateProcessStatus processStatus,

    /// The currently tracked face (largest face in frame).
    DetectedFaceEntity? trackedFace,

    /// Camera frame image size (for coordinate transformation).
    Size? imageSize,

    /// Number of faces detected in the current frame.
    @Default(0) int faceCount,

    /// Recognition result after successful pipeline.
    RecognitionResultEntity? recognitionResult,

    /// Human-readable status message for the UI.
    @Default('Arahkan wajah Anda ke kamera') String statusMessage,

    /// Error messages.
    String? errorMessage,
  }) = _GateDetectionState;
}
