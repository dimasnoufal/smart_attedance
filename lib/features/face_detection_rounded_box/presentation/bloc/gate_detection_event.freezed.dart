// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gate_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GateDetectionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GateDetectionEvent()';
}


}

/// @nodoc
class $GateDetectionEventCopyWith<$Res>  {
$GateDetectionEventCopyWith(GateDetectionEvent _, $Res Function(GateDetectionEvent) __);
}


/// Adds pattern-matching-related methods to [GateDetectionEvent].
extension GateDetectionEventPatterns on GateDetectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GateDetectionStarted value)?  started,TResult Function( GateDetectionCameraInitialized value)?  cameraInitialized,TResult Function( GateDetectionFrameReceived value)?  frameReceived,TResult Function( GateDetectionFaceReady value)?  faceReady,TResult Function( GateDetectionErrorOccurred value)?  errorOccurred,TResult Function( GateDetectionStopped value)?  stopped,TResult Function( GateDetectionResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GateDetectionStarted() when started != null:
return started(_that);case GateDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized(_that);case GateDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that);case GateDetectionFaceReady() when faceReady != null:
return faceReady(_that);case GateDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case GateDetectionStopped() when stopped != null:
return stopped(_that);case GateDetectionResetRequested() when resetRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GateDetectionStarted value)  started,required TResult Function( GateDetectionCameraInitialized value)  cameraInitialized,required TResult Function( GateDetectionFrameReceived value)  frameReceived,required TResult Function( GateDetectionFaceReady value)  faceReady,required TResult Function( GateDetectionErrorOccurred value)  errorOccurred,required TResult Function( GateDetectionStopped value)  stopped,required TResult Function( GateDetectionResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case GateDetectionStarted():
return started(_that);case GateDetectionCameraInitialized():
return cameraInitialized(_that);case GateDetectionFrameReceived():
return frameReceived(_that);case GateDetectionFaceReady():
return faceReady(_that);case GateDetectionErrorOccurred():
return errorOccurred(_that);case GateDetectionStopped():
return stopped(_that);case GateDetectionResetRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GateDetectionStarted value)?  started,TResult? Function( GateDetectionCameraInitialized value)?  cameraInitialized,TResult? Function( GateDetectionFrameReceived value)?  frameReceived,TResult? Function( GateDetectionFaceReady value)?  faceReady,TResult? Function( GateDetectionErrorOccurred value)?  errorOccurred,TResult? Function( GateDetectionStopped value)?  stopped,TResult? Function( GateDetectionResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case GateDetectionStarted() when started != null:
return started(_that);case GateDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized(_that);case GateDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that);case GateDetectionFaceReady() when faceReady != null:
return faceReady(_that);case GateDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case GateDetectionStopped() when stopped != null:
return stopped(_that);case GateDetectionResetRequested() when resetRequested != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  cameraInitialized,TResult Function( dynamic image)?  frameReceived,TResult Function( CapturedFrame frame)?  faceReady,TResult Function( String message)?  errorOccurred,TResult Function()?  stopped,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GateDetectionStarted() when started != null:
return started();case GateDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized();case GateDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that.image);case GateDetectionFaceReady() when faceReady != null:
return faceReady(_that.frame);case GateDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case GateDetectionStopped() when stopped != null:
return stopped();case GateDetectionResetRequested() when resetRequested != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  cameraInitialized,required TResult Function( dynamic image)  frameReceived,required TResult Function( CapturedFrame frame)  faceReady,required TResult Function( String message)  errorOccurred,required TResult Function()  stopped,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case GateDetectionStarted():
return started();case GateDetectionCameraInitialized():
return cameraInitialized();case GateDetectionFrameReceived():
return frameReceived(_that.image);case GateDetectionFaceReady():
return faceReady(_that.frame);case GateDetectionErrorOccurred():
return errorOccurred(_that.message);case GateDetectionStopped():
return stopped();case GateDetectionResetRequested():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  cameraInitialized,TResult? Function( dynamic image)?  frameReceived,TResult? Function( CapturedFrame frame)?  faceReady,TResult? Function( String message)?  errorOccurred,TResult? Function()?  stopped,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case GateDetectionStarted() when started != null:
return started();case GateDetectionCameraInitialized() when cameraInitialized != null:
return cameraInitialized();case GateDetectionFrameReceived() when frameReceived != null:
return frameReceived(_that.image);case GateDetectionFaceReady() when faceReady != null:
return faceReady(_that.frame);case GateDetectionErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case GateDetectionStopped() when stopped != null:
return stopped();case GateDetectionResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class GateDetectionStarted implements GateDetectionEvent {
  const GateDetectionStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GateDetectionEvent.started()';
}


}




/// @nodoc


