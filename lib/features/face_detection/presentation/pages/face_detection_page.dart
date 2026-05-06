import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/core/constants/app_strings.dart';
import 'package:smart_attedance/core/di/injection.dart';
import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart';
import 'package:smart_attedance/features/face_detection/presentation/bloc/face_detection_bloc.dart';
import 'package:smart_attedance/features/face_detection/presentation/bloc/face_detection_event.dart';
import 'package:smart_attedance/features/face_detection/presentation/bloc/face_detection_state.dart';
import 'package:smart_attedance/features/face_detection/presentation/widgets/camera_preview_widget.dart';
import 'package:smart_attedance/features/face_detection/presentation/widgets/detection_status_widget.dart';
import 'package:smart_attedance/features/face_detection/presentation/widgets/face_overlay_widget.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/recognition_result_entity.dart';
import 'package:smart_attedance/features/face_recognition/presentation/pages/register_face_page.dart';

/// Face Detection Page — full-screen camera with overlay.
///
/// Lifecycle handling:
/// - Paused/Inactive → stop camera stream
/// - Resumed → restart camera if permission granted
/// - Dispose → cleanup all resources
class FaceDetectionPage extends StatefulWidget {
  const FaceDetectionPage({super.key});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage>
    with WidgetsBindingObserver {
  late final FaceDetectionBloc _bloc;
  final CameraService _cameraService = getIt<CameraService>();
  bool _permissionGranted = false;
  bool _permissionChecked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Lock to portrait for consistent face detection
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Immersive mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    _bloc = getIt<FaceDetectionBloc>();
    _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setPreferredOrientations([]);

    _bloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _bloc.add(const FaceDetectionEvent.stopped());
        break;
      case AppLifecycleState.resumed:
        if (_permissionGranted) {
          _bloc.add(const FaceDetectionEvent.started());
        }
        break;
      default:
        break;
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (!mounted) return;

    setState(() {
      _permissionChecked = true;
      _permissionGranted = status.isGranted;
    });

    if (status.isGranted) {
      _bloc.add(const FaceDetectionEvent.started());
    }
  }

  Future<void> _navigateToRegister() async {
    // Stop camera stream safely before navigating
    _bloc.add(const FaceDetectionEvent.stopped());
    
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterFacePage()),
    );
    
    // Resume stream when returning
    _bloc.add(const FaceDetectionEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionChecked && !_permissionGranted) {
      return _buildPermissionDeniedView();
    }

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: BlocConsumer<FaceDetectionBloc, FaceDetectionState>(
          listenWhen: (previous, current) {
            // Only trigger listener when recognition finishes or an error occurs
            return (previous.recognitionResult != current.recognitionResult && current.recognitionResult != null) ||
                   (previous.cameraStatus != current.cameraStatus && current.cameraStatus == CameraStatus.error);
          },
          listener: (context, state) {
            if (state.recognitionResult != null) {
              final result = state.recognitionResult!;
              if (result is RecognizedFace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Berhasil: Wajah dikenali sebagai ${result.userId}!'),
                    backgroundColor: AppColors.success,
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else if (result is UnrecognizedFace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Gagal: Wajah tidak terdaftar dalam database!'),
                    backgroundColor: AppColors.error,
                    duration: Duration(seconds: 2),
                  ),
                );
              }

              // Auto reset after 2 seconds
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  _bloc.add(const FaceDetectionEvent.resetRequested());
                }
              });
            } else if (state.cameraStatus == CameraStatus.error && state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.errorMessage}'),
                  backgroundColor: AppColors.error,
                  duration: const Duration(seconds: 2),
                ),
              );

              // Auto retry after 2 seconds
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  _bloc.add(const FaceDetectionEvent.resetRequested());
                }
              });
            }
          },
          builder: (context, state) {
            final cameraReady =
                state.cameraStatus == CameraStatus.ready ||
                state.cameraStatus == CameraStatus.streaming;

            return GestureDetector(
              onLongPress: _navigateToRegister,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Layer 1: Camera Preview
                CameraPreviewWidget(
                  controller: _cameraService.controller,
                  isInitialized: cameraReady,
                ),

                // Layer 2: Face Overlay (oval guide + progress)
                FaceOverlayWidget(
                  validationStatus: state.validationStatus,
                  captureProgress: state.captureProgress,
                  isLivenessActive: state.isLivenessActive,
                  livenessProgress: state.isLivenessActive
                      ? state.currentLivenessStepIndex /
                            state.livenessSequence.length
                      : 0.0,
                ),

                // Layer 3: Top bar
                _buildTopBar(context),

                // Layer 4: Status indicator
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: DetectionStatusWidget(
                      status: state.validationStatus,
                      isCaptured: state.isCaptured,
                      isLivenessActive: state.isLivenessActive,
                      currentLivenessStep:
                          state.isLivenessActive &&
                              state.currentLivenessStepIndex <
                                  state.livenessSequence.length
                          ? state.livenessSequence[state
                                .currentLivenessStepIndex]
                          : null,
                      isRecognizing: state.isRecognizing,
                      recognitionResult: state.recognitionResult,
                    ),
                  ),
                ),

                // Layer 5: Registration Hint Text
                Positioned(
                  top: MediaQuery.of(context).padding.top + 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Tahan layar untuk mendaftar wajah baru',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 8,
          right: 8,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.black.withValues(alpha: 0.7),
              AppColors.black.withValues(alpha: 0.0),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            AppStrings.faceDetectionTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildPermissionDeniedView() {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.grey400,
                size: 64,
              ),
              const SizedBox(height: 20),
              const Text(
                AppStrings.cameraPermissionDenied,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => openAppSettings(),
                child: const Text('Buka Pengaturan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
