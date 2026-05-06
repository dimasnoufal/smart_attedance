// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_detection_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FaceDetectionResult {

 int get faceCount; List<DetectedFaceEntity> get faces; DateTime get timestamp;
/// Create a copy of FaceDetectionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceDetectionResultCopyWith<FaceDetectionResult> get copyWith => _$FaceDetectionResultCopyWithImpl<FaceDetectionResult>(this as FaceDetectionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionResult&&(identical(other.faceCount, faceCount) || other.faceCount == faceCount)&&const DeepCollectionEquality().equals(other.faces, faces)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,faceCount,const DeepCollectionEquality().hash(faces),timestamp);

@override
String toString() {
  return 'FaceDetectionResult(faceCount: $faceCount, faces: $faces, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $FaceDetectionResultCopyWith<$Res>  {
  factory $FaceDetectionResultCopyWith(FaceDetectionResult value, $Res Function(FaceDetectionResult) _then) = _$FaceDetectionResultCopyWithImpl;
@useResult
$Res call({
 int faceCount, List<DetectedFaceEntity> faces, DateTime timestamp
});




}
/// @nodoc
class _$FaceDetectionResultCopyWithImpl<$Res>
    implements $FaceDetectionResultCopyWith<$Res> {
  _$FaceDetectionResultCopyWithImpl(this._self, this._then);

  final FaceDetectionResult _self;
  final $Res Function(FaceDetectionResult) _then;

/// Create a copy of FaceDetectionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? faceCount = null,Object? faces = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
faceCount: null == faceCount ? _self.faceCount : faceCount // ignore: cast_nullable_to_non_nullable
as int,faces: null == faces ? _self.faces : faces // ignore: cast_nullable_to_non_nullable
as List<DetectedFaceEntity>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FaceDetectionResult].
extension FaceDetectionResultPatterns on FaceDetectionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaceDetectionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaceDetectionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaceDetectionResult value)  $default,){
final _that = this;
switch (_that) {
case _FaceDetectionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaceDetectionResult value)?  $default,){
final _that = this;
switch (_that) {
case _FaceDetectionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int faceCount,  List<DetectedFaceEntity> faces,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaceDetectionResult() when $default != null:
return $default(_that.faceCount,_that.faces,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int faceCount,  List<DetectedFaceEntity> faces,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _FaceDetectionResult():
return $default(_that.faceCount,_that.faces,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int faceCount,  List<DetectedFaceEntity> faces,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _FaceDetectionResult() when $default != null:
return $default(_that.faceCount,_that.faces,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _FaceDetectionResult implements FaceDetectionResult {
  const _FaceDetectionResult({required this.faceCount, required final  List<DetectedFaceEntity> faces, required this.timestamp}): _faces = faces;
  

@override final  int faceCount;
 final  List<DetectedFaceEntity> _faces;
@override List<DetectedFaceEntity> get faces {
  if (_faces is EqualUnmodifiableListView) return _faces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faces);
}

@override final  DateTime timestamp;

/// Create a copy of FaceDetectionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaceDetectionResultCopyWith<_FaceDetectionResult> get copyWith => __$FaceDetectionResultCopyWithImpl<_FaceDetectionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaceDetectionResult&&(identical(other.faceCount, faceCount) || other.faceCount == faceCount)&&const DeepCollectionEquality().equals(other._faces, _faces)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,faceCount,const DeepCollectionEquality().hash(_faces),timestamp);

@override
String toString() {
  return 'FaceDetectionResult(faceCount: $faceCount, faces: $faces, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$FaceDetectionResultCopyWith<$Res> implements $FaceDetectionResultCopyWith<$Res> {
  factory _$FaceDetectionResultCopyWith(_FaceDetectionResult value, $Res Function(_FaceDetectionResult) _then) = __$FaceDetectionResultCopyWithImpl;
@override @useResult
$Res call({
 int faceCount, List<DetectedFaceEntity> faces, DateTime timestamp
});




}
/// @nodoc
class __$FaceDetectionResultCopyWithImpl<$Res>
    implements _$FaceDetectionResultCopyWith<$Res> {
  __$FaceDetectionResultCopyWithImpl(this._self, this._then);

  final _FaceDetectionResult _self;
  final $Res Function(_FaceDetectionResult) _then;

/// Create a copy of FaceDetectionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? faceCount = null,Object? faces = null,Object? timestamp = null,}) {
  return _then(_FaceDetectionResult(
faceCount: null == faceCount ? _self.faceCount : faceCount // ignore: cast_nullable_to_non_nullable
as int,faces: null == faces ? _self._faces : faces // ignore: cast_nullable_to_non_nullable
as List<DetectedFaceEntity>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
