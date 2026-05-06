import 'dart:async';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';
import 'package:image/image.dart' as img;


import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart';
import 'package:smart_attedance/features/face_detection/data/services/face_detector_service.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/captured_frame.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/detected_face_entity.dart';
import 'package:smart_attedance/features/face_detection/domain/usecases/detect_faces_usecase.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/recognition_result_entity.dart';
import 'package:smart_attedance/features/face_recognition/domain/repositories/face_recognition_repository.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/data/services/inference_isolate.dart';
import 'package:smart_attedance/core/services/attendance_service.dart';
import 'package:smart_attedance/core/services/location_service.dart';

import 'gate_detection_event.dart';
import 'gate_detection_state.dart';

/// KAI Gate-style passive face recognition Bloc.
///
/// Architecture:
/// - **UI thread**: Camera stream → ML Kit face detection → bounding box tracking
/// - **Background isolate**: Anti-spoofing → Embedding → Cosine similarity
///
/// Face tracking continues at full speed even while the AI pipeline runs
/// in the background, ensuring smooth 60fps bounding box movement.
@injectable
class GateDetectionBloc extends Bloc<GateDetectionEvent, GateDetectionState> {
  final CameraService _cameraService;
  final FaceDetectorService _faceDetectorService;
  final DetectFacesUseCase _detectFacesUseCase;
  final InferenceIsolateService _inferenceIsolate;
  final FaceRecognitionRepository _faceRecognitionRepository;
  final AttendanceService _attendanceService;
  final LocationService _locationService;

  bool _isProcessingFrame = false;
  bool _isPipelineRunning = false;
  DateTime? _lastProcessedTime;

  /// Tracks how many consecutive frames had a valid face.
  int _stableFaceFrameCount = 0;
  static const int _requiredStableFrames = 3;

  /// Tracks consecutive unrecognized faces to prevent UI spam.
  int _unrecognizedCount = 0;

  /// Minimum face-to-image width ratio for the crop to be usable by models.
  static const double _minFaceRatio = 0.10;

  /// Throttle interval for frame processing (ms).
  /// Reduced from 300ms → 150ms for more responsive tracking.
  static const int _frameIntervalMs = 150;

  GateDetectionBloc(
    this._cameraService,
    this._faceDetectorService,
    this._detectFacesUseCase,
    this._inferenceIsolate,
    this._faceRecognitionRepository,
    this._attendanceService,
    this._locationService,
  ) : super(const GateDetectionState()) {
    on<GateDetectionStarted>(_onStarted);
    on<GateDetectionCameraInitialized>(_onCameraInitialized);
    on<GateDetectionFrameReceived>(_onFrameReceived);
    on<GateDetectionFaceReady>(_onFaceReady);
    on<GateDetectionErrorOccurred>(_onErrorOccurred);
    on<GateDetectionStopped>(_onStopped);
    on<GateDetectionResetRequested>(_onResetRequested);
  }

  // ─────────────────────────────────────────────────────────
  // Camera Lifecycle
  // ─────────────────────────────────────────────────────────

  Future<void> _onStarted(
    GateDetectionStarted event,
    Emitter<GateDetectionState> emit,
  ) async {
    emit(state.copyWith(cameraStatus: GateCameraStatus.initializing));

    try {
      if (!_faceDetectorService.isInitialized) {
        _faceDetectorService.initialize();
      }

      // Start inference isolate in parallel with camera init
      final isolateFuture = _inferenceIsolate.start();

      await _cameraService.initialize(direction: CameraLensDirection.front);

      // Wait for isolate to be ready (models loaded)
      await isolateFuture;

      add(const GateDetectionEvent.cameraInitialized());
    } catch (e) {
      add(GateDetectionEvent.errorOccurred(message: e.toString()));
    }
  }

  Future<void> _onCameraInitialized(
    GateDetectionCameraInitialized event,
    Emitter<GateDetectionState> emit,
  ) async {
    emit(state.copyWith(cameraStatus: GateCameraStatus.ready));

    try {
      await _cameraService.startImageStream(_onCameraFrame);
      emit(state.copyWith(cameraStatus: GateCameraStatus.streaming));
    } catch (e) {
      add(GateDetectionEvent.errorOccurred(message: e.toString()));
    }
  }

  // ─────────────────────────────────────────────────────────
  // Frame Processing (Passive Detection — always runs)
  // ─────────────────────────────────────────────────────────

  void _onCameraFrame(CameraImage image) {
    if (state.cameraStatus == GateCameraStatus.disposed) return;

    // Only skip if another ML Kit detection is in-flight.
    // NOTE: Do NOT skip when pipeline is running — tracking must continue.
    if (_isProcessingFrame) return;

    final now = DateTime.now();
    if (_lastProcessedTime != null &&
        now.difference(_lastProcessedTime!).inMilliseconds < _frameIntervalMs) {
      return;
    }

    _lastProcessedTime = now;
    add(GateDetectionEvent.frameReceived(image: image));
  }

