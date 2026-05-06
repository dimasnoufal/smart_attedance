import 'package:freezed_annotation/freezed_annotation.dart';

import 'detected_face_entity.dart';

part 'face_detection_result.freezed.dart';

/// Result of a single frame's face detection processing.
@freezed
abstract class FaceDetectionResult with _$FaceDetectionResult {
  const factory FaceDetectionResult({
    required int faceCount,
    required List<DetectedFaceEntity> faces,
    required DateTime timestamp,
  }) = _FaceDetectionResult;
}
