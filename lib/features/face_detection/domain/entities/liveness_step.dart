/// Represents the individual challenge steps in the liveness detection sequence.
enum LivenessStep {
  /// User must smile.
  smile,

  /// User must turn their head to the right.
  turnRight,

  /// User must turn their head to the left.
  turnLeft,

  /// User must look straight and maintain a neutral expression (no smile).
  lookStraight,
}
