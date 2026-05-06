import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_detection_result.dart';
import 'package:smart_attedance/features/face_detection/domain/repositories/face_detection_repository.dart';

/// Processes a camera frame through ML Kit face detection.
@lazySingleton
class DetectFacesUseCase
    extends UseCase<FaceDetectionResult, DetectFacesParams> {
  final FaceDetectionRepository _repository;

  DetectFacesUseCase(this._repository);

  @override
  Future<Either<Failure, FaceDetectionResult>> call(
    DetectFacesParams params,
  ) {
    return _repository.detectFaces(
      image: params.image,
      camera: params.camera,
    );
  }
}

/// Parameters for [DetectFacesUseCase].
class DetectFacesParams {
  final CameraImage image;
  final CameraDescription camera;

  const DetectFacesParams({
    required this.image,
    required this.camera,
  });
}
