// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_detection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FaceDetectionState {

 CameraStatus get cameraStatus; FaceValidationStatus get validationStatus; List<DetectedFaceEntity> get detectedFaces; List<LivenessStep> get livenessSequence; int get currentLivenessStepIndex; bool get isLivenessActive; bool get isProcessingFrame; bool get isCaptured; bool get isRecognizing; double get captureProgress; CapturedFrame? get capturedFrame; RecognitionResultEntity? get recognitionResult; Size? get imageSize; String? get errorMessage;
/// Create a copy of FaceDetectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceDetectionStateCopyWith<FaceDetectionState> get copyWith => _$FaceDetectionStateCopyWithImpl<FaceDetectionState>(this as FaceDetectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionState&&(identical(other.cameraStatus, cameraStatus) || other.cameraStatus == cameraStatus)&&(identical(other.validationStatus, validationStatus) || other.validationStatus == validationStatus)&&const DeepCollectionEquality().equals(other.detectedFaces, detectedFaces)&&const DeepCollectionEquality().equals(other.livenessSequence, livenessSequence)&&(identical(other.currentLivenessStepIndex, currentLivenessStepIndex) || other.currentLivenessStepIndex == currentLivenessStepIndex)&&(identical(other.isLivenessActive, isLivenessActive) || other.isLivenessActive == isLivenessActive)&&(identical(other.isProcessingFrame, isProcessingFrame) || other.isProcessingFrame == isProcessingFrame)&&(identical(other.isCaptured, isCaptured) || other.isCaptured == isCaptured)&&(identical(other.isRecognizing, isRecognizing) || other.isRecognizing == isRecognizing)&&(identical(other.captureProgress, captureProgress) || other.captureProgress == captureProgress)&&(identical(other.capturedFrame, capturedFrame) || other.capturedFrame == capturedFrame)&&(identical(other.recognitionResult, recognitionResult) || other.recognitionResult == recognitionResult)&&(identical(other.imageSize, imageSize) || other.imageSize == imageSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,cameraStatus,validationStatus,const DeepCollectionEquality().hash(detectedFaces),const DeepCollectionEquality().hash(livenessSequence),currentLivenessStepIndex,isLivenessActive,isProcessingFrame,isCaptured,isRecognizing,captureProgress,capturedFrame,recognitionResult,imageSize,errorMessage);

