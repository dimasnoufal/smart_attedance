// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detected_face_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetectedFaceEntity {

 FaceBounds get boundingBox; double? get headEulerAngleY; double? get headEulerAngleX; double? get headEulerAngleZ; double? get smilingProbability; double? get leftEyeOpenProbability; double? get rightEyeOpenProbability; int? get trackingId;
/// Create a copy of DetectedFaceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetectedFaceEntityCopyWith<DetectedFaceEntity> get copyWith => _$DetectedFaceEntityCopyWithImpl<DetectedFaceEntity>(this as DetectedFaceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectedFaceEntity&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.headEulerAngleY, headEulerAngleY) || other.headEulerAngleY == headEulerAngleY)&&(identical(other.headEulerAngleX, headEulerAngleX) || other.headEulerAngleX == headEulerAngleX)&&(identical(other.headEulerAngleZ, headEulerAngleZ) || other.headEulerAngleZ == headEulerAngleZ)&&(identical(other.smilingProbability, smilingProbability) || other.smilingProbability == smilingProbability)&&(identical(other.leftEyeOpenProbability, leftEyeOpenProbability) || other.leftEyeOpenProbability == leftEyeOpenProbability)&&(identical(other.rightEyeOpenProbability, rightEyeOpenProbability) || other.rightEyeOpenProbability == rightEyeOpenProbability)&&(identical(other.trackingId, trackingId) || other.trackingId == trackingId));
}


@override
int get hashCode => Object.hash(runtimeType,boundingBox,headEulerAngleY,headEulerAngleX,headEulerAngleZ,smilingProbability,leftEyeOpenProbability,rightEyeOpenProbability,trackingId);

@override
String toString() {
  return 'DetectedFaceEntity(boundingBox: $boundingBox, headEulerAngleY: $headEulerAngleY, headEulerAngleX: $headEulerAngleX, headEulerAngleZ: $headEulerAngleZ, smilingProbability: $smilingProbability, leftEyeOpenProbability: $leftEyeOpenProbability, rightEyeOpenProbability: $rightEyeOpenProbability, trackingId: $trackingId)';
}


}

