/// Centralized constants for face detection configuration.
/// All thresholds are tuned for optimal balance between
/// accuracy and performance on low-mid range devices.
class FaceDetectionConstants {
  FaceDetectionConstants._();

  /// Minimum face width ratio relative to image width.
  /// Below this threshold → "Terlalu jauh".
  static const double minFaceRatio = 0.15;

  /// Maximum face width ratio relative to image width.
  /// Above this threshold → "Terlalu dekat".
  static const double maxFaceRatio = 0.65;

  /// Minimum interval between frame processing (ms).
  /// Prevents CPU overload on low-end devices.
  static const int frameProcessingIntervalMs = 300;

  /// Duration face must stay valid before auto-capture (ms).
  static const int captureStabilityDelayMs = 1500;

  /// Maximum number of faces allowed for valid detection.
  static const int maxAllowedFaces = 1;

  /// Guide oval width ratio relative to screen width.
  static const double guideOvalWidthRatio = 0.7;

  /// Guide oval height ratio relative to screen width (taller than wide).
  static const double guideOvalHeightRatio = 0.85;

  /// Maximum offset from center before considered "not centered".
  /// Expressed as ratio of image dimension.
  static const double centerToleranceX = 0.18;
  static const double centerToleranceY = 0.22;

  /// Camera resolution preset — medium balances quality vs performance.
  static const String defaultResolution = 'medium';
}
