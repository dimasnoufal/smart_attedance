// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FaceDetectionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FaceDetectionEvent()';
}


}

/// @nodoc
class $FaceDetectionEventCopyWith<$Res>  {
$FaceDetectionEventCopyWith(FaceDetectionEvent _, $Res Function(FaceDetectionEvent) __);
}


/// Adds pattern-matching-related methods to [FaceDetectionEvent].
extension FaceDetectionEventPatterns on FaceDetectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FaceDetectionStarted value)?  started,TResult Function( FaceDetectionCameraInitialized value)?  cameraInitialized,TResult Function( FaceDetectionFrameReceived value)?  frameReceived,TResult Function( FaceDetectionValidationCompleted value)?  validationCompleted,TResult Function( FaceDetectionLivenessStepCompleted value)?  livenessStepCompleted,TResult Function( FaceDetectionCaptureTriggered value)?  captureTriggered,TResult Function( FaceDetectionCaptureCompleted value)?  captureCompleted,TResult Function( FaceDetectionRecognitionCompleted value)?  recognitionCompleted,TResult Function( FaceDetectionErrorOccurred value)?  errorOccurred,TResult Function( FaceDetectionStopped value)?  stopped,TResult Function( FaceDetectionResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FaceDetectionStarted() when started != null:
return started(_that);case FaceDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized(_that);case FaceDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that);case FaceDetectionValidationCompleted() when validationCompleted != null:
return validationCompleted(_that);case FaceDetectionLivenessStepCompleted() when livenessStepCompleted != null:
return livenessStepCompleted(_that);case FaceDetectionCaptureTriggered() when captureTriggered != null:
return captureTriggered(_that);case FaceDetectionCaptureCompleted() when captureCompleted != null:
return captureCompleted(_that);case FaceDetectionRecognitionCompleted() when recognitionCompleted != null:
return recognitionCompleted(_that);case FaceDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case FaceDetectionStopped() when stopped != null:
return stopped(_that);case FaceDetectionResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FaceDetectionStarted value)  started,required TResult Function( FaceDetectionCameraInitialized value)  cameraInitialized,required TResult Function( FaceDetectionFrameReceived value)  frameReceived,required TResult Function( FaceDetectionValidationCompleted value)  validationCompleted,required TResult Function( FaceDetectionLivenessStepCompleted value)  livenessStepCompleted,required TResult Function( FaceDetectionCaptureTriggered value)  captureTriggered,required TResult Function( FaceDetectionCaptureCompleted value)  captureCompleted,required TResult Function( FaceDetectionRecognitionCompleted value)  recognitionCompleted,required TResult Function( FaceDetectionErrorOccurred value)  errorOccurred,required TResult Function( FaceDetectionStopped value)  stopped,required TResult Function( FaceDetectionResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case FaceDetectionStarted():
return started(_that);case FaceDetectionCameraInitialized():
return cameraInitialized(_that);case FaceDetectionFrameReceived():
return frameReceived(_that);case FaceDetectionValidationCompleted():
return validationCompleted(_that);case FaceDetectionLivenessStepCompleted():
return livenessStepCompleted(_that);case FaceDetectionCaptureTriggered():
return captureTriggered(_that);case FaceDetectionCaptureCompleted():
return captureCompleted(_that);case FaceDetectionRecognitionCompleted():
return recognitionCompleted(_that);case FaceDetectionErrorOccurred():
return errorOccurred(_that);case FaceDetectionStopped():
return stopped(_that);case FaceDetectionResetRequested():
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FaceDetectionStarted value)?  started,TResult? Function( FaceDetectionCameraInitialized value)?  cameraInitialized,TResult? Function( FaceDetectionFrameReceived value)?  frameReceived,TResult? Function( FaceDetectionValidationCompleted value)?  validationCompleted,TResult? Function( FaceDetectionLivenessStepCompleted value)?  livenessStepCompleted,TResult? Function( FaceDetectionCaptureTriggered value)?  captureTriggered,TResult? Function( FaceDetectionCaptureCompleted value)?  captureCompleted,TResult? Function( FaceDetectionRecognitionCompleted value)?  recognitionCompleted,TResult? Function( FaceDetectionErrorOccurred value)?  errorOccurred,TResult? Function( FaceDetectionStopped value)?  stopped,TResult? Function( FaceDetectionResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case FaceDetectionStarted() when started != null:
return started(_that);case FaceDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized(_that);case FaceDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that);case FaceDetectionValidationCompleted() when validationCompleted != null:
return validationCompleted(_that);case FaceDetectionLivenessStepCompleted() when livenessStepCompleted != null:
return livenessStepCompleted(_that);case FaceDetectionCaptureTriggered() when captureTriggered != null:
return captureTriggered(_that);case FaceDetectionCaptureCompleted() when captureCompleted != null:
return captureCompleted(_that);case FaceDetectionRecognitionCompleted() when recognitionCompleted != null:
return recognitionCompleted(_that);case FaceDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case FaceDetectionStopped() when stopped != null:
return stopped(_that);case FaceDetectionResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  cameraInitialized,TResult Function( FaceDetectionResult result,  Size imageSize)?  frameReceived,TResult Function( FaceValidationStatus status,  DetectedFaceEntity? face)?  validationCompleted,TResult Function()?  livenessStepCompleted,TResult Function()?  captureTriggered,TResult Function( CapturedFrame frame)?  captureCompleted,TResult Function( RecognitionResultEntity result)?  recognitionCompleted,TResult Function( String message)?  errorOccurred,TResult Function()?  stopped,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FaceDetectionStarted() when started != null:
return started();case FaceDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized();case FaceDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that.result,_that.imageSize);case FaceDetectionValidationCompleted() when validationCompleted != null:
return validationCompleted(_that.status,_that.face);case FaceDetectionLivenessStepCompleted() when livenessStepCompleted != null:
return livenessStepCompleted();case FaceDetectionCaptureTriggered() when captureTriggered != null:
return captureTriggered();case FaceDetectionCaptureCompleted() when captureCompleted != null:
return captureCompleted(_that.frame);case FaceDetectionRecognitionCompleted() when recognitionCompleted != null:
return recognitionCompleted(_that.result);case FaceDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case FaceDetectionStopped() when stopped != null:
return stopped();case FaceDetectionResetRequested() when resetRequested != null:
return resetRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  cameraInitialized,required TResult Function( FaceDetectionResult result,  Size imageSize)  frameReceived,required TResult Function( FaceValidationStatus status,  DetectedFaceEntity? face)  validationCompleted,required TResult Function()  livenessStepCompleted,required TResult Function()  captureTriggered,required TResult Function( CapturedFrame frame)  captureCompleted,required TResult Function( RecognitionResultEntity result)  recognitionCompleted,required TResult Function( String message)  errorOccurred,required TResult Function()  stopped,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case FaceDetectionStarted():
return started();case FaceDetectionCameraInitialized():
return cameraInitialized();case FaceDetectionFrameReceived():
return frameReceived(_that.result,_that.imageSize);case FaceDetectionValidationCompleted():
return validationCompleted(_that.status,_that.face);case FaceDetectionLivenessStepCompleted():
return livenessStepCompleted();case FaceDetectionCaptureTriggered():
return captureTriggered();case FaceDetectionCaptureCompleted():
return captureCompleted(_that.frame);case FaceDetectionRecognitionCompleted():
return recognitionCompleted(_that.result);case FaceDetectionErrorOccurred():
return errorOccurred(_that.message);case FaceDetectionStopped():
return stopped();case FaceDetectionResetRequested():
return resetRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  cameraInitialized,TResult? Function( FaceDetectionResult result,  Size imageSize)?  frameReceived,TResult? Function( FaceValidationStatus status,  DetectedFaceEntity? face)?  validationCompleted,TResult? Function()?  livenessStepCompleted,TResult? Function()?  captureTriggered,TResult? Function( CapturedFrame frame)?  captureCompleted,TResult? Function( RecognitionResultEntity result)?  recognitionCompleted,TResult? Function( String message)?  errorOccurred,TResult? Function()?  stopped,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case FaceDetectionStarted() when started != null:
return started();case FaceDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized();case FaceDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that.result,_that.imageSize);case FaceDetectionValidationCompleted() when validationCompleted != null:
return validationCompleted(_that.status,_that.face);case FaceDetectionLivenessStepCompleted() when livenessStepCompleted != null:
return livenessStepCompleted();case FaceDetectionCaptureTriggered() when captureTriggered != null:
return captureTriggered();case FaceDetectionCaptureCompleted() when captureCompleted != null:
return captureCompleted(_that.frame);case FaceDetectionRecognitionCompleted() when recognitionCompleted != null:
return recognitionCompleted(_that.result);case FaceDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case FaceDetectionStopped() when stopped != null:
return stopped();case FaceDetectionResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class FaceDetectionStarted implements FaceDetectionEvent {
  const FaceDetectionStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FaceDetectionEvent.started()';
}


}