/// @nodoc
abstract mixin class $DetectedFaceEntityCopyWith<$Res>  {
  factory $DetectedFaceEntityCopyWith(DetectedFaceEntity value, $Res Function(DetectedFaceEntity) _then) = _$DetectedFaceEntityCopyWithImpl;
@useResult
$Res call({
 FaceBounds boundingBox, double? headEulerAngleY, double? headEulerAngleX, double? headEulerAngleZ, double? smilingProbability, double? leftEyeOpenProbability, double? rightEyeOpenProbability, int? trackingId
});


$FaceBoundsCopyWith<$Res> get boundingBox;

}
/// @nodoc
class _$DetectedFaceEntityCopyWithImpl<$Res>
    implements $DetectedFaceEntityCopyWith<$Res> {
  _$DetectedFaceEntityCopyWithImpl(this._self, this._then);

  final DetectedFaceEntity _self;
  final $Res Function(DetectedFaceEntity) _then;

/// Create a copy of DetectedFaceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? boundingBox = null,Object? headEulerAngleY = freezed,Object? headEulerAngleX = freezed,Object? headEulerAngleZ = freezed,Object? smilingProbability = freezed,Object? leftEyeOpenProbability = freezed,Object? rightEyeOpenProbability = freezed,Object? trackingId = freezed,}) {
  return _then(_self.copyWith(
boundingBox: null == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as FaceBounds,headEulerAngleY: freezed == headEulerAngleY ? _self.headEulerAngleY : headEulerAngleY // ignore: cast_nullable_to_non_nullable
as double?,headEulerAngleX: freezed == headEulerAngleX ? _self.headEulerAngleX : headEulerAngleX // ignore: cast_nullable_to_non_nullable
as double?,headEulerAngleZ: freezed == headEulerAngleZ ? _self.headEulerAngleZ : headEulerAngleZ // ignore: cast_nullable_to_non_nullable
as double?,smilingProbability: freezed == smilingProbability ? _self.smilingProbability : smilingProbability // ignore: cast_nullable_to_non_nullable
as double?,leftEyeOpenProbability: freezed == leftEyeOpenProbability ? _self.leftEyeOpenProbability : leftEyeOpenProbability // ignore: cast_nullable_to_non_nullable
as double?,rightEyeOpenProbability: freezed == rightEyeOpenProbability ? _self.rightEyeOpenProbability : rightEyeOpenProbability // ignore: cast_nullable_to_non_nullable
as double?,trackingId: freezed == trackingId ? _self.trackingId : trackingId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of DetectedFaceEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaceBoundsCopyWith<$Res> get boundingBox {
  
  return $FaceBoundsCopyWith<$Res>(_self.boundingBox, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}


/// Adds pattern-matching-related methods to [DetectedFaceEntity].
extension DetectedFaceEntityPatterns on DetectedFaceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetectedFaceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetectedFaceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetectedFaceEntity value)  $default,){
final _that = this;
switch (_that) {
case _DetectedFaceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetectedFaceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DetectedFaceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FaceBounds boundingBox,  double? headEulerAngleY,  double? headEulerAngleX,  double? headEulerAngleZ,  double? smilingProbability,  double? leftEyeOpenProbability,  double? rightEyeOpenProbability,  int? trackingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetectedFaceEntity() when $default != null:
return $default(_that.boundingBox,_that.headEulerAngleY,_that.headEulerAngleX,_that.headEulerAngleZ,_that.smilingProbability,_that.leftEyeOpenProbability,_that.rightEyeOpenProbability,_that.trackingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FaceBounds boundingBox,  double? headEulerAngleY,  double? headEulerAngleX,  double? headEulerAngleZ,  double? smilingProbability,  double? leftEyeOpenProbability,  double? rightEyeOpenProbability,  int? trackingId)  $default,) {final _that = this;
switch (_that) {
case _DetectedFaceEntity():
return $default(_that.boundingBox,_that.headEulerAngleY,_that.headEulerAngleX,_that.headEulerAngleZ,_that.smilingProbability,_that.leftEyeOpenProbability,_that.rightEyeOpenProbability,_that.trackingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FaceBounds boundingBox,  double? headEulerAngleY,  double? headEulerAngleX,  double? headEulerAngleZ,  double? smilingProbability,  double? leftEyeOpenProbability,  double? rightEyeOpenProbability,  int? trackingId)?  $default,) {final _that = this;
switch (_that) {
case _DetectedFaceEntity() when $default != null:
return $default(_that.boundingBox,_that.headEulerAngleY,_that.headEulerAngleX,_that.headEulerAngleZ,_that.smilingProbability,_that.leftEyeOpenProbability,_that.rightEyeOpenProbability,_that.trackingId);case _:
  return null;

}
}

}

/// @nodoc


class _DetectedFaceEntity implements DetectedFaceEntity {
  const _DetectedFaceEntity({required this.boundingBox, this.headEulerAngleY, this.headEulerAngleX, this.headEulerAngleZ, this.smilingProbability, this.leftEyeOpenProbability, this.rightEyeOpenProbability, this.trackingId});
  

@override final  FaceBounds boundingBox;
@override final  double? headEulerAngleY;
@override final  double? headEulerAngleX;
@override final  double? headEulerAngleZ;
@override final  double? smilingProbability;
@override final  double? leftEyeOpenProbability;
@override final  double? rightEyeOpenProbability;
@override final  int? trackingId;

/// Create a copy of DetectedFaceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetectedFaceEntityCopyWith<_DetectedFaceEntity> get copyWith => __$DetectedFaceEntityCopyWithImpl<_DetectedFaceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetectedFaceEntity&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.headEulerAngleY, headEulerAngleY) || other.headEulerAngleY == headEulerAngleY)&&(identical(other.headEulerAngleX, headEulerAngleX) || other.headEulerAngleX == headEulerAngleX)&&(identical(other.headEulerAngleZ, headEulerAngleZ) || other.headEulerAngleZ == headEulerAngleZ)&&(identical(other.smilingProbability, smilingProbability) || other.smilingProbability == smilingProbability)&&(identical(other.leftEyeOpenProbability, leftEyeOpenProbability) || other.leftEyeOpenProbability == leftEyeOpenProbability)&&(identical(other.rightEyeOpenProbability, rightEyeOpenProbability) || other.rightEyeOpenProbability == rightEyeOpenProbability)&&(identical(other.trackingId, trackingId) || other.trackingId == trackingId));
}


@override
int get hashCode => Object.hash(runtimeType,boundingBox,headEulerAngleY,headEulerAngleX,headEulerAngleZ,smilingProbability,leftEyeOpenProbability,rightEyeOpenProbability,trackingId);

@override
String toString() {
  return 'DetectedFaceEntity(boundingBox: $boundingBox, headEulerAngleY: $headEulerAngleY, headEulerAngleX: $headEulerAngleX, headEulerAngleZ: $headEulerAngleZ, smilingProbability: $smilingProbability, leftEyeOpenProbability: $leftEyeOpenProbability, rightEyeOpenProbability: $rightEyeOpenProbability, trackingId: $trackingId)';
}


}

/// @nodoc
abstract mixin class _$DetectedFaceEntityCopyWith<$Res> implements $DetectedFaceEntityCopyWith<$Res> {
  factory _$DetectedFaceEntityCopyWith(_DetectedFaceEntity value, $Res Function(_DetectedFaceEntity) _then) = __$DetectedFaceEntityCopyWithImpl;
@override @useResult
$Res call({
 FaceBounds boundingBox, double? headEulerAngleY, double? headEulerAngleX, double? headEulerAngleZ, double? smilingProbability, double? leftEyeOpenProbability, double? rightEyeOpenProbability, int? trackingId
});


@override $FaceBoundsCopyWith<$Res> get boundingBox;

}
/// @nodoc
class __$DetectedFaceEntityCopyWithImpl<$Res>
    implements _$DetectedFaceEntityCopyWith<$Res> {
  __$DetectedFaceEntityCopyWithImpl(this._self, this._then);

  final _DetectedFaceEntity _self;
  final $Res Function(_DetectedFaceEntity) _then;

/// Create a copy of DetectedFaceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? boundingBox = null,Object? headEulerAngleY = freezed,Object? headEulerAngleX = freezed,Object? headEulerAngleZ = freezed,Object? smilingProbability = freezed,Object? leftEyeOpenProbability = freezed,Object? rightEyeOpenProbability = freezed,Object? trackingId = freezed,}) {
  return _then(_DetectedFaceEntity(
boundingBox: null == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as FaceBounds,headEulerAngleY: freezed == headEulerAngleY ? _self.headEulerAngleY : headEulerAngleY // ignore: cast_nullable_to_non_nullable
as double?,headEulerAngleX: freezed == headEulerAngleX ? _self.headEulerAngleX : headEulerAngleX // ignore: cast_nullable_to_non_nullable
as double?,headEulerAngleZ: freezed == headEulerAngleZ ? _self.headEulerAngleZ : headEulerAngleZ // ignore: cast_nullable_to_non_nullable
as double?,smilingProbability: freezed == smilingProbability ? _self.smilingProbability : smilingProbability // ignore: cast_nullable_to_non_nullable
as double?,leftEyeOpenProbability: freezed == leftEyeOpenProbability ? _self.leftEyeOpenProbability : leftEyeOpenProbability // ignore: cast_nullable_to_non_nullable
as double?,rightEyeOpenProbability: freezed == rightEyeOpenProbability ? _self.rightEyeOpenProbability : rightEyeOpenProbability // ignore: cast_nullable_to_non_nullable
as double?,trackingId: freezed == trackingId ? _self.trackingId : trackingId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of DetectedFaceEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaceBoundsCopyWith<$Res> get boundingBox {
  
  return $FaceBoundsCopyWith<$Res>(_self.boundingBox, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}

// dart format on
