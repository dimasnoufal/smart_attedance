import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_bounds.freezed.dart';

/// Platform-agnostic bounding box for detected face.
/// Decouples domain layer from dart:ui [Rect].
@freezed
abstract class FaceBounds with _$FaceBounds {
  const factory FaceBounds({
    required double left,
    required double top,
    required double width,
    required double height,
  }) = _FaceBounds;
}

/// Extension to provide computed properties on [FaceBounds].
extension FaceBoundsX on FaceBounds {
  /// Center X coordinate of the bounding box.
  double get centerX => left + width / 2;

  /// Center Y coordinate of the bounding box.
  double get centerY => top + height / 2;
}