/// @nodoc


class FaceDetectionCameraInitialized implements FaceDetectionEvent {
  const FaceDetectionCameraInitialized();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionCameraInitialized);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FaceDetectionEvent.cameraInitialized()';
}


}




/// @nodoc


class FaceDetectionFrameReceived implements FaceDetectionEvent {
  const FaceDetectionFrameReceived({required this.result, required this.imageSize});
  

 final  FaceDetectionResult result;
 final  Size imageSize;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceDetectionFrameReceivedCopyWith<FaceDetectionFrameReceived> get copyWith => _$FaceDetectionFrameReceivedCopyWithImpl<FaceDetectionFrameReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionFrameReceived&&(identical(other.result, result) || other.result == result)&&(identical(other.imageSize, imageSize) || other.imageSize == imageSize));
}


@override
int get hashCode => Object.hash(runtimeType,result,imageSize);

@override
String toString() {
  return 'FaceDetectionEvent.frameReceived(result: $result, imageSize: $imageSize)';
}


}

/// @nodoc
abstract mixin class $FaceDetectionFrameReceivedCopyWith<$Res> implements $FaceDetectionEventCopyWith<$Res> {
  factory $FaceDetectionFrameReceivedCopyWith(FaceDetectionFrameReceived value, $Res Function(FaceDetectionFrameReceived) _then) = _$FaceDetectionFrameReceivedCopyWithImpl;
@useResult
$Res call({
 FaceDetectionResult result, Size imageSize
});


$FaceDetectionResultCopyWith<$Res> get result;

}
/// @nodoc
class _$FaceDetectionFrameReceivedCopyWithImpl<$Res>
    implements $FaceDetectionFrameReceivedCopyWith<$Res> {
  _$FaceDetectionFrameReceivedCopyWithImpl(this._self, this._then);

  final FaceDetectionFrameReceived _self;
  final $Res Function(FaceDetectionFrameReceived) _then;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,Object? imageSize = null,}) {
  return _then(FaceDetectionFrameReceived(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as FaceDetectionResult,imageSize: null == imageSize ? _self.imageSize : imageSize // ignore: cast_nullable_to_non_nullable
as Size,
  ));
}

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FaceDetectionResultCopyWith<$Res> get result {
  
  return $FaceDetectionResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class FaceDetectionValidationCompleted implements FaceDetectionEvent {
  const FaceDetectionValidationCompleted({required this.status, this.face});
  

 final  FaceValidationStatus status;
 final  DetectedFaceEntity? face;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceDetectionValidationCompletedCopyWith<FaceDetectionValidationCompleted> get copyWith => _$FaceDetectionValidationCompletedCopyWithImpl<FaceDetectionValidationCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionValidationCompleted&&(identical(other.status, status) || other.status == status)&&(identical(other.face, face) || other.face == face));
}


