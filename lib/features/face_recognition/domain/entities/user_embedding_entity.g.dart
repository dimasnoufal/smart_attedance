// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_embedding_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEmbeddingEntity _$UserEmbeddingEntityFromJson(Map<String, dynamic> json) =>
    _UserEmbeddingEntity(
      userId: json['user_id'] as String,
      name: json['name'] as String? ?? '',
      embedding: (json['embedding'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$UserEmbeddingEntityToJson(
  _UserEmbeddingEntity instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'name': instance.name,
  'embedding': instance.embedding,
};
