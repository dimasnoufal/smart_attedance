import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_recognition/domain/repositories/face_recognition_repository.dart';

@lazySingleton
class ExtractEmbeddingUseCase implements UseCase<List<double>, CapturedFrame> {
  final FaceRecognitionRepository _repository;

  ExtractEmbeddingUseCase(this._repository);

  @override
  Future<Either<Failure, List<double>>> call(CapturedFrame params) async {
    return await _repository.extractEmbedding(params);
  }
}
