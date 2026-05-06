import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/core/constants/app_strings.dart';
import 'package:smart_attedance/core/di/injection.dart';
import 'package:smart_attedance/core/services/kiosk_service.dart';
import 'package:smart_attedance/core/services/wakelock_service.dart';
import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart';
import 'package:smart_attedance/features/face_detection/presentation/widgets/camera_preview_widget.dart';
import 'package:smart_attedance/features/face_recognition/presentation/pages/hr_validation_page.dart';


import 'package:go_router/go_router.dart';
import 'package:smart_attedance/core/services/auth_local_storage_service.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/presentation/bloc/gate_detection_bloc.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/presentation/bloc/gate_detection_event.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/presentation/bloc/gate_detection_state.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/presentation/widgets/gate_notification_widget.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/presentation/widgets/rounded_box_overlay_widget.dart';

class GateDetectionPage extends StatefulWidget {
  const GateDetectionPage({super.key});

  @override
  State<GateDetectionPage> createState() => _GateDetectionPageState();
}

class _GateDetectionPageState extends State<GateDetectionPage>
    with WidgetsBindingObserver {
  late final GateDetectionBloc _bloc;
  final CameraService _cameraService = getIt<CameraService>();
  final GateNotificationManager _notification = GateNotificationManager();
  final AuthLocalStorageService _authStorage = getIt<AuthLocalStorageService>();
  final WakelockService _wakelockService = getIt<WakelockService>();
  final KioskService _kioskService = getIt<KioskService>();
  bool _permissionGranted = false;
  bool _permissionChecked = false;
  bool _isShowingNotification = false;

  int _tapCount = 0;
  DateTime _lastTapTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _bloc = getIt<GateDetectionBloc>();
    _requestCameraPermission();

    // Keep the screen awake for the attendance gate
    _wakelockService.enable();

    // Lock the app in kiosk mode (Android only)
    _kioskService.startKioskMode();
  }

  @override
  void dispose() {
    _notification.dispose();
    WidgetsBinding.instance.removeObserver(this);

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
        _bloc.add(const GateDetectionEvent.stopped());
        break;
      case AppLifecycleState.resumed:
        // Re-enable wake lock in case the OS released it
        _wakelockService.enable();
        if (_permissionGranted) {
          _bloc.add(const GateDetectionEvent.started());
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
      _bloc.add(const GateDetectionEvent.started());
    }
  }

  Future<void> _handleLongPress() async {
    _bloc.add(const GateDetectionEvent.stopped());
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HRValidationPage()),
    );
    _bloc.add(const GateDetectionEvent.started());
  }

  void _handleTopBarTap() {
    final now = DateTime.now();
    if (now.difference(_lastTapTime) < const Duration(milliseconds: 500)) {
      _tapCount++;
      if (_tapCount == 3) {
        _tapCount = 0;
        _showLogoutDialog();
      }
    } else {
      _tapCount = 1;
    }
    _lastTapTime = now;
  }

  Future<void> _showLogoutDialog() async {
    _bloc.add(const GateDetectionEvent.stopped());
    final nik = await _authStorage.getEmployeeNik();
    
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.black.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white24),
        ),
        title: const Text('Logout HR', style: TextStyle(color: AppColors.white)),
        content: Text('Apakah Anda ingin keluar dari akun HR (NIK: $nik)?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _bloc.add(const GateDetectionEvent.started());
            },
            child: const Text('Batal', style: TextStyle(color: AppColors.grey400)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              // Stop kiosk mode before navigating away
              await _kioskService.stopKioskMode();
              // Disable wake lock — login page doesn't need it
              await _wakelockService.disable();
              // Restore system UI for login page
              await SystemChrome.setEnabledSystemUIMode(
                SystemUiMode.manual,
                overlays: SystemUiOverlay.values,
              );
              await _authStorage.clearAll();
              if (!mounted) return;
              Navigator.of(ctx).pop(); // close dialog
              context.go('/login'); // back to login
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  void _showDebouncedNotification(
    BuildContext context, {
    required String title,
    required String subtitle,
    required NotificationType type,
    String? userId,
  }) {
    if (_isShowingNotification) return; // Prevent spam/overlap
    
    setState(() => _isShowingNotification = true);
    
    _notification.show(
      context,
      title: title,
      subtitle: subtitle,
      type: type,
      userId: userId,
    );

    // Assume the banner stays for 3 seconds, so unlock after 3.5s
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        setState(() => _isShowingNotification = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionChecked) {
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (!_permissionGranted) {
      return _buildPermissionDeniedView();
    }

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: BlocConsumer<GateDetectionBloc, GateDetectionState>(
          listenWhen: (prev, curr) =>
              prev.processStatus != curr.processStatus ||
              (prev.cameraStatus != curr.cameraStatus &&
                  curr.cameraStatus == GateCameraStatus.error),
          listener: (context, state) {
            // Show notification on camera error
            if (state.cameraStatus == GateCameraStatus.error && state.errorMessage != null) {
              _showDebouncedNotification(
                context,
                title: 'Kamera Error',
                subtitle: state.errorMessage!,
                type: NotificationType.error,
              );
            }

            // Show notification on attendance success
            if (state.processStatus == GateProcessStatus.attendanceSuccess) {
              _showDebouncedNotification(
                context,
                title: 'Absen Masuk Berhasil',
                subtitle: 'Data absensi telah tercatat',
                type: NotificationType.success,
              );
            }

            // Show notification on attendance failure
            if (state.processStatus == GateProcessStatus.attendanceFailed && state.errorMessage != null) {
              _showDebouncedNotification(
                context,
                title: 'Absen Gagal',
                subtitle: state.errorMessage!,
                type: NotificationType.error,
              );
            }

            // Show notification on process failure (e.g. spoofing, unrecognized)
            if (state.processStatus == GateProcessStatus.failed && state.errorMessage != null) {
              _showDebouncedNotification(
                context,
                title: 'Verifikasi Gagal',
                subtitle: state.errorMessage!,
                type: NotificationType.error,
              );
            }
          },
          builder: (context, state) {
            final cameraReady =
                state.cameraStatus == GateCameraStatus.ready ||
                state.cameraStatus == GateCameraStatus.streaming;

            return GestureDetector(
              onLongPress: _handleLongPress,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Camera preview
                  CameraPreviewWidget(
                    controller: _cameraService.controller,
                    isInitialized: cameraReady,
                  ),

                  // Dynamic face-tracking overlay
                  FaceTrackingOverlayWidget(
                    faceBounds: state.trackedFace?.boundingBox,
                    imageSize: state.imageSize,
                    borderColor: _getBorderColor(state),
                  ),

                  // Top gradient bar
                  _buildTopBar(context),

                  // Bottom info card
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 40,
                    left: 24,
                    right: 24,
                    child: _buildInfoCard(state),
                  ),

                  // Long-press hint at very bottom
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 12,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Tekan dan tahan layar untuk mendaftarkan wajah',
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.4),
                          fontSize: 11,
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

  // ─────────────────────────────────────────────────────────
  // UI Helpers
  // ─────────────────────────────────────────────────────────

  Color _getBorderColor(GateDetectionState state) {
    switch (state.processStatus) {
      case GateProcessStatus.scanning:
        return AppColors.white;
      case GateProcessStatus.faceDetected:
        return const Color(0xFF4FC3F7); // Light blue — face detected
      case GateProcessStatus.capturing:
      case GateProcessStatus.antiSpoofing:
      case GateProcessStatus.recognizing:
        return const Color(0xFFFFA726); // Orange — processing
      case GateProcessStatus.success:
      case GateProcessStatus.attendanceSuccess:
        return AppColors.success;
      case GateProcessStatus.attendanceFailed:
      case GateProcessStatus.failed:
        return AppColors.error;
    }
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: _handleTopBarTap,
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
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
              'Face Recognition',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(GateDetectionState state) {
    final bool isProcessing =
        state.processStatus == GateProcessStatus.capturing ||
        state.processStatus == GateProcessStatus.antiSpoofing ||
        state.processStatus == GateProcessStatus.recognizing;

    IconData iconData;
    Color iconColor;

    switch (state.processStatus) {
      case GateProcessStatus.scanning:
        iconData = Icons.face_retouching_natural;
        iconColor = AppColors.white.withValues(alpha: 0.6);
        break;
      case GateProcessStatus.faceDetected:
        iconData = Icons.face;
        iconColor = const Color(0xFF4FC3F7);
        break;
      case GateProcessStatus.capturing:
      case GateProcessStatus.antiSpoofing:
      case GateProcessStatus.recognizing:
        iconData = Icons.hourglass_top_rounded;
        iconColor = const Color(0xFFFFA726);
        break;
      case GateProcessStatus.success:
      case GateProcessStatus.attendanceSuccess:
        iconData = Icons.verified_user_rounded;
        iconColor = AppColors.success;
        break;
      case GateProcessStatus.failed:
      case GateProcessStatus.attendanceFailed:
        iconData = Icons.error_outline_rounded;
        iconColor = AppColors.error;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconColor.withValues(alpha: 0.15),
            child: isProcessing
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: iconColor,
                      strokeWidth: 2.5,
                    ),
                  )
                : Icon(iconData, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.statusMessage,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (state.faceCount > 1) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${state.faceCount} wajah terdeteksi — fokus ke yang terdekat',
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedView() {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
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
              style: TextStyle(color: AppColors.white),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => openAppSettings(),
              child: const Text('Buka Pengaturan'),
            ),
          ],
        ),
      ),
    );
  }
}


