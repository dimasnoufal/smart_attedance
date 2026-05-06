// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gate_detection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GateDetectionState {

 GateCameraStatus get cameraStatus; GateProcessStatus get processStatus;/// The currently tracked face (largest face in frame).
 DetectedFaceEntity? get trackedFace;/// Camera frame image size (for coordinate transformation).
 Size? get imageSize;/// Number of faces detected in the current frame.
 int get faceCount;/// Recognition result after successful pipeline.
 RecognitionResultEntity? get recognitionResult;/// Human-readable status message for the UI.
 String get statusMessage;/// Error messages.
 String? get errorMessage;
/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GateDetectionStateCopyWith<GateDetectionState> get copyWith => _$GateDetectionStateCopyWithImpl<GateDetectionState>(this as GateDetectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionState&&(identical(other.cameraStatus, cameraStatus) || other.cameraStatus == cameraStatus)&&(identical(other.processStatus, processStatus) || other.processStatus == processStatus)&&(identical(other.trackedFace, trackedFace) || other.trackedFace == trackedFace)&&(identical(other.imageSize, imageSize) || other.imageSize == imageSize)&&(identical(other.faceCount, faceCount) || other.faceCount == faceCount)&&(identical(other.recognitionResult, recognitionResult) || other.recognitionResult == recognitionResult)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,cameraStatus,processStatus,trackedFace,imageSize,faceCount,recognitionResult,statusMessage,errorMessage);

