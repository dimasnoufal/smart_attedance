// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captured_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CapturedFrame {

 Uint8List get imageBytes; DateTime get capturedAt; DetectedFaceEntity get face; Size get imageSize;
/// Create a copy of CapturedFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapturedFrameCopyWith<CapturedFrame> get copyWith => _$CapturedFrameCopyWithImpl<CapturedFrame>(this as CapturedFrame, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapturedFrame&&const DeepCollectionEquality().equals(other.imageBytes, imageBytes)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.face, face) || other.face == face)&&(identical(other.imageSize, imageSize) || other.imageSize == imageSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(imageBytes),capturedAt,face,imageSize);

@override
String toString() {
  return 'CapturedFrame(imageBytes: $imageBytes, capturedAt: $capturedAt, face: $face, imageSize: $imageSize)';
}


}

/// @nodoc
abstract mixin class $CapturedFrameCopyWith<$Res>  {
  factory $CapturedFrameCopyWith(CapturedFrame value, $Res Function(CapturedFrame) _then) = _$CapturedFrameCopyWithImpl;
@useResult
$Res call({
 Uint8List imageBytes, DateTime capturedAt, DetectedFaceEntity face, Size imageSize
});


$DetectedFaceEntityCopyWith<$Res> get face;

}
/// @nodoc
class _$CapturedFrameCopyWithImpl<$Res>
    implements $CapturedFrameCopyWith<$Res> {
  _$CapturedFrameCopyWithImpl(this._self, this._then);

  final CapturedFrame _self;
  final $Res Function(CapturedFrame) _then;

/// Create a copy of CapturedFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageBytes = null,Object? capturedAt = null,Object? face = null,Object? imageSize = null,}) {
  return _then(_self.copyWith(
imageBytes: null == imageBytes ? _self.imageBytes : imageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as DetectedFaceEntity,imageSize: null == imageSize ? _self.imageSize : imageSize // ignore: cast_nullable_to_non_nullable
as Size,
  ));
}
/// Create a copy of CapturedFrame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectedFaceEntityCopyWith<$Res> get face {
  
  return $DetectedFaceEntityCopyWith<$Res>(_self.face, (value) {
    return _then(_self.copyWith(face: value));
  });
}
}


/// Adds pattern-matching-related methods to [CapturedFrame].
extension CapturedFramePatterns on CapturedFrame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapturedFrame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapturedFrame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapturedFrame value)  $default,){
final _that = this;
switch (_that) {
case _CapturedFrame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapturedFrame value)?  $default,){
final _that = this;
switch (_that) {
case _CapturedFrame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uint8List imageBytes,  DateTime capturedAt,  DetectedFaceEntity face,  Size imageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapturedFrame() when $default != null:
return $default(_that.imageBytes,_that.capturedAt,_that.face,_that.imageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uint8List imageBytes,  DateTime capturedAt,  DetectedFaceEntity face,  Size imageSize)  $default,) {final _that = this;
switch (_that) {
case _CapturedFrame():
return $default(_that.imageBytes,_that.capturedAt,_that.face,_that.imageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uint8List imageBytes,  DateTime capturedAt,  DetectedFaceEntity face,  Size imageSize)?  $default,) {final _that = this;
switch (_that) {
case _CapturedFrame() when $default != null:
return $default(_that.imageBytes,_that.capturedAt,_that.face,_that.imageSize);case _:
  return null;

}
}

}

/// @nodoc


class _CapturedFrame implements CapturedFrame {
  const _CapturedFrame({required this.imageBytes, required this.capturedAt, required this.face, required this.imageSize});
  

@override final  Uint8List imageBytes;
@override final  DateTime capturedAt;
@override final  DetectedFaceEntity face;
@override final  Size imageSize;

/// Create a copy of CapturedFrame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapturedFrameCopyWith<_CapturedFrame> get copyWith => __$CapturedFrameCopyWithImpl<_CapturedFrame>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapturedFrame&&const DeepCollectionEquality().equals(other.imageBytes, imageBytes)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.face, face) || other.face == face)&&(identical(other.imageSize, imageSize) || other.imageSize == imageSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(imageBytes),capturedAt,face,imageSize);

@override
String toString() {
  return 'CapturedFrame(imageBytes: $imageBytes, capturedAt: $capturedAt, face: $face, imageSize: $imageSize)';
}


}

/// @nodoc
abstract mixin class _$CapturedFrameCopyWith<$Res> implements $CapturedFrameCopyWith<$Res> {
  factory _$CapturedFrameCopyWith(_CapturedFrame value, $Res Function(_CapturedFrame) _then) = __$CapturedFrameCopyWithImpl;
@override @useResult
$Res call({
 Uint8List imageBytes, DateTime capturedAt, DetectedFaceEntity face, Size imageSize
});


@override $DetectedFaceEntityCopyWith<$Res> get face;

}
/// @nodoc
class __$CapturedFrameCopyWithImpl<$Res>
    implements _$CapturedFrameCopyWith<$Res> {
  __$CapturedFrameCopyWithImpl(this._self, this._then);

  final _CapturedFrame _self;
  final $Res Function(_CapturedFrame) _then;

/// Create a copy of CapturedFrame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageBytes = null,Object? capturedAt = null,Object? face = null,Object? imageSize = null,}) {
  return _then(_CapturedFrame(
imageBytes: null == imageBytes ? _self.imageBytes : imageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,face: null == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as DetectedFaceEntity,imageSize: null == imageSize ? _self.imageSize : imageSize // ignore: cast_nullable_to_non_nullable
as Size,
  ));
}

/// Create a copy of CapturedFrame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectedFaceEntityCopyWith<$Res> get face {
  
  return $DetectedFaceEntityCopyWith<$Res>(_self.face, (value) {
    return _then(_self.copyWith(face: value));
  });
}
}

// dart format on
