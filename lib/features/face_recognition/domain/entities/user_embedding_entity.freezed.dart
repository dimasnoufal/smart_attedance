// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_embedding_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserEmbeddingEntity {

@JsonKey(name: 'user_id') String get userId; String get name; List<double> get embedding;
/// Create a copy of UserEmbeddingEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEmbeddingEntityCopyWith<UserEmbeddingEntity> get copyWith => _$UserEmbeddingEntityCopyWithImpl<UserEmbeddingEntity>(this as UserEmbeddingEntity, _$identity);

  /// Serializes this UserEmbeddingEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEmbeddingEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.embedding, embedding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,const DeepCollectionEquality().hash(embedding));

@override
String toString() {
  return 'UserEmbeddingEntity(userId: $userId, name: $name, embedding: $embedding)';
}


}

/// @nodoc
abstract mixin class $UserEmbeddingEntityCopyWith<$Res>  {
  factory $UserEmbeddingEntityCopyWith(UserEmbeddingEntity value, $Res Function(UserEmbeddingEntity) _then) = _$UserEmbeddingEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String name, List<double> embedding
});




}
/// @nodoc
class _$UserEmbeddingEntityCopyWithImpl<$Res>
    implements $UserEmbeddingEntityCopyWith<$Res> {
  _$UserEmbeddingEntityCopyWithImpl(this._self, this._then);

  final UserEmbeddingEntity _self;
  final $Res Function(UserEmbeddingEntity) _then;

/// Create a copy of UserEmbeddingEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = null,Object? embedding = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,embedding: null == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEmbeddingEntity].
extension UserEmbeddingEntityPatterns on UserEmbeddingEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEmbeddingEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEmbeddingEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEmbeddingEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEmbeddingEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEmbeddingEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEmbeddingEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String name,  List<double> embedding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEmbeddingEntity() when $default != null:
return $default(_that.userId,_that.name,_that.embedding);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String name,  List<double> embedding)  $default,) {final _that = this;
switch (_that) {
case _UserEmbeddingEntity():
return $default(_that.userId,_that.name,_that.embedding);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId,  String name,  List<double> embedding)?  $default,) {final _that = this;
switch (_that) {
case _UserEmbeddingEntity() when $default != null:
return $default(_that.userId,_that.name,_that.embedding);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserEmbeddingEntity implements UserEmbeddingEntity {
  const _UserEmbeddingEntity({@JsonKey(name: 'user_id') required this.userId, this.name = '', required final  List<double> embedding}): _embedding = embedding;
  factory _UserEmbeddingEntity.fromJson(Map<String, dynamic> json) => _$UserEmbeddingEntityFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey() final  String name;
 final  List<double> _embedding;
@override List<double> get embedding {
  if (_embedding is EqualUnmodifiableListView) return _embedding;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_embedding);
}


/// Create a copy of UserEmbeddingEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEmbeddingEntityCopyWith<_UserEmbeddingEntity> get copyWith => __$UserEmbeddingEntityCopyWithImpl<_UserEmbeddingEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEmbeddingEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEmbeddingEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._embedding, _embedding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,const DeepCollectionEquality().hash(_embedding));

@override
String toString() {
  return 'UserEmbeddingEntity(userId: $userId, name: $name, embedding: $embedding)';
}


}

/// @nodoc
abstract mixin class _$UserEmbeddingEntityCopyWith<$Res> implements $UserEmbeddingEntityCopyWith<$Res> {
  factory _$UserEmbeddingEntityCopyWith(_UserEmbeddingEntity value, $Res Function(_UserEmbeddingEntity) _then) = __$UserEmbeddingEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String name, List<double> embedding
});




}
/// @nodoc
class __$UserEmbeddingEntityCopyWithImpl<$Res>
    implements _$UserEmbeddingEntityCopyWith<$Res> {
  __$UserEmbeddingEntityCopyWithImpl(this._self, this._then);

  final _UserEmbeddingEntity _self;
  final $Res Function(_UserEmbeddingEntity) _then;

/// Create a copy of UserEmbeddingEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? embedding = null,}) {
  return _then(_UserEmbeddingEntity(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,embedding: null == embedding ? _self._embedding : embedding // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
