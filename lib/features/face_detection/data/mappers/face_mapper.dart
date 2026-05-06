import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_bounds.dart';

/// Maps between ML Kit [Face] objects and domain [DetectedFaceEntity].
/// Keeps ML Kit dependency isolated in the data layer.
class FaceMapper {
  FaceMapper._();

  /// Converts ML Kit [Face] to domain [DetectedFaceEntity].
  static DetectedFaceEntity fromMlKitFace(Face face) {
    return DetectedFaceEntity(
      boundingBox: FaceBounds(
        left: face.boundingBox.left,
        top: face.boundingBox.top,
        width: face.boundingBox.width,
        height: face.boundingBox.height,
      ),
      headEulerAngleY: face.headEulerAngleY,
      headEulerAngleX: face.headEulerAngleX,
      headEulerAngleZ: face.headEulerAngleZ,
      smilingProbability: face.smilingProbability,
      leftEyeOpenProbability: face.leftEyeOpenProbability,
      rightEyeOpenProbability: face.rightEyeOpenProbability,
      trackingId: face.trackingId,
    );
  }

  /// Batch conversion of multiple faces.
  static List<DetectedFaceEntity> fromMlKitFaces(List<Face> faces) {
    return faces.map(fromMlKitFace).toList();
  }
}
