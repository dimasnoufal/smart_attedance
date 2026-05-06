import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/exceptions.dart';
import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_recognition/data/services/local_database_service.dart';
import 'package:smart_attedance/features/face_recognition/data/services/tflite_recognizer_service.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/user_embedding_entity.dart';
import 'package:smart_attedance/features/face_recognition/domain/repositories/face_recognition_repository.dart';
import 'dart:developer' as dev;

@LazySingleton(as: FaceRecognitionRepository)
class FaceRecognitionRepositoryImpl implements FaceRecognitionRepository {
  final TFLiteRecognizerService _tfliteService;
  final LocalDatabaseService _localDb;

  FaceRecognitionRepositoryImpl(this._tfliteService, this._localDb);

  @override
  Future<Either<Failure, List<double>>> extractEmbedding(
    CapturedFrame frame,
  ) async {
    try {
      final embedding = await _tfliteService.extractEmbedding(frame);
      dev.log('extractEmbedding results: $embedding');
      return Right(embedding);
    } on CameraServiceException catch (e) {
      return Left(Failure.camera(message: e.message));
    } on FaceDetectionProcessException catch (e) {
      return Left(Failure.faceDetection(message: e.message));
    } catch (e) {
      return Left(
        Failure.unexpected(message: 'Failed to extract embedding: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserEmbeddingEntity>>>
  getAllLocalEmbeddings() async {
    try {
      final embeddings = await _localDb.getAllEmbeddings();
      return Right(embeddings);
    } catch (e) {
      return Left(Failure.unexpected(message: 'Failed to read SQLite: $e'));
    }
  }
}
