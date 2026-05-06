/// Custom exception for camera-related errors.
/// Named [CameraServiceException] to avoid conflict with camera package.
class CameraServiceException implements Exception {
  final String message;
  const CameraServiceException(this.message);

  @override
  String toString() => 'CameraServiceException: $message';
}

/// Custom exception for face detection processing errors.
class FaceDetectionProcessException implements Exception {
  final String message;
  const FaceDetectionProcessException(this.message);

  @override
  String toString() => 'FaceDetectionProcessException: $message';
}

/// Custom exception for permission-related errors.
class PermissionDeniedException implements Exception {
  final String message;
  const PermissionDeniedException(this.message);

  @override
  String toString() => 'PermissionDeniedException: $message';
}