@override
String toString() {
  return 'FaceDetectionState(cameraStatus: $cameraStatus, validationStatus: $validationStatus, detectedFaces: $detectedFaces, livenessSequence: $livenessSequence, currentLivenessStepIndex: $currentLivenessStepIndex, isLivenessActive: $isLivenessActive, isProcessingFrame: $isProcessingFrame, isCaptured: $isCaptured, isRecognizing: $isRecognizing, captureProgress: $captureProgress, capturedFrame: $capturedFrame, recognitionResult: $recognitionResult, imageSize: $imageSize, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FaceDetectionStateCopyWith<$Res>  {
  factory $FaceDetectionStateCopyWith(FaceDetectionState value, $Res Function(FaceDetectionState) _then) = _$FaceDetectionStateCopyWithImpl;
@useResult
$Res call({
 CameraStatus cameraStatus, FaceValidationStatus validationStatus, List<DetectedFaceEntity> detectedFaces, List<LivenessStep> livenessSequence, int currentLivenessStepIndex, bool isLivenessActive, bool isProcessingFrame, bool isCaptured, bool isRecognizing, double captureProgress, CapturedFrame? capturedFrame, RecognitionResultEntity? recognitionResult, Size? imageSize, String? errorMessage
});


$CapturedFrameCopyWith<$Res>? get capturedFrame;$RecognitionResultEntityCopyWith<$Res>? get recognitionResult;

}
/// @nodoc
class _$FaceDetectionStateCopyWithImpl<$Res>
    implements $FaceDetectionStateCopyWith<$Res> {
  _$FaceDetectionStateCopyWithImpl(this._self, this._then);

  final FaceDetectionState _self;
  final $Res Function(FaceDetectionState) _then;

/// Create a copy of FaceDetectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cameraStatus = null,Object? validationStatus = null,Object? detectedFaces = null,Object? livenessSequence = null,Object? currentLivenessStepIndex = null,Object? isLivenessActive = null,Object? isProcessingFrame = null,Object? isCaptured = null,Object? isRecognizing = null,Object? captureProgress = null,Object? capturedFrame = freezed,Object? recognitionResult = freezed,Object? imageSize = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
cameraStatus: null == cameraStatus ? _self.cameraStatus : cameraStatus // ignore: cast_nullable_to_non_nullable
as CameraStatus,validationStatus: null == validationStatus ? _self.validationStatus : validationStatus // ignore: cast_nullable_to_non_nullable
as FaceValidationStatus,detectedFaces: null == detectedFaces ? _self.detectedFaces : detectedFaces // ignore: cast_nullable_to_non_nullable
as List<DetectedFaceEntity>,livenessSequence: null == livenessSequence ? _self.livenessSequence : livenessSequence // ignore: cast_nullable_to_non_nullable
as List<LivenessStep>,currentLivenessStepIndex: null == currentLivenessStepIndex ? _self.currentLivenessStepIndex : currentLivenessStepIndex // ignore: cast_nullable_to_non_nullable
as int,isLivenessActive: null == isLivenessActive ? _self.isLivenessActive : isLivenessActive // ignore: cast_nullable_to_non_nullable
as bool,isProcessingFrame: null == isProcessingFrame ? _self.isProcessingFrame : isProcessingFrame // ignore: cast_nullable_to_non_nullable
as bool,isCaptured: null == isCaptured ? _self.isCaptured : isCaptured // ignore: cast_nullable_to_non_nullable
as bool,isRecognizing: null == isRecognizing ? _self.isRecognizing : isRecognizing // ignore: cast_nullable_to_non_nullable
as bool,captureProgress: null == captureProgress ? _self.captureProgress : captureProgress // ignore: cast_nullable_to_non_nullable
as double,capturedFrame: freezed == capturedFrame ? _self.capturedFrame : capturedFrame // ignore: cast_nullable_to_non_nullable
as CapturedFrame?,recognitionResult: freezed == recognitionResult ? _self.recognitionResult : recognitionResult // ignore: cast_nullable_to_non_nullable
as RecognitionResultEntity?,imageSize: freezed == imageSize ? _self.imageSize : imageSize // ignore: cast_nullable_to_non_nullable
as Size?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FaceDetectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapturedFrameCopyWith<$Res>? get capturedFrame {
    if (_self.capturedFrame == null) {
    return null;
  }

  return $CapturedFrameCopyWith<$Res>(_self.capturedFrame!, (value) {
    return _then(_self.copyWith(capturedFrame: value));
  });
}/// Create a copy of FaceDetectionState
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


/// Adds pattern-matching-related methods to [FaceDetectionState].
extension FaceDetectionStatePatterns on FaceDetectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaceDetectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaceDetectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaceDetectionState value)  $default,){
final _that = this;
switch (_that) {
case _FaceDetectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaceDetectionState value)?  $default,){
final _that = this;
switch (_that) {
case _FaceDetectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CameraStatus cameraStatus,  FaceValidationStatus validationStatus,  List<DetectedFaceEntity> detectedFaces,  List<LivenessStep> livenessSequence,  int currentLivenessStepIndex,  bool isLivenessActive,  bool isProcessingFrame,  bool isCaptured,  bool isRecognizing,  double captureProgress,  CapturedFrame? capturedFrame,  RecognitionResultEntity? recognitionResult,  Size? imageSize,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaceDetectionState() when $default != null:
return $default(_that.cameraStatus,_that.validationStatus,_that.detectedFaces,_that.livenessSequence,_that.currentLivenessStepIndex,_that.isLivenessActive,_that.isProcessingFrame,_that.isCaptured,_that.isRecognizing,_that.captureProgress,_that.capturedFrame,_that.recognitionResult,_that.imageSize,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CameraStatus cameraStatus,  FaceValidationStatus validationStatus,  List<DetectedFaceEntity> detectedFaces,  List<LivenessStep> livenessSequence,  int currentLivenessStepIndex,  bool isLivenessActive,  bool isProcessingFrame,  bool isCaptured,  bool isRecognizing,  double captureProgress,  CapturedFrame? capturedFrame,  RecognitionResultEntity? recognitionResult,  Size? imageSize,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _FaceDetectionState():
return $default(_that.cameraStatus,_that.validationStatus,_that.detectedFaces,_that.livenessSequence,_that.currentLivenessStepIndex,_that.isLivenessActive,_that.isProcessingFrame,_that.isCaptured,_that.isRecognizing,_that.captureProgress,_that.capturedFrame,_that.recognitionResult,_that.imageSize,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CameraStatus cameraStatus,  FaceValidationStatus validationStatus,  List<DetectedFaceEntity> detectedFaces,  List<LivenessStep> livenessSequence,  int currentLivenessStepIndex,  bool isLivenessActive,  bool isProcessingFrame,  bool isCaptured,  bool isRecognizing,  double captureProgress,  CapturedFrame? capturedFrame,  RecognitionResultEntity? recognitionResult,  Size? imageSize,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _FaceDetectionState() when $default != null:
return $default(_that.cameraStatus,_that.validationStatus,_that.detectedFaces,_that.livenessSequence,_that.currentLivenessStepIndex,_that.isLivenessActive,_that.isProcessingFrame,_that.isCaptured,_that.isRecognizing,_that.captureProgress,_that.capturedFrame,_that.recognitionResult,_that.imageSize,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _FaceDetectionState implements FaceDetectionState {
  const _FaceDetectionState({this.cameraStatus = CameraStatus.uninitialized, this.validationStatus = FaceValidationStatus.scanning, final  List<DetectedFaceEntity> detectedFaces = const [], final  List<LivenessStep> livenessSequence = const [], this.currentLivenessStepIndex = 0, this.isLivenessActive = false, this.isProcessingFrame = false, this.isCaptured = false, this.isRecognizing = false, this.captureProgress = 0.0, this.capturedFrame, this.recognitionResult, this.imageSize, this.errorMessage}): _detectedFaces = detectedFaces,_livenessSequence = livenessSequence;
  

@override@JsonKey() final  CameraStatus cameraStatus;
@override@JsonKey() final  FaceValidationStatus validationStatus;
 final  List<DetectedFaceEntity> _detectedFaces;
@override@JsonKey() List<DetectedFaceEntity> get detectedFaces {
  if (_detectedFaces is EqualUnmodifiableListView) return _detectedFaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detectedFaces);
}

 final  List<LivenessStep> _livenessSequence;
@override@JsonKey() List<LivenessStep> get livenessSequence {
  if (_livenessSequence is EqualUnmodifiableListView) return _livenessSequence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_livenessSequence);
}

@override@JsonKey() final  int currentLivenessStepIndex;
@override@JsonKey() final  bool isLivenessActive;
@override@JsonKey() final  bool isProcessingFrame;
@override@JsonKey() final  bool isCaptured;
@override@JsonKey() final  bool isRecognizing;
@override@JsonKey() final  double captureProgress;
@override final  CapturedFrame? capturedFrame;
@override final  RecognitionResultEntity? recognitionResult;
@override final  Size? imageSize;
@override final  String? errorMessage;

/// Create a copy of FaceDetectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaceDetectionStateCopyWith<_FaceDetectionState> get copyWith => __$FaceDetectionStateCopyWithImpl<_FaceDetectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaceDetectionState&&(identical(other.cameraStatus, cameraStatus) || other.cameraStatus == cameraStatus)&&(identical(other.validationStatus, validationStatus) || other.validationStatus == validationStatus)&&const DeepCollectionEquality().equals(other._detectedFaces, _detectedFaces)&&const DeepCollectionEquality().equals(other._livenessSequence, _livenessSequence)&&(identical(other.currentLivenessStepIndex, currentLivenessStepIndex) || other.currentLivenessStepIndex == currentLivenessStepIndex)&&(identical(other.isLivenessActive, isLivenessActive) || other.isLivenessActive == isLivenessActive)&&(identical(other.isProcessingFrame, isProcessingFrame) || other.isProcessingFrame == isProcessingFrame)&&(identical(other.isCaptured, isCaptured) || other.isCaptured == isCaptured)&&(identical(other.isRecognizing, isRecognizing) || other.isRecognizing == isRecognizing)&&(identical(other.captureProgress, captureProgress) || other.captureProgress == captureProgress)&&(identical(other.capturedFrame, capturedFrame) || other.capturedFrame == capturedFrame)&&(identical(other.recognitionResult, recognitionResult) || other.recognitionResult == recognitionResult)&&(identical(other.imageSize, imageSize) || other.imageSize == imageSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,cameraStatus,validationStatus,const DeepCollectionEquality().hash(_detectedFaces),const DeepCollectionEquality().hash(_livenessSequence),currentLivenessStepIndex,isLivenessActive,isProcessingFrame,isCaptured,isRecognizing,captureProgress,capturedFrame,recognitionResult,imageSize,errorMessage);

@override
String toString() {
  return 'FaceDetectionState(cameraStatus: $cameraStatus, validationStatus: $validationStatus, detectedFaces: $detectedFaces, livenessSequence: $livenessSequence, currentLivenessStepIndex: $currentLivenessStepIndex, isLivenessActive: $isLivenessActive, isProcessingFrame: $isProcessingFrame, isCaptured: $isCaptured, isRecognizing: $isRecognizing, captureProgress: $captureProgress, capturedFrame: $capturedFrame, recognitionResult: $recognitionResult, imageSize: $imageSize, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FaceDetectionStateCopyWith<$Res> implements $FaceDetectionStateCopyWith<$Res> {
  factory _$FaceDetectionStateCopyWith(_FaceDetectionState value, $Res Function(_FaceDetectionState) _then) = __$FaceDetectionStateCopyWithImpl;
@override @useResult
$Res call({
 CameraStatus cameraStatus, FaceValidationStatus validationStatus, List<DetectedFaceEntity> detectedFaces, List<LivenessStep> livenessSequence, int currentLivenessStepIndex, bool isLivenessActive, bool isProcessingFrame, bool isCaptured, bool isRecognizing, double captureProgress, CapturedFrame? capturedFrame, RecognitionResultEntity? recognitionResult, Size? imageSize, String? errorMessage
});


@override $CapturedFrameCopyWith<$Res>? get capturedFrame;@override $RecognitionResultEntityCopyWith<$Res>? get recognitionResult;

}
/// @nodoc
class __$FaceDetectionStateCopyWithImpl<$Res>
    implements _$FaceDetectionStateCopyWith<$Res> {
  __$FaceDetectionStateCopyWithImpl(this._self, this._then);

  final _FaceDetectionState _self;
  final $Res Function(_FaceDetectionState) _then;

/// Create a copy of FaceDetectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cameraStatus = null,Object? validationStatus = null,Object? detectedFaces = null,Object? livenessSequence = null,Object? currentLivenessStepIndex = null,Object? isLivenessActive = null,Object? isProcessingFrame = null,Object? isCaptured = null,Object? isRecognizing = null,Object? captureProgress = null,Object? capturedFrame = freezed,Object? recognitionResult = freezed,Object? imageSize = freezed,Object? errorMessage = freezed,}) {
  return _then(_FaceDetectionState(
cameraStatus: null == cameraStatus ? _self.cameraStatus : cameraStatus // ignore: cast_nullable_to_non_nullable
as CameraStatus,validationStatus: null == validationStatus ? _self.validationStatus : validationStatus // ignore: cast_nullable_to_non_nullable
as FaceValidationStatus,detectedFaces: null == detectedFaces ? _self._detectedFaces : detectedFaces // ignore: cast_nullable_to_non_nullable
as List<DetectedFaceEntity>,livenessSequence: null == livenessSequence ? _self._livenessSequence : livenessSequence // ignore: cast_nullable_to_non_nullable
as List<LivenessStep>,currentLivenessStepIndex: null == currentLivenessStepIndex ? _self.currentLivenessStepIndex : currentLivenessStepIndex // ignore: cast_nullable_to_non_nullable
as int,isLivenessActive: null == isLivenessActive ? _self.isLivenessActive : isLivenessActive // ignore: cast_nullable_to_non_nullable
as bool,isProcessingFrame: null == isProcessingFrame ? _self.isProcessingFrame : isProcessingFrame // ignore: cast_nullable_to_non_nullable
as bool,isCaptured: null == isCaptured ? _self.isCaptured : isCaptured // ignore: cast_nullable_to_non_nullable
as bool,isRecognizing: null == isRecognizing ? _self.isRecognizing : isRecognizing // ignore: cast_nullable_to_non_nullable
as bool,captureProgress: null == captureProgress ? _self.captureProgress : captureProgress // ignore: cast_nullable_to_non_nullable
as double,capturedFrame: freezed == capturedFrame ? _self.capturedFrame : capturedFrame // ignore: cast_nullable_to_non_nullable
as CapturedFrame?,recognitionResult: freezed == recognitionResult ? _self.recognitionResult : recognitionResult // ignore: cast_nullable_to_non_nullable
as RecognitionResultEntity?,imageSize: freezed == imageSize ? _self.imageSize : imageSize // ignore: cast_nullable_to_non_nullable
as Size?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FaceDetectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapturedFrameCopyWith<$Res>? get capturedFrame {
    if (_self.capturedFrame == null) {
    return null;
  }

  return $CapturedFrameCopyWith<$Res>(_self.capturedFrame!, (value) {
    return _then(_self.copyWith(capturedFrame: value));
  });
}/// Create a copy of FaceDetectionState
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