  Future<void> _onFrameReceived(
    GateDetectionFrameReceived event,
    Emitter<GateDetectionState> emit,
  ) async {
    if (state.cameraStatus == GateCameraStatus.disposed) return;
    if (_isProcessingFrame) return;
    _isProcessingFrame = true;

    try {
      final camera = _cameraService.currentCamera;
      if (camera == null) {
        _isProcessingFrame = false;
        return;
      }

      // 1. Detect faces via ML Kit (this is fast — ~20-40ms, native threaded)
      final result = await _detectFacesUseCase(
        DetectFacesParams(image: event.image, camera: camera),
      );

      result.fold(
        (failure) {
          _stableFaceFrameCount = 0;
          if (!_isPipelineRunning) {
            emit(
              state.copyWith(
                processStatus: GateProcessStatus.scanning,
                trackedFace: null,
                faceCount: 0,
                imageSize: null,
                statusMessage: 'Arahkan wajah Anda ke kamera',
              ),
            );
          }
        },
        (detectionResult) {
          if (detectionResult.faces.isEmpty) {
            _stableFaceFrameCount = 0;
            // Always update face tracking, even during pipeline
            emit(
              state.copyWith(
                processStatus: _isPipelineRunning
                    ? state.processStatus
                    : GateProcessStatus.scanning,
                trackedFace: null,
                faceCount: 0,
                imageSize: null,
                statusMessage: _isPipelineRunning
                    ? state.statusMessage
                    : 'Arahkan wajah Anda ke kamera',
              ),
            );
            return;
          }

          // 2. Pick the LARGEST face
          final faces = List<DetectedFaceEntity>.from(detectionResult.faces);
          faces.sort((a, b) {
            final areaA = a.boundingBox.width * a.boundingBox.height;
            final areaB = b.boundingBox.width * b.boundingBox.height;
            return areaB.compareTo(areaA);
          });

          final bestFace = faces.first;
          final imageSize = Size(
            event.image.width.toDouble(),
            event.image.height.toDouble(),
          );

          // Always emit face tracking data — even during pipeline.
          // This keeps the bounding box overlay moving smoothly.
          emit(
            state.copyWith(
              trackedFace: bestFace,
              imageSize: imageSize,
              faceCount: faces.length,
            ),
          );

          // Don't trigger pipeline if it's already running
          if (_isPipelineRunning) return;

          // 3. Quality check
          final faceWidthRatio = bestFace.boundingBox.width / imageSize.width;

          if (faceWidthRatio < _minFaceRatio) {
            _stableFaceFrameCount = 0;
            emit(
              state.copyWith(
                processStatus: GateProcessStatus.faceDetected,
                statusMessage: 'Dekatkan wajah sedikit...',
              ),
            );
            return;
          }

          // 4. Stability counter
          _stableFaceFrameCount++;

          emit(
            state.copyWith(
              processStatus: GateProcessStatus.faceDetected,
              statusMessage: 'Wajah terdeteksi, harap tunggu...',
            ),
          );

          // 5. Trigger pipeline when stable
          if (_stableFaceFrameCount >= _requiredStableFrames) {
            _stableFaceFrameCount = 0;

            add(
              GateDetectionEvent.faceReady(
                frame: CapturedFrame(
                  imageBytes: Uint8List(0),
                  capturedAt: DateTime.now(),
                  face: bestFace,
                  imageSize: imageSize,
                ),
              ),
            );
          }
        },
      );
    } finally {
      _isProcessingFrame = false;
    }
  }

  // ─────────────────────────────────────────────────────────
  // Recognition Pipeline (runs on background isolate)
  // ─────────────────────────────────────────────────────────

