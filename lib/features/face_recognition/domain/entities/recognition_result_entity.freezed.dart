// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recognition_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecognitionResultEntity {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognitionResultEntity);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecognitionResultEntity()';
}


}

/// @nodoc
class $RecognitionResultEntityCopyWith<$Res>  {
$RecognitionResultEntityCopyWith(RecognitionResultEntity _, $Res Function(RecognitionResultEntity) __);
}


/// Adds pattern-matching-related methods to [RecognitionResultEntity].
extension RecognitionResultEntityPatterns on RecognitionResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecognizedFace value)?  recognized,TResult Function( UnrecognizedFace value)?  unrecognized,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecognizedFace() when recognized != null:
return recognized(_that);case UnrecognizedFace() when unrecognized != null:
return unrecognized(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecognizedFace value)  recognized,required TResult Function( UnrecognizedFace value)  unrecognized,}){
final _that = this;
switch (_that) {
case RecognizedFace():
return recognized(_that);case UnrecognizedFace():
return unrecognized(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecognizedFace value)?  recognized,TResult? Function( UnrecognizedFace value)?  unrecognized,}){
final _that = this;
switch (_that) {
case RecognizedFace() when recognized != null:
return recognized(_that);case UnrecognizedFace() when unrecognized != null:
return unrecognized(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId,  String name,  double similarityScore)?  recognized,TResult Function( double highestSimilarityScore)?  unrecognized,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecognizedFace() when recognized != null:
return recognized(_that.userId,_that.name,_that.similarityScore);case UnrecognizedFace() when unrecognized != null:
return unrecognized(_that.highestSimilarityScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId,  String name,  double similarityScore)  recognized,required TResult Function( double highestSimilarityScore)  unrecognized,}) {final _that = this;
switch (_that) {
case RecognizedFace():
return recognized(_that.userId,_that.name,_that.similarityScore);case UnrecognizedFace():
return unrecognized(_that.highestSimilarityScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId,  String name,  double similarityScore)?  recognized,TResult? Function( double highestSimilarityScore)?  unrecognized,}) {final _that = this;
switch (_that) {
case RecognizedFace() when recognized != null:
return recognized(_that.userId,_that.name,_that.similarityScore);case UnrecognizedFace() when unrecognized != null:
return unrecognized(_that.highestSimilarityScore);case _:
  return null;

}
}

}

/// @nodoc


class RecognizedFace implements RecognitionResultEntity {
  const RecognizedFace({required this.userId, this.name = '', required this.similarityScore});
  

 final  String userId;
@JsonKey() final  String name;
 final  double similarityScore;

/// Create a copy of RecognitionResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognizedFaceCopyWith<RecognizedFace> get copyWith => _$RecognizedFaceCopyWithImpl<RecognizedFace>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognizedFace&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.similarityScore, similarityScore) || other.similarityScore == similarityScore));
}


@override
int get hashCode => Object.hash(runtimeType,userId,name,similarityScore);

@override
String toString() {
  return 'RecognitionResultEntity.recognized(userId: $userId, name: $name, similarityScore: $similarityScore)';
}


}

/// @nodoc
abstract mixin class $RecognizedFaceCopyWith<$Res> implements $RecognitionResultEntityCopyWith<$Res> {
  factory $RecognizedFaceCopyWith(RecognizedFace value, $Res Function(RecognizedFace) _then) = _$RecognizedFaceCopyWithImpl;
@useResult
$Res call({
 String userId, String name, double similarityScore
});




}
/// @nodoc
class _$RecognizedFaceCopyWithImpl<$Res>
    implements $RecognizedFaceCopyWith<$Res> {
  _$RecognizedFaceCopyWithImpl(this._self, this._then);

  final RecognizedFace _self;
  final $Res Function(RecognizedFace) _then;

/// Create a copy of RecognitionResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? similarityScore = null,}) {
  return _then(RecognizedFace(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,similarityScore: null == similarityScore ? _self.similarityScore : similarityScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class UnrecognizedFace implements RecognitionResultEntity {
  const UnrecognizedFace({required this.highestSimilarityScore});
  

 final  double highestSimilarityScore;

/// Create a copy of RecognitionResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnrecognizedFaceCopyWith<UnrecognizedFace> get copyWith => _$UnrecognizedFaceCopyWithImpl<UnrecognizedFace>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnrecognizedFace&&(identical(other.highestSimilarityScore, highestSimilarityScore) || other.highestSimilarityScore == highestSimilarityScore));
}


@override
int get hashCode => Object.hash(runtimeType,highestSimilarityScore);

@override
String toString() {
  return 'RecognitionResultEntity.unrecognized(highestSimilarityScore: $highestSimilarityScore)';
}


}

/// @nodoc
abstract mixin class $UnrecognizedFaceCopyWith<$Res> implements $RecognitionResultEntityCopyWith<$Res> {
  factory $UnrecognizedFaceCopyWith(UnrecognizedFace value, $Res Function(UnrecognizedFace) _then) = _$UnrecognizedFaceCopyWithImpl;
@useResult
$Res call({
 double highestSimilarityScore
});




}
/// @nodoc
class _$UnrecognizedFaceCopyWithImpl<$Res>
    implements $UnrecognizedFaceCopyWith<$Res> {
  _$UnrecognizedFaceCopyWithImpl(this._self, this._then);

  final UnrecognizedFace _self;
  final $Res Function(UnrecognizedFace) _then;

/// Create a copy of RecognitionResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? highestSimilarityScore = null,}) {
  return _then(UnrecognizedFace(
highestSimilarityScore: null == highestSimilarityScore ? _self.highestSimilarityScore : highestSimilarityScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
