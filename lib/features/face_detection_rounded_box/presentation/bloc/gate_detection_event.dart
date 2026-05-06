import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';

part 'gate_detection_event.freezed.dart';

@freezed
abstract class GateDetectionEvent with _$GateDetectionEvent {
  const factory GateDetectionEvent.started() = GateDetectionStarted;
  const factory GateDetectionEvent.cameraInitialized() = GateDetectionCameraInitialized;
  const factory GateDetectionEvent.frameReceived({required dynamic image}) = GateDetectionFrameReceived;
  const factory GateDetectionEvent.faceReady({required CapturedFrame frame}) = GateDetectionFaceReady;
  const factory GateDetectionEvent.errorOccurred({required String message}) = GateDetectionErrorOccurred;
  const factory GateDetectionEvent.stopped() = GateDetectionStopped;
  const factory GateDetectionEvent.resetRequested() = GateDetectionResetRequested;
}
