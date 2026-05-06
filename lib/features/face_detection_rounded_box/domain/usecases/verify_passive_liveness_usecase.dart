import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/data/services/anti_spoofing_service.dart';
import 'package:dartz/dartz.dart';

class VerifyPassiveLivenessParams {
  final CapturedFrame frame;

  /// Anti-spoofing threshold on the ensemble score (0.0–1.0).
  /// Only used as a secondary check; primary check is argmax label == 1.
  final double threshold;

  const VerifyPassiveLivenessParams({
    required this.frame,
    this.threshold = 0.75,
  });
}

@lazySingleton
class VerifyPassiveLivenessUseCase implements UseCase<bool, VerifyPassiveLivenessParams> {
  final AntiSpoofingService _antiSpoofingService;

  VerifyPassiveLivenessUseCase(this._antiSpoofingService);

  @override
  Future<Either<Failure, bool>> call(VerifyPassiveLivenessParams params) async {
    try {
      final result = await _antiSpoofingService.evaluateLiveness(params.frame);

      // The ensemble argmax already decides real vs fake.
      // We additionally gate on the confidence score.
      if (result.isReal && result.score >= params.threshold) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(Failure.faceDetection(message: 'Anti-spoofing check failed: $e'));
    }
  }
}
