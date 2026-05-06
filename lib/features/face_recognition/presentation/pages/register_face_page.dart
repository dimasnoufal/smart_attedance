import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/core/di/injection.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart';
import 'package:smart_attedance/features/face_detection/data/services/face_detector_service.dart';
import 'package:smart_attedance/features/face_detection/presentation/widgets/camera_preview_widget.dart';
import 'package:smart_attedance/features/face_recognition/data/services/face_service.dart';
import 'package:smart_attedance/features/face_recognition/domain/usecases/sync_embeddings_usecase.dart';

/// Standalone face registration page.
///
/// This page has its OWN camera lifecycle — completely independent
/// of the GateDetectionBloc pipeline. No face detection, anti-spoofing,
/// or embedding matching runs here. It simply captures a photo and
/// sends it to the server for registration.
class RegisterFacePage extends StatefulWidget {
  const RegisterFacePage({super.key});

  @override
  State<RegisterFacePage> createState() => _RegisterFacePageState();
}

class _RegisterFacePageState extends State<RegisterFacePage> {
  final CameraService _cameraService = getIt<CameraService>();
  final FaceService _faceService = getIt<FaceService>();

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  /// Initialize camera for pure preview only — no streaming, no detection.
  Future<void> _initCamera() async {
    try {
      // If the camera was left in a streaming state by the gate page,
      // stop it first so we get a clean preview.
      if (_cameraService.isStreamingImages) {
        await _cameraService.stopImageStream();
      }

      // Re-initialize if needed (in case it was disposed)
      if (!_cameraService.isInitialized) {
        await _cameraService.initialize(direction: CameraLensDirection.front);
      }

      if (mounted) {
        setState(() {
          _isCameraReady = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuka kamera: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _registerFace() async {
    if (_userIdController.text.trim().isEmpty || _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID dan Nama tidak boleh kosong'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Capture image from camera
      final xFile = await _cameraService.captureImageFile();

      if (xFile == null) {
        throw Exception('Gagal mengambil gambar dari kamera');
      }

      // Initialize FaceDetectorService if needed
      final faceDetector = getIt<FaceDetectorService>();
      if (!faceDetector.isInitialized) {
        faceDetector.initialize();
      }

      // Process image to find face
      final inputImage = InputImage.fromFilePath(xFile.path);
      final faces = await faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        throw Exception(
          'Tidak ada wajah terdeteksi. Pastikan wajah terlihat jelas.',
        );
      }

      // Find the largest face
      faces.sort((a, b) {
        final areaA = a.boundingBox.width * a.boundingBox.height;
        final areaB = b.boundingBox.width * b.boundingBox.height;
        return areaB.compareTo(areaA);
      });
      final bestFace = faces.first;

      // Crop the image to the face bounding box
      final bytes = await xFile.readAsBytes();
      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null) {
        throw Exception('Gagal memproses file gambar');
      }

      int left = bestFace.boundingBox.left.toInt().clamp(0, decodedImage.width);
      int top = bestFace.boundingBox.top.toInt().clamp(0, decodedImage.height);
      int width = bestFace.boundingBox.width.toInt();
      int height = bestFace.boundingBox.height.toInt();

      if (left + width > decodedImage.width) width = decodedImage.width - left;
      if (top + height > decodedImage.height)
        height = decodedImage.height - top;

      // Add a small padding (15%) so it's not too tight
      final padW = (width * 0.15).toInt();
      final padH = (height * 0.15).toInt();

      left = (left - padW).clamp(0, decodedImage.width);
      top = (top - padH).clamp(0, decodedImage.height);
      width = (width + padW * 2).clamp(1, decodedImage.width - left);
      height = (height + padH * 2).clamp(1, decodedImage.height - top);

      final faceCrop = img.copyCrop(
        decodedImage,
        x: left,
        y: top,
        width: width,
        height: height,
      );

      // Resize to 112x112 as required by Buffalo_L model
      final resizedFace = img.copyResize(faceCrop, width: 112, height: 112);

      // Encode cropped face to JPEG bytes
      final croppedBytes = img.encodeJpg(resizedFace);

      // Send to server
      final success = await _faceService.registerFace(
        userId: _userIdController.text.trim(),
        name: _nameController.text.trim(),
        imageBytes: croppedBytes,
      );

      if (success) {
        // Sync embedding data automatically so local DB gets the newly registered face
        final syncUseCase = getIt<SyncEmbeddingsUseCase>();
        await syncUseCase(const NoParams());

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil mendaftarkan wajah dan sinkronisasi data!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.of(context).pop(); // Auto navigate back
      } else {
        throw Exception('Response API mengembalikan false');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mendaftar: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text(
          'Daftar Wajah Baru',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Camera Preview — pure preview, no overlay, no detection
          CameraPreviewWidget(
            controller: _cameraService.controller,
            isInitialized: _isCameraReady,
          ),

          // 2. Simple guide text
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 24,
            right: 24,
            child: Text(
              'Posisikan wajah Anda di dalam frame',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: 0.7),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // 3. Overlay & UI Form — slides up when keyboard appears
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 24,
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).padding.bottom + 24,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _userIdController,
                      decoration: InputDecoration(
                        labelText: 'User ID',
                        hintText: 'Masukkan NIK / User ID Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                      ),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Masukkan Nama Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.badge_outlined),
                      ),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _registerFace,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Daftarkan Wajah',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
