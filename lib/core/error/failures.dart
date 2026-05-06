import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class using freezed for exhaustive pattern matching.
/// Each variant represents a specific failure domain.
@freezed
abstract class Failure with _$Failure {
  const factory Failure.camera({required String message}) = CameraFailure;
  const factory Failure.faceDetection({required String message}) =
      FaceDetectionFailure;
  const factory Failure.permission({required String message}) =
      PermissionFailure;
  const factory Failure.unexpected({required String message}) =
      UnexpectedFailure;
}