class GateDetectionCameraInitialized implements GateDetectionEvent {
  const GateDetectionCameraInitialized();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionCameraInitialized);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GateDetectionEvent.cameraInitialized()';
}


}




/// @nodoc


class GateDetectionFrameReceived implements GateDetectionEvent {
  const GateDetectionFrameReceived({required this.image});
  

 final  dynamic image;

/// Create a copy of GateDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GateDetectionFrameReceivedCopyWith<GateDetectionFrameReceived> get copyWith => _$GateDetectionFrameReceivedCopyWithImpl<GateDetectionFrameReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionFrameReceived&&const DeepCollectionEquality().equals(other.image, image));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(image));

@override
String toString() {
  return 'GateDetectionEvent.frameReceived(image: $image)';
}


}

/// @nodoc
abstract mixin class $GateDetectionFrameReceivedCopyWith<$Res> implements $GateDetectionEventCopyWith<$Res> {
  factory $GateDetectionFrameReceivedCopyWith(GateDetectionFrameReceived value, $Res Function(GateDetectionFrameReceived) _then) = _$GateDetectionFrameReceivedCopyWithImpl;
@useResult
$Res call({
 dynamic image
});




}
/// @nodoc
class _$GateDetectionFrameReceivedCopyWithImpl<$Res>
    implements $GateDetectionFrameReceivedCopyWith<$Res> {
  _$GateDetectionFrameReceivedCopyWithImpl(this._self, this._then);

  final GateDetectionFrameReceived _self;
  final $Res Function(GateDetectionFrameReceived) _then;

/// Create a copy of GateDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? image = freezed,}) {
  return _then(GateDetectionFrameReceived(
image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class GateDetectionFaceReady implements GateDetectionEvent {
  const GateDetectionFaceReady({required this.frame});
  

 final  CapturedFrame frame;

/// Create a copy of GateDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GateDetectionFaceReadyCopyWith<GateDetectionFaceReady> get copyWith => _$GateDetectionFaceReadyCopyWithImpl<GateDetectionFaceReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionFaceReady&&(identical(other.frame, frame) || other.frame == frame));
}


@override
int get hashCode => Object.hash(runtimeType,frame);

@override
String toString() {
  return 'GateDetectionEvent.faceReady(frame: $frame)';
}


}

/// @nodoc
abstract mixin class $GateDetectionFaceReadyCopyWith<$Res> implements $GateDetectionEventCopyWith<$Res> {
  factory $GateDetectionFaceReadyCopyWith(GateDetectionFaceReady value, $Res Function(GateDetectionFaceReady) _then) = _$GateDetectionFaceReadyCopyWithImpl;
@useResult
$Res call({
 CapturedFrame frame
});


$CapturedFrameCopyWith<$Res> get frame;

}
/// @nodoc
class _$GateDetectionFaceReadyCopyWithImpl<$Res>
    implements $GateDetectionFaceReadyCopyWith<$Res> {
  _$GateDetectionFaceReadyCopyWithImpl(this._self, this._then);

  final GateDetectionFaceReady _self;
  final $Res Function(GateDetectionFaceReady) _then;

/// Create a copy of GateDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? frame = null,}) {
  return _then(GateDetectionFaceReady(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as CapturedFrame,
  ));
}

/// Create a copy of GateDetectionEvent
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


class GateDetectionErrorOccurred implements GateDetectionEvent {
  const GateDetectionErrorOccurred({required this.message});
  

 final  String message;

/// Create a copy of GateDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GateDetectionErrorOccurredCopyWith<GateDetectionErrorOccurred> get copyWith => _$GateDetectionErrorOccurredCopyWithImpl<GateDetectionErrorOccurred>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionErrorOccurred&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GateDetectionEvent.errorOccurred(message: $message)';
}


}

/// @nodoc
abstract mixin class $GateDetectionErrorOccurredCopyWith<$Res> implements $GateDetectionEventCopyWith<$Res> {
  factory $GateDetectionErrorOccurredCopyWith(GateDetectionErrorOccurred value, $Res Function(GateDetectionErrorOccurred) _then) = _$GateDetectionErrorOccurredCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GateDetectionErrorOccurredCopyWithImpl<$Res>
    implements $GateDetectionErrorOccurredCopyWith<$Res> {
  _$GateDetectionErrorOccurredCopyWithImpl(this._self, this._then);

  final GateDetectionErrorOccurred _self;
  final $Res Function(GateDetectionErrorOccurred) _then;

/// Create a copy of GateDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GateDetectionErrorOccurred(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GateDetectionStopped implements GateDetectionEvent {
  const GateDetectionStopped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionStopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GateDetectionEvent.stopped()';
}


}




/// @nodoc


class GateDetectionResetRequested implements GateDetectionEvent {
  const GateDetectionResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GateDetectionResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GateDetectionEvent.resetRequested()';
}


}




// dart format on
