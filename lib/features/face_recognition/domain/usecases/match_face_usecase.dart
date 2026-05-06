import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/recognition_result_entity.dart';
import 'package:smart_attedance/features/face_recognition/domain/repositories/face_recognition_repository.dart';
import 'package:smart_attedance/features/face_recognition/domain/utils/cosine_similarity.dart';
import 'dart:developer' as dev;

/// Parameters for matching a face embedding against the database.
class MatchFaceParams {
  /// The 512-dimension vector from the live camera capture.
  final List<double> capturedEmbedding;

  /// The minimum cosine similarity score to consider it a match (0.0 to 1.0).
  /// Default is 0.55 based on buffalo_s optimal thresholds.
  final double threshold;

  const MatchFaceParams({
    required this.capturedEmbedding,
    this.threshold = 0.55,
  });
}

@lazySingleton
class MatchFaceUseCase
    implements UseCase<RecognitionResultEntity, MatchFaceParams> {
  final FaceRecognitionRepository _repository;

  MatchFaceUseCase(this._repository);

  @override
  Future<Either<Failure, RecognitionResultEntity>> call(
    MatchFaceParams params,
  ) async {
    // 1. Get all stored embeddings from Local SQLite DB
    final dbResult = await _repository.getAllLocalEmbeddings();

    return dbResult.fold((failure) => Left(failure), (storedEmbeddings) {
      if (storedEmbeddings.isEmpty) {
        // If database is empty, return unrecognized immediately
        return Right(
          const RecognitionResultEntity.unrecognized(
            highestSimilarityScore: 0.0,
          ),
        );
      }

      double highestScore = -1.0; // Cosine similarity ranges from -1 to 1
      String? matchedUserId;

      // 2. Loop through all database records and calculate Cosine Similarity
      for (final record in storedEmbeddings) {
        final score = CosineSimilarityCalculator.calculate(
          params.capturedEmbedding,
          record.embedding,
        );

        dev.log('Score for ${record.userId}: $score');

        if (score > highestScore) {
          highestScore = score;
          matchedUserId = record.userId;
        }
      }

      // 3. Compare the highest score against the threshold
      if (highestScore >= params.threshold && matchedUserId != null) {
        return Right(
          RecognitionResultEntity.recognized(
            userId: matchedUserId,
            similarityScore: highestScore,
          ),
        );
      } else {
        return Right(
          RecognitionResultEntity.unrecognized(
            highestSimilarityScore: highestScore,
          ),
        );
      }
    });
  }
}
