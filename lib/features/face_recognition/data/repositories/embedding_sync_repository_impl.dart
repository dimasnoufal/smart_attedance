import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attedance/core/error/exceptions.dart';
import 'package:smart_attedance/core/error/failures.dart';
import 'package:smart_attedance/features/face_recognition/data/services/local_database_service.dart';
import 'package:smart_attedance/features/face_recognition/data/services/sync_api_client.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/user_embedding_entity.dart';
import 'package:smart_attedance/features/face_recognition/domain/repositories/embedding_sync_repository.dart';
import 'dart:developer' as dev;

@LazySingleton(as: EmbeddingSyncRepository)
class EmbeddingSyncRepositoryImpl implements EmbeddingSyncRepository {
  final SyncApiClient _apiClient;
  final LocalDatabaseService _localDb;

  static const String _prefVersionKey = 'last_sync_version';

  EmbeddingSyncRepositoryImpl(this._apiClient, this._localDb);

  @override
  Future<Either<Failure, int>> syncEmbeddings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int currentVersion = prefs.getInt(_prefVersionKey) ?? 0;
      int recordsProcessed = 0;
      bool hasMore = true;

      // Loop until has_more is false
      while (hasMore) {
        final response = await _apiClient.fetchEmbeddings(
          version: currentVersion,
        );

        dev.log('Response sync embeddings: $response');

        final responseVersion = response['version'] as int;
        hasMore = response['has_more'] as bool;
        final data = response['data'] as List<dynamic>;

        for (final item in data) {
          final action = item['action'] as String;
          final userId = item['user_id'] as String;
          final name = (item['name'] as String?) ?? '';

          if (action == 'upsert') {
            final embeddingList = (item['embedding'] as List<dynamic>)
                .map((e) => (e as num).toDouble())
                .toList();

            await _localDb.upsertEmbedding(
              UserEmbeddingEntity(userId: userId, name: name, embedding: embeddingList),
            );
          } else if (action == 'delete') {
            await _localDb.deleteEmbedding(userId);
          }
          recordsProcessed++;
        }

        // Update the current version to fetch the next batch if there's more
        currentVersion = responseVersion;
      }

      // Save the latest version after full sync
      await prefs.setInt(_prefVersionKey, currentVersion);

      return Right(recordsProcessed);
    } catch (e) {
      return Left(Failure.unexpected(message: 'Sync failed: $e'));
    }
  }
}
