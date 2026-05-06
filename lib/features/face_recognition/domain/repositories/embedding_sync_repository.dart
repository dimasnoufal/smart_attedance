import 'package:dartz/dartz.dart';
import 'package:smart_attedance/core/error/failures.dart';

/// Repository for syncing embeddings from the server to local SQLite.
abstract class EmbeddingSyncRepository {
  /// Fetches embeddings from the API starting from the last known version
  /// and updates the local SQLite database.
  /// 
  /// Returns the number of newly synced records.
  Future<Either<Failure, int>> syncEmbeddings();
}
