/// Describes the current validation status of face detection.
/// Used by Bloc to drive UI feedback in real-time.
enum FaceValidationStatus {
  /// Initial state — no processing has occurred yet.
  scanning,

  /// No face detected in the frame.
  noFace,

  /// More than one face detected.
  multipleFaces,

  /// Face is too small — user is too far from camera.
  tooFar,

  /// Face is too large — user is too close to camera.
  tooClose,

  /// Face is not centered within the guide oval.
  notCentered,

  /// Face meets all validation criteria.
  valid,
}
