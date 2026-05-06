import 'dart:ui';

import 'package:injectable/injectable.dart';

import 'package:smart_attedance/core/constants/face_detection_constants.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_bounds.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_detection_result.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_validation_status.dart';

/// Pure business logic for validating detected faces.
/// No side effects — synchronous computation only.
@lazySingleton
class ValidateFaceUseCase {
  /// Validates a face detection result against business rules:
  /// 1. Exactly 1 face
  /// 2. Face size within acceptable range (not too far/close)
  /// 3. Face centered within guide area
  /// Note: If [isLivenessActive] is true, position and size rules are relaxed.
  FaceValidationStatus call(ValidateFaceParams params) {
    final result = params.result;
    final imageSize = params.imageSize;
    final isLivenessActive = params.isLivenessActive;

    // Rule 1: Must have at least one face
    if (result.faceCount == 0) {
      return FaceValidationStatus.noFace;
    }

    // Rule 2: Must have exactly one face
    if (result.faceCount > FaceDetectionConstants.maxAllowedFaces) {
      return FaceValidationStatus.multipleFaces;
    }

    final face = result.faces.first;
    final faceWidthRatio = face.boundingBox.width / imageSize.width;

    // If liveness is active, user is moving their head, so we relax size rules
    final minRatio = isLivenessActive
        ? FaceDetectionConstants.minFaceRatio * 0.7
        : FaceDetectionConstants.minFaceRatio;

    final maxRatio = isLivenessActive
        ? FaceDetectionConstants.maxFaceRatio * 1.2
        : FaceDetectionConstants.maxFaceRatio;

    // Rule 3: Face must not be too far (too small)
    if (faceWidthRatio < minRatio) {
      return FaceValidationStatus.tooFar;
    }

    // Rule 4: Face must not be too close (too large)
    if (faceWidthRatio > maxRatio) {
      return FaceValidationStatus.tooClose;
    }

    // Rule 5: Face must be approximately centered
    final faceCenterX = face.boundingBox.centerX;
    final faceCenterY = face.boundingBox.centerY;
    final imageCenterX = imageSize.width / 2;
    final imageCenterY = imageSize.height / 2;

    final offsetX = (faceCenterX - imageCenterX).abs() / imageSize.width;
    final offsetY = (faceCenterY - imageCenterY).abs() / imageSize.height;

    // If liveness is active, user is moving their head, so we relax center tolerance
    final tolX = isLivenessActive
        ? FaceDetectionConstants.centerToleranceX * 1.5
        : FaceDetectionConstants.centerToleranceX;
    final tolY = isLivenessActive
        ? FaceDetectionConstants.centerToleranceY * 1.5
        : FaceDetectionConstants.centerToleranceY;

    if (offsetX > tolX || offsetY > tolY) {
      return FaceValidationStatus.notCentered;
    }

    return FaceValidationStatus.valid;
  }
}

/// Parameters for [ValidateFaceUseCase].
class ValidateFaceParams {
  final FaceDetectionResult result;
  final Size imageSize;
  final bool isLivenessActive;

  const ValidateFaceParams({
    required this.result,
    required this.imageSize,
    this.isLivenessActive = false,
  });
}
