import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_embedding_entity.freezed.dart';
part 'user_embedding_entity.g.dart';

/// Represents a single user's face embedding from the database.
@freezed
abstract class UserEmbeddingEntity with _$UserEmbeddingEntity {
  const factory UserEmbeddingEntity({
    @JsonKey(name: 'user_id') required String userId,
    @Default('') String name,
    required List<double> embedding,
  }) = _UserEmbeddingEntity;

  factory UserEmbeddingEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEmbeddingEntityFromJson(json);
}
