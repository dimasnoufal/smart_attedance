import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/features/face_recognition/domain/repositories/embedding_sync_repository.dart';

@lazySingleton
class SyncEmbeddingsUseCase implements UseCase<int, NoParams> {
  final EmbeddingSyncRepository _repository;

  SyncEmbeddingsUseCase(this._repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await _repository.syncEmbeddings();
  }
}
