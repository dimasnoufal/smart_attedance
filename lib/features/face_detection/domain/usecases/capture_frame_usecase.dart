import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/repositories/face_detection_repository.dart';

/// Captures the current camera frame as in-memory bytes.
/// Called automatically when face validation passes for sufficient duration.
@lazySingleton
class CaptureFrameUseCase
    extends UseCase<CapturedFrame, CaptureFrameParams> {
  final FaceDetectionRepository _repository;

  CaptureFrameUseCase(this._repository);

  @override
  Future<Either<Failure, CapturedFrame>> call(
    CaptureFrameParams params,
  ) {
    return _repository.captureFrame(face: params.face, imageSize: params.imageSize);
  }
}

/// Parameters for [CaptureFrameUseCase].
class CaptureFrameParams {
  final DetectedFaceEntity face;
  final Size imageSize;

  const CaptureFrameParams({required this.face, required this.imageSize});
}