  Future<void> _onFaceReady(
    GateDetectionFaceReady event,
    Emitter<GateDetectionState> emit,
  ) async {
    if (state.cameraStatus == GateCameraStatus.disposed) return;
    if (_isPipelineRunning) return;
    _isPipelineRunning = true;

    // ── Step 1: Capture JPEG via takePicture (same format as register) ──
    emit(
      state.copyWith(
        processStatus: GateProcessStatus.capturing,
        statusMessage: 'Memproses wajah...',
      ),
    );

    Uint8List imageBytes;
    Size capturedImageSize;
    Rect faceBbox;

    try {
      // Stop stream, take picture, get bytes
      if (_cameraService.isStreamingImages) {
        await _cameraService.stopImageStream();
      }
      final xFile = await _cameraService.controller!.takePicture();
      imageBytes = await xFile.readAsBytes();

      // Re-detect face in the captured JPEG so bbox matches pixels exactly
      final inputImage = InputImage.fromFilePath(xFile.path);
      final faces = await _faceDetectorService.processImage(inputImage);

      if (faces.isEmpty) {
        _emitFailureAndReset(emit, 'Wajah tidak terdeteksi saat capture');
        _isPipelineRunning = false;
        await _restartStream();
        return;
      }

      // Pick the largest face
      faces.sort((a, b) {
        final areaA = a.boundingBox.width * a.boundingBox.height;
        final areaB = b.boundingBox.width * b.boundingBox.height;
        return areaB.compareTo(areaA);
      });

      faceBbox = faces.first.boundingBox;

      // Get actual image dimensions
      final decodedImage = img.decodeImage(imageBytes);
      if (decodedImage == null) {
        _emitFailureAndReset(emit, 'Gagal decode gambar');
        _isPipelineRunning = false;
        await _restartStream();
        return;
      }
      capturedImageSize = Size(
        decodedImage.width.toDouble(),
        decodedImage.height.toDouble(),
      );

      // Restart stream immediately (preview resumes while AI runs in background)
      await _restartStream();
    } catch (e) {
      _emitFailureAndReset(emit, 'Gagal mengambil gambar: $e');
      _isPipelineRunning = false;
      await _restartStream();
      return;
    }

    // ── Step 2: Send everything to background isolate ──
    emit(
      state.copyWith(
        processStatus: GateProcessStatus.antiSpoofing,
        statusMessage: 'Mengecek keaslian wajah...',
      ),
    );

    // Fetch stored embeddings for matching (this is fast — SQLite)
    final dbResult = await _faceRecognitionRepository.getAllLocalEmbeddings();
    final storedEmbeddings = dbResult.fold(
      (failure) => <Map<String, dynamic>>[],
      (embeddings) => embeddings
          .map((e) => {
                'userId': e.userId,
                'name': e.name,
                'embedding': e.embedding,
              })
          .toList(),
    );

    try {
      final response = await _inferenceIsolate.runInference(
        InferenceRequest(
          id: 0,
          imageBytes: imageBytes,
          // Use re-detected bbox from captured image — always accurate
          faceBbox: [
            faceBbox.left,
            faceBbox.top,
            faceBbox.width,
            faceBbox.height,
          ],
          imageSize: [capturedImageSize.width, capturedImageSize.height],
          storedEmbeddings: storedEmbeddings,
          matchThreshold: 0.55,
          livenessThreshold: 0.70,
        ),
      );

      if (!response.success) {
        _emitFailureAndReset(emit, 'Verifikasi gagal: ${response.error}');
        _isPipelineRunning = false;
        return;
      }

      // Anti-spoofing failed
      if (response.isReal != true) {
        _emitFailureAndReset(emit, 'Wajah terdeteksi palsu (Foto/Layar)');
        _isPipelineRunning = false;
        return;
      }

      // Update status for embedding phase
      emit(
        state.copyWith(
          processStatus: GateProcessStatus.recognizing,
          statusMessage: 'Mencocokkan wajah...',
        ),
      );

      // Build recognition result
      final RecognitionResultEntity recognitionResult;
      String? matchedName;

      if (response.isRecognized == true && response.matchedUserId != null) {
        // Find the name from stored embeddings
        final matchedEmbedding = storedEmbeddings.where(
          (e) => e['userId'] == response.matchedUserId,
        );
        if (matchedEmbedding.isNotEmpty) {
          matchedName = matchedEmbedding.first['name'] as String?;
        }

        recognitionResult = RecognitionResultEntity.recognized(
          userId: response.matchedUserId!,
          name: matchedName ?? '',
          similarityScore: response.similarityScore ?? 0.0,
        );
        
        // Reset unrecognized count on success
        _unrecognizedCount = 0;
      } else {
        recognitionResult = RecognitionResultEntity.unrecognized(
          highestSimilarityScore: response.similarityScore ?? 0.0,
        );
        
        _unrecognizedCount++;
      }

      final displayName = matchedName?.isNotEmpty == true
          ? matchedName!
          : (response.matchedUserId ?? 'Unknown');

      final message = switch (recognitionResult) {
        RecognizedFace() => 'Selamat datang, $displayName!',
        UnrecognizedFace() => 'Wajah tidak terdaftar',
        _ => 'Hasil tidak diketahui',
      };

      dev.log(
        'Pipeline complete: ${response.isReal}, score=${response.livenessScore}, '
        'match=${response.isRecognized}, sim=${response.similarityScore}',
        name: 'GateDetectionBloc',
      );

      if (recognitionResult is RecognizedFace) {
        emit(
          state.copyWith(
            processStatus: GateProcessStatus.success,
            recognitionResult: recognitionResult,
            statusMessage: message,
          ),
        );
        // Wait for API to complete to show success/fail banner
        await _submitAttendance(emit, recognitionResult.userId, displayName);
      } else {
        // It's unrecognized. Only emit failure if count >= 5
        if (_unrecognizedCount >= 5) {
          _emitFailureAndReset(emit, 'Wajah Tidak Terdaftar');
          _unrecognizedCount = 0; // Reset after showing
        } else {
          // Silently reset without showing banner
          emit(
            state.copyWith(
              processStatus: GateProcessStatus.scanning,
              statusMessage: 'Mencoba mengenali ulang...',
              trackedFace: null,
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!isClosed) add(const GateDetectionEvent.resetRequested());
          });
        }
      }
    } catch (e) {
      _emitFailureAndReset(emit, 'Verifikasi gagal: $e');
    }

