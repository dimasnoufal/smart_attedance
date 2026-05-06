import 'package:freezed_annotation/freezed_annotation.dart';

import 'face_bounds.dart';

part 'detected_face_entity.freezed.dart';

/// Domain entity representing a single detected face.
/// Contains spatial data and classification probabilities from ML Kit.
@freezed
abstract class DetectedFaceEntity with _$DetectedFaceEntity {
  const factory DetectedFaceEntity({
    required FaceBounds boundingBox,
    double? headEulerAngleY,
    double? headEulerAngleX,
    double? headEulerAngleZ,
    double? smilingProbability,
    double? leftEyeOpenProbability,
    double? rightEyeOpenProbability,
    int? trackingId,
  }) = _DetectedFaceEntity;
}
