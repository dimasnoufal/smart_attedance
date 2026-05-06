import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/features/face_detection/data/mappers/face_mapper.dart';
import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart';
import 'package:smart_attedance/features/face_detection/data/services/face_detector_service.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_detection_result.dart';
import 'package:smart_attedance/features/face_detection/domain/repositories/face_detection_repository.dart';

/// Implementation of [FaceDetectionRepository].
///
/// Orchestrates [CameraService] and [FaceDetectorService] to provide
/// face detection and frame capture functionality.
@LazySingleton(as: FaceDetectionRepository)
class FaceDetectionRepositoryImpl implements FaceDetectionRepository {
  final CameraService _cameraService;
  final FaceDetectorService _faceDetectorService;

  FaceDetectionRepositoryImpl(
    this._cameraService,
    this._faceDetectorService,
  );

  @override
  Future<Either<Failure, FaceDetectionResult>> detectFaces({
    required CameraImage image,
    required CameraDescription camera,
  }) async {
    try {
      final inputImage =
          _faceDetectorService.buildInputImageFromCameraImage(image, camera);

      if (inputImage == null) {
        return const Left(
          Failure.faceDetection(message: 'Failed to build input image'),
        );
      }

      final faces = await _faceDetectorService.processImage(inputImage);

      final result = FaceDetectionResult(
        faceCount: faces.length,
        faces: FaceMapper.fromMlKitFaces(faces),
        timestamp: DateTime.now(),
      );

      return Right(result);
    } catch (e) {
      return Left(
        Failure.faceDetection(message: 'Face detection failed: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, CapturedFrame>> captureFrame({
    required DetectedFaceEntity face,
    required Size imageSize,
  }) async {
    try {
      final bytes = await _cameraService.captureImageBytes();

      if (bytes == null) {
        return const Left(
          Failure.camera(message: 'Failed to capture image'),
        );
      }

      final frame = CapturedFrame(
        imageBytes: bytes,
        capturedAt: DateTime.now(),
        face: face,
        imageSize: imageSize,
      );

      return Right(frame);
    } catch (e) {
      return Left(
        Failure.camera(message: 'Capture failed: $e'),
      );
    }
  }
}