@override
String toString() {
  return 'GateDetectionState(cameraStatus: $cameraStatus, processStatus: $processStatus, trackedFace: $trackedFace, imageSize: $imageSize, faceCount: $faceCount, recognitionResult: $recognitionResult, statusMessage: $statusMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $GateDetectionStateCopyWith<$Res>  {
  factory $GateDetectionStateCopyWith(GateDetectionState value, $Res Function(GateDetectionState) _then) = _$GateDetectionStateCopyWithImpl;
@useResult
$Res call({
 GateCameraStatus cameraStatus, GateProcessStatus processStatus, DetectedFaceEntity? trackedFace, Size? imageSize, int faceCount, RecognitionResultEntity? recognitionResult, String statusMessage, String? errorMessage
});


$DetectedFaceEntityCopyWith<$Res>? get trackedFace;$RecognitionResultEntityCopyWith<$Res>? get recognitionResult;

}
/// @nodoc
class _$GateDetectionStateCopyWithImpl<$Res>
    implements $GateDetectionStateCopyWith<$Res> {
  _$GateDetectionStateCopyWithImpl(this._self, this._then);

  final GateDetectionState _self;
  final $Res Function(GateDetectionState) _then;

/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cameraStatus = null,Object? processStatus = null,Object? trackedFace = freezed,Object? imageSize = freezed,Object? faceCount = null,Object? recognitionResult = freezed,Object? statusMessage = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
cameraStatus: null == cameraStatus ? _self.cameraStatus : cameraStatus // ignore: cast_nullable_to_non_nullable
as GateCameraStatus,processStatus: null == processStatus ? _self.processStatus : processStatus // ignore: cast_nullable_to_non_nullable
as GateProcessStatus,trackedFace: freezed == trackedFace ? _self.trackedFace : trackedFace // ignore: cast_nullable_to_non_nullable
as DetectedFaceEntity?,imageSize: freezed == imageSize ? _self.imageSize : imageSize // ignore: cast_nullable_to_non_nullable
as Size?,faceCount: null == faceCount ? _self.faceCount : faceCount // ignore: cast_nullable_to_non_nullable
as int,recognitionResult: freezed == recognitionResult ? _self.recognitionResult : recognitionResult // ignore: cast_nullable_to_non_nullable
as RecognitionResultEntity?,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectedFaceEntityCopyWith<$Res>? get trackedFace {
    if (_self.trackedFace == null) {
    return null;
  }

  return $DetectedFaceEntityCopyWith<$Res>(_self.trackedFace!, (value) {
    return _then(_self.copyWith(trackedFace: value));
  });
}/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecognitionResultEntityCopyWith<$Res>? get recognitionResult {
    if (_self.recognitionResult == null) {
    return null;
  }

  return $RecognitionResultEntityCopyWith<$Res>(_self.recognitionResult!, (value) {
    return _then(_self.copyWith(recognitionResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [GateDetectionState].
extension GateDetectionStatePatterns on GateDetectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GateDetectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GateDetectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GateDetectionState value)  $default,){
final _that = this;
switch (_that) {
case _GateDetectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GateDetectionState value)?  $default,){
final _that = this;
switch (_that) {
case _GateDetectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GateCameraStatus cameraStatus,  GateProcessStatus processStatus,  DetectedFaceEntity? trackedFace,  Size? imageSize,  int faceCount,  RecognitionResultEntity? recognitionResult,  String statusMessage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GateDetectionState() when $default != null:
return $default(_that.cameraStatus,_that.processStatus,_that.trackedFace,_that.imageSize,_that.faceCount,_that.recognitionResult,_that.statusMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GateCameraStatus cameraStatus,  GateProcessStatus processStatus,  DetectedFaceEntity? trackedFace,  Size? imageSize,  int faceCount,  RecognitionResultEntity? recognitionResult,  String statusMessage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _GateDetectionState():
return $default(_that.cameraStatus,_that.processStatus,_that.trackedFace,_that.imageSize,_that.faceCount,_that.recognitionResult,_that.statusMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GateCameraStatus cameraStatus,  GateProcessStatus processStatus,  DetectedFaceEntity? trackedFace,  Size? imageSize,  int faceCount,  RecognitionResultEntity? recognitionResult,  String statusMessage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _GateDetectionState() when $default != null:
return $default(_that.cameraStatus,_that.processStatus,_that.trackedFace,_that.imageSize,_that.faceCount,_that.recognitionResult,_that.statusMessage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GateDetectionState implements GateDetectionState {
  const _GateDetectionState({this.cameraStatus = GateCameraStatus.initial, this.processStatus = GateProcessStatus.scanning, this.trackedFace, this.imageSize, this.faceCount = 0, this.recognitionResult, this.statusMessage = 'Arahkan wajah Anda ke kamera', this.errorMessage});
  

@override@JsonKey() final  GateCameraStatus cameraStatus;
@override@JsonKey() final  GateProcessStatus processStatus;
/// The currently tracked face (largest face in frame).
@override final  DetectedFaceEntity? trackedFace;
/// Camera frame image size (for coordinate transformation).
@override final  Size? imageSize;
/// Number of faces detected in the current frame.
@override@JsonKey() final  int faceCount;
/// Recognition result after successful pipeline.
@override final  RecognitionResultEntity? recognitionResult;
/// Human-readable status message for the UI.
@override@JsonKey() final  String statusMessage;
/// Error messages.
@override final  String? errorMessage;

/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GateDetectionStateCopyWith<_GateDetectionState> get copyWith => __$GateDetectionStateCopyWithImpl<_GateDetectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GateDetectionState&&(identical(other.cameraStatus, cameraStatus) || other.cameraStatus == cameraStatus)&&(identical(other.processStatus, processStatus) || other.processStatus == processStatus)&&(identical(other.trackedFace, trackedFace) || other.trackedFace == trackedFace)&&(identical(other.imageSize, imageSize) || other.imageSize == imageSize)&&(identical(other.faceCount, faceCount) || other.faceCount == faceCount)&&(identical(other.recognitionResult, recognitionResult) || other.recognitionResult == recognitionResult)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,cameraStatus,processStatus,trackedFace,imageSize,faceCount,recognitionResult,statusMessage,errorMessage);

@override
String toString() {
  return 'GateDetectionState(cameraStatus: $cameraStatus, processStatus: $processStatus, trackedFace: $trackedFace, imageSize: $imageSize, faceCount: $faceCount, recognitionResult: $recognitionResult, statusMessage: $statusMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GateDetectionStateCopyWith<$Res> implements $GateDetectionStateCopyWith<$Res> {
  factory _$GateDetectionStateCopyWith(_GateDetectionState value, $Res Function(_GateDetectionState) _then) = __$GateDetectionStateCopyWithImpl;
@override @useResult
$Res call({
 GateCameraStatus cameraStatus, GateProcessStatus processStatus, DetectedFaceEntity? trackedFace, Size? imageSize, int faceCount, RecognitionResultEntity? recognitionResult, String statusMessage, String? errorMessage
});


@override $DetectedFaceEntityCopyWith<$Res>? get trackedFace;@override $RecognitionResultEntityCopyWith<$Res>? get recognitionResult;

}
/// @nodoc
class __$GateDetectionStateCopyWithImpl<$Res>
    implements _$GateDetectionStateCopyWith<$Res> {
  __$GateDetectionStateCopyWithImpl(this._self, this._then);

  final _GateDetectionState _self;
  final $Res Function(_GateDetectionState) _then;

/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cameraStatus = null,Object? processStatus = null,Object? trackedFace = freezed,Object? imageSize = freezed,Object? faceCount = null,Object? recognitionResult = freezed,Object? statusMessage = null,Object? errorMessage = freezed,}) {
  return _then(_GateDetectionState(
cameraStatus: null == cameraStatus ? _self.cameraStatus : cameraStatus // ignore: cast_nullable_to_non_nullable
as GateCameraStatus,processStatus: null == processStatus ? _self.processStatus : processStatus // ignore: cast_nullable_to_non_nullable
as GateProcessStatus,trackedFace: freezed == trackedFace ? _self.trackedFace : trackedFace // ignore: cast_nullable_to_non_nullable
as DetectedFaceEntity?,imageSize: freezed == imageSize ? _self.imageSize : imageSize // ignore: cast_nullable_to_non_nullable
as Size?,faceCount: null == faceCount ? _self.faceCount : faceCount // ignore: cast_nullable_to_non_nullable
as int,recognitionResult: freezed == recognitionResult ? _self.recognitionResult : recognitionResult // ignore: cast_nullable_to_non_nullable
as RecognitionResultEntity?,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectedFaceEntityCopyWith<$Res>? get trackedFace {
    if (_self.trackedFace == null) {
    return null;
  }

  return $DetectedFaceEntityCopyWith<$Res>(_self.trackedFace!, (value) {
    return _then(_self.copyWith(trackedFace: value));
  });
}/// Create a copy of GateDetectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecognitionResultEntityCopyWith<$Res>? get recognitionResult {
    if (_self.recognitionResult == null) {
    return null;
  }

  return $RecognitionResultEntityCopyWith<$Res>(_self.recognitionResult!, (value) {
    return _then(_self.copyWith(recognitionResult: value));
  });
}
}

// dart format on
