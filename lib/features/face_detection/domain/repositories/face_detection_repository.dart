import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_detection_result.dart';

/// Abstract repository contract for face detection operations.
/// Implemented in the data layer — domain layer has no knowledge of ML Kit.
abstract class FaceDetectionRepository {
  /// Process a camera frame and return detected faces.
  Future<Either<Failure, FaceDetectionResult>> detectFaces({
    required CameraImage image,
    required CameraDescription camera,
  });

  /// Capture current camera frame as in-memory image bytes.
  Future<Either<Failure, CapturedFrame>> captureFrame({
    required DetectedFaceEntity face,
    required Size imageSize,
  });
}