@override
int get hashCode => Object.hash(runtimeType,status,face);

@override
String toString() {
  return 'FaceDetectionEvent.validationCompleted(status: $status, face: $face)';
}


}

/// @nodoc
abstract mixin class $FaceDetectionValidationCompletedCopyWith<$Res> implements $FaceDetectionEventCopyWith<$Res> {
  factory $FaceDetectionValidationCompletedCopyWith(FaceDetectionValidationCompleted value, $Res Function(FaceDetectionValidationCompleted) _then) = _$FaceDetectionValidationCompletedCopyWithImpl;
@useResult
$Res call({
 FaceValidationStatus status, DetectedFaceEntity? face
});


$DetectedFaceEntityCopyWith<$Res>? get face;

}
/// @nodoc
class _$FaceDetectionValidationCompletedCopyWithImpl<$Res>
    implements $FaceDetectionValidationCompletedCopyWith<$Res> {
  _$FaceDetectionValidationCompletedCopyWithImpl(this._self, this._then);

  final FaceDetectionValidationCompleted _self;
  final $Res Function(FaceDetectionValidationCompleted) _then;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,Object? face = freezed,}) {
  return _then(FaceDetectionValidationCompleted(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FaceValidationStatus,face: freezed == face ? _self.face : face // ignore: cast_nullable_to_non_nullable
as DetectedFaceEntity?,
  ));
}

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectedFaceEntityCopyWith<$Res>? get face {
    if (_self.face == null) {
    return null;
  }

  return $DetectedFaceEntityCopyWith<$Res>(_self.face!, (value) {
    return _then(_self.copyWith(face: value));
  });
}
}

/// @nodoc


class FaceDetectionLivenessStepCompleted implements FaceDetectionEvent {
  const FaceDetectionLivenessStepCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionLivenessStepCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FaceDetectionEvent.livenessStepCompleted()';
}


}




/// @nodoc


class FaceDetectionCaptureTriggered implements FaceDetectionEvent {
  const FaceDetectionCaptureTriggered();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionCaptureTriggered);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FaceDetectionEvent.captureTriggered()';
}


}




/// @nodoc


class FaceDetectionCaptureCompleted implements FaceDetectionEvent {
  const FaceDetectionCaptureCompleted({required this.frame});
  

 final  CapturedFrame frame;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceDetectionCaptureCompletedCopyWith<FaceDetectionCaptureCompleted> get copyWith => _$FaceDetectionCaptureCompletedCopyWithImpl<FaceDetectionCaptureCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionCaptureCompleted&&(identical(other.frame, frame) || other.frame == frame));
}


