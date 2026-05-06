import 'dart:typed_data';

import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'detected_face_entity.dart';

part 'captured_frame.freezed.dart';

/// Represents a successfully captured frame with face data.
/// Image is kept in-memory (Uint8List) — not persisted to disk.
@freezed
abstract class CapturedFrame with _$CapturedFrame {
  const factory CapturedFrame({
    required Uint8List imageBytes,
    required DateTime capturedAt,
    required DetectedFaceEntity face,
    required Size imageSize,
  }) = _CapturedFrame;
}
