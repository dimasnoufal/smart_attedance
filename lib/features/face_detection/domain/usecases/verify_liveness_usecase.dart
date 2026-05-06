import 'package:injectable/injectable.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/liveness_step.dart';

/// Verifies if a detected face meets the criteria for a specific liveness challenge.
@lazySingleton
class VerifyLivenessUseCase {
  /// Tolerance for head rotation when looking straight.
  static const double _straightAngleTolerance = 12.0;

  /// Threshold for head rotation to be considered turned.
  static const double _turnAngleThreshold = 25.0;

  /// Threshold for smiling probability.
  static const double _smileProbabilityThreshold = 0.6;

  /// Threshold for neutral face (not smiling) probability.
  static const double _neutralProbabilityThreshold = 0.2;

  bool call(VerifyLivenessParams params) {
    final face = params.face;
    final step = params.step;

    final smileProb = face.smilingProbability ?? 0.0;
    // Euler Angle Y: Positive means head turns to the right of the image (user's left).
    // Negative means head turns to the left of the image (user's right).
    // We will use standard mirror approach:
    // User looks right -> head turns left of image -> Euler Y is negative
    // User looks left -> head turns right of image -> Euler Y is positive
    final headEulerY = face.headEulerAngleY ?? 0.0;
    final headEulerX = face.headEulerAngleX ?? 0.0;

    switch (step) {
      case LivenessStep.smile:
        return smileProb > _smileProbabilityThreshold;
        
      case LivenessStep.turnRight:
        return headEulerY < -_turnAngleThreshold;
        
      case LivenessStep.turnLeft:
        return headEulerY > _turnAngleThreshold;
        
      case LivenessStep.lookStraight:
        return headEulerY.abs() < _straightAngleTolerance &&
            headEulerX.abs() < _straightAngleTolerance &&
            smileProb < _neutralProbabilityThreshold;
    }
  }
}

class VerifyLivenessParams {
  final LivenessStep step;
  final DetectedFaceEntity face;

  const VerifyLivenessParams({
    required this.step,
    required this.face,
  });
}