@override
int get hashCode => Object.hash(runtimeType,frame);

@override
String toString() {
  return 'FaceDetectionEvent.captureCompleted(frame: $frame)';
}


}

/// @nodoc
abstract mixin class $FaceDetectionCaptureCompletedCopyWith<$Res> implements $FaceDetectionEventCopyWith<$Res> {
  factory $FaceDetectionCaptureCompletedCopyWith(FaceDetectionCaptureCompleted value, $Res Function(FaceDetectionCaptureCompleted) _then) = _$FaceDetectionCaptureCompletedCopyWithImpl;
@useResult
$Res call({
 CapturedFrame frame
});


$CapturedFrameCopyWith<$Res> get frame;

}
/// @nodoc
class _$FaceDetectionCaptureCompletedCopyWithImpl<$Res>
    implements $FaceDetectionCaptureCompletedCopyWith<$Res> {
  _$FaceDetectionCaptureCompletedCopyWithImpl(this._self, this._then);

  final FaceDetectionCaptureCompleted _self;
  final $Res Function(FaceDetectionCaptureCompleted) _then;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? frame = null,}) {
  return _then(FaceDetectionCaptureCompleted(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as CapturedFrame,
  ));
}

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapturedFrameCopyWith<$Res> get frame {
  
  return $CapturedFrameCopyWith<$Res>(_self.frame, (value) {
    return _then(_self.copyWith(frame: value));
  });
}
}

/// @nodoc


class FaceDetectionRecognitionCompleted implements FaceDetectionEvent {
  const FaceDetectionRecognitionCompleted({required this.result});
  

 final  RecognitionResultEntity result;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceDetectionRecognitionCompletedCopyWith<FaceDetectionRecognitionCompleted> get copyWith => _$FaceDetectionRecognitionCompletedCopyWithImpl<FaceDetectionRecognitionCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionRecognitionCompleted&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'FaceDetectionEvent.recognitionCompleted(result: $result)';
}


}

/// @nodoc
abstract mixin class $FaceDetectionRecognitionCompletedCopyWith<$Res> implements $FaceDetectionEventCopyWith<$Res> {
  factory $FaceDetectionRecognitionCompletedCopyWith(FaceDetectionRecognitionCompleted value, $Res Function(FaceDetectionRecognitionCompleted) _then) = _$FaceDetectionRecognitionCompletedCopyWithImpl;
@useResult
$Res call({
 RecognitionResultEntity result
});


$RecognitionResultEntityCopyWith<$Res> get result;

}
/// @nodoc
class _$FaceDetectionRecognitionCompletedCopyWithImpl<$Res>
    implements $FaceDetectionRecognitionCompletedCopyWith<$Res> {
  _$FaceDetectionRecognitionCompletedCopyWithImpl(this._self, this._then);

  final FaceDetectionRecognitionCompleted _self;
  final $Res Function(FaceDetectionRecognitionCompleted) _then;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(FaceDetectionRecognitionCompleted(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as RecognitionResultEntity,
  ));
}

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecognitionResultEntityCopyWith<$Res> get result {
  
  return $RecognitionResultEntityCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class FaceDetectionErrorOccurred implements FaceDetectionEvent {
  const FaceDetectionErrorOccurred({required this.message});
  

 final  String message;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceDetectionErrorOccurredCopyWith<FaceDetectionErrorOccurred> get copyWith => _$FaceDetectionErrorOccurredCopyWithImpl<FaceDetectionErrorOccurred>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionErrorOccurred&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FaceDetectionEvent.errorOccurred(message: $message)';
}


}

/// @nodoc
abstract mixin class $FaceDetectionErrorOccurredCopyWith<$Res> implements $FaceDetectionEventCopyWith<$Res> {
  factory $FaceDetectionErrorOccurredCopyWith(FaceDetectionErrorOccurred value, $Res Function(FaceDetectionErrorOccurred) _then) = _$FaceDetectionErrorOccurredCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FaceDetectionErrorOccurredCopyWithImpl<$Res>
    implements $FaceDetectionErrorOccurredCopyWith<$Res> {
  _$FaceDetectionErrorOccurredCopyWithImpl(this._self, this._then);

  final FaceDetectionErrorOccurred _self;
  final $Res Function(FaceDetectionErrorOccurred) _then;

/// Create a copy of FaceDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FaceDetectionErrorOccurred(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FaceDetectionStopped implements FaceDetectionEvent {
  const FaceDetectionStopped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionStopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FaceDetectionEvent.stopped()';
}


}




/// @nodoc


class FaceDetectionResetRequested implements FaceDetectionEvent {
  const FaceDetectionResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceDetectionResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FaceDetectionEvent.resetRequested()';
}


}




// dart format on