    _isPipelineRunning = false;
  }

  /// Submits attendance in the background after a successful face recognition.
  Future<void> _submitAttendance(Emitter<GateDetectionState> emit, String employeeNik, String displayName) async {
    try {
      final location = _locationService.currentLocation;
      if (location == null) {
        _emitAttendanceFailure(emit, 'Lokasi belum tersedia');
        return;
      }

      final result = await _attendanceService.submitAttendance(
        employeeNik: employeeNik,
        latitude: location.latitude.toString(),
        longitude: location.longitude.toString(),
        addressDetail: location.addressDetail,
      );

      if (result.success) {
        dev.log(
          'Attendance submitted successfully! Time: ${result.time}',
          name: 'GateDetectionBloc',
        );
        
        final dt = DateTime.now();
        final minute = dt.minute.toString().padLeft(2, '0');
        final period = dt.hour < 12 ? 'AM' : 'PM';
        final h12 = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
        final timeStr = '${h12.toString().padLeft(2, '0')}:$minute $period';

        emit(
          state.copyWith(
            processStatus: GateProcessStatus.attendanceSuccess,
            statusMessage: 'Absen Berhasil - $displayName ($timeStr)',
          ),
        );
      } else {
        dev.log(
          'Attendance submission failed: ${result.message}',
          name: 'GateDetectionBloc',
        );
        _emitAttendanceFailure(emit, result.message ?? 'Absen gagal');
      }
    } catch (e) {
      dev.log(
        'Attendance submission error: $e',
        error: e,
        name: 'GateDetectionBloc',
      );
      _emitAttendanceFailure(emit, e.toString());
    }
    
    // Auto reset
    Future.delayed(const Duration(seconds: 3), () {
      if (!isClosed) add(const GateDetectionEvent.resetRequested());
    });
  }

  void _emitAttendanceFailure(Emitter<GateDetectionState> emit, String message) {
    emit(
      state.copyWith(
        processStatus: GateProcessStatus.attendanceFailed,
        errorMessage: message,
        statusMessage: message,
      ),
    );
  }

  void _emitFailureAndReset(Emitter<GateDetectionState> emit, String message) {
    emit(
      state.copyWith(
        processStatus: GateProcessStatus.failed,
        statusMessage: message,
        errorMessage: message,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed) add(const GateDetectionEvent.resetRequested());
    });
  }

  // ─────────────────────────────────────────────────────────
  // Lifecycle Events
  // ─────────────────────────────────────────────────────────

  void _onErrorOccurred(
    GateDetectionErrorOccurred event,
    Emitter<GateDetectionState> emit,
  ) {
    emit(
      state.copyWith(
        errorMessage: event.message,
        cameraStatus: GateCameraStatus.error,
        statusMessage: 'Terjadi kesalahan',
      ),
    );
  }

  Future<void> _onStopped(
    GateDetectionStopped event,
    Emitter<GateDetectionState> emit,
  ) async {
    await _cameraService.stopImageStream();
    emit(state.copyWith(cameraStatus: GateCameraStatus.disposed));
  }

  Future<void> _onResetRequested(
    GateDetectionResetRequested event,
    Emitter<GateDetectionState> emit,
  ) async {
    if (state.cameraStatus == GateCameraStatus.disposed) return;

    _isProcessingFrame = false;
    _isPipelineRunning = false;
    _lastProcessedTime = null;
    _stableFaceFrameCount = 0;

    emit(
      const GateDetectionState(
        cameraStatus: GateCameraStatus.ready,
        processStatus: GateProcessStatus.scanning,
        statusMessage: 'Arahkan wajah Anda ke kamera',
      ),
    );

    await _restartStream();
  }

  Future<void> _restartStream() async {
    try {
      if (_cameraService.isStreamingImages) {
        await _cameraService.stopImageStream();
      }
      await _cameraService.startImageStream(_onCameraFrame);
    } catch (e) {
      dev.log('Failed to restart stream: $e', name: 'GateDetectionBloc');
    }
  }

  @override
  Future<void> close() async {
    await _faceDetectorService.dispose();
    await _cameraService.dispose();
    await _inferenceIsolate.stop();
    return super.close();
  }
}
