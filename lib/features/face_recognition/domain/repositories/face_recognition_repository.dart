import 'package:dartz/dartz.dart';
import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/user_embedding_entity.dart';

/// Repository for handling TFLite local face recognition processes.
abstract class FaceRecognitionRepository {
  /// Extracts a 512-dimensional vector embedding from a CapturedFrame using TFLite.
  Future<Either<Failure, List<double>>> extractEmbedding(CapturedFrame frame);

  /// Retrieves all embeddings stored in the local SQLite database.
  Future<Either<Failure, List<UserEmbeddingEntity>>> getAllLocalEmbeddings();
}
