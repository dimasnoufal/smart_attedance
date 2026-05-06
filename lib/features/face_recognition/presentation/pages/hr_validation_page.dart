import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;

import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/core/di/injection.dart';
import 'package:smart_attedance/core/services/auth_local_storage_service.dart';
import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart';
import 'package:smart_attedance/features/face_detection/data/services/face_detector_service.dart';
import 'package:smart_attedance/features/face_detection/presentation/widgets/camera_preview_widget.dart';
import 'package:smart_attedance/features/face_recognition/domain/repositories/face_recognition_repository.dart';
import 'package:smart_attedance/features/face_detection_rounded_box/data/services/inference_isolate.dart';
import 'package:smart_attedance/features/face_recognition/presentation/pages/register_face_page.dart';

class HRValidationPage extends StatefulWidget {
  const HRValidationPage({super.key});

  @override
  State<HRValidationPage> createState() => _HRValidationPageState();
}

class _HRValidationPageState extends State<HRValidationPage> {
  final CameraService _cameraService = getIt<CameraService>();
  final FaceDetectorService _faceDetector = getIt<FaceDetectorService>();
  final InferenceIsolateService _inferenceIsolate = getIt<InferenceIsolateService>();
  final FaceRecognitionRepository _faceRepo = getIt<FaceRecognitionRepository>();
  final AuthLocalStorageService _authStorage = getIt<AuthLocalStorageService>();

  bool _isProcessing = false;
  bool _isCameraReady = false;
  String _statusMessage = 'Arahkan wajah HR ke kamera';

  @override
  void initState() {
    super.initState();
    _initServices();
  }

  Future<void> _initServices() async {
    try {
      if (!_faceDetector.isInitialized) {
        _faceDetector.initialize();
      }
      
      // Stop any existing stream from gate
      if (_cameraService.isStreamingImages) {
        await _cameraService.stopImageStream();
      }

      await _cameraService.initialize(direction: CameraLensDirection.front);
      
      // Start inference isolate if not running
      await _inferenceIsolate.start();

      if (mounted) {
        setState(() {
          _isCameraReady = true;
        });
      }

      // Small delay to let camera warm up, then capture automatically
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && !_isProcessing) {
          _processValidation();
        }
      });
    } catch (e) {
      _showError('Gagal inisialisasi kamera: $e');
    }
  }

  @override
  void dispose() {
    // We don't dispose the services here because they might be reused by GateDetectionBloc
    // The gate will re-initialize them if needed.
    super.dispose();
  }

  Future<void> _processValidation() async {
    if (_isProcessing) return;
    setState(() {
      _isProcessing = true;
      _statusMessage = 'Mengekstrak fitur wajah...';
    });

    try {
      // Get stored HR NIK
      final storedNik = await _authStorage.getEmployeeNik();
      if (storedNik == null || storedNik.isEmpty) {
        _showError('Data HR tidak ditemukan, harap login ulang.');
        return;
      }

      // 1. Capture Image
      final xFile = await _cameraService.captureImageFile();
      if (xFile == null) {
        _showError('Gagal mengambil gambar');
        return;
      }

      final imageBytes = await xFile.readAsBytes();
      
      // 2. Detect Face
      setState(() => _statusMessage = 'Mendeteksi wajah...');
      final inputImage = InputImage.fromFilePath(xFile.path);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        _showError('Wajah tidak terdeteksi, coba lagi.', reset: true);
        return;
      }

      faces.sort((a, b) => (b.boundingBox.width * b.boundingBox.height)
          .compareTo(a.boundingBox.width * a.boundingBox.height));
      final faceBbox = faces.first.boundingBox;

      final decodedImage = img.decodeImage(imageBytes);
      if (decodedImage == null) {
        _showError('Gagal membaca gambar');
        return;
      }

      // 3. Inference
      setState(() => _statusMessage = 'Mencocokkan dengan data HR...');
      final dbResult = await _faceRepo.getAllLocalEmbeddings();
      final storedEmbeddings = dbResult.fold(
        (failure) => <Map<String, dynamic>>[],
        (embeddings) => embeddings.map((e) => {
          'userId': e.userId,
          'name': e.name,
          'embedding': e.embedding,
        }).toList(),
      );

      final response = await _inferenceIsolate.runInference(
        InferenceRequest(
          id: 0,
          imageBytes: imageBytes,
          faceBbox: [faceBbox.left, faceBbox.top, faceBbox.width, faceBbox.height],
          imageSize: [decodedImage.width.toDouble(), decodedImage.height.toDouble()],
          storedEmbeddings: storedEmbeddings,
          matchThreshold: 0.55,
          livenessThreshold: 0.70,
        ),
      );

      if (!response.success || response.isReal != true) {
        _showError('Wajah tidak valid atau terdeteksi palsu.', reset: true);
        return;
      }

      if (response.isRecognized == true && response.matchedUserId == storedNik) {
        // Success Face Match!
        setState(() => _statusMessage = 'Wajah cocok! Verifikasi Password...');
        _showPasswordDialog();
      } else {
        _showError('Wajah tidak sesuai dengan HR yang login.', reset: true);
      }

    } catch (e) {
      _showError('Terjadi kesalahan: $e', reset: true);
    }
  }

  void _showError(String msg, {bool reset = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
    
    if (reset) {
      setState(() {
        _isProcessing = false;
        _statusMessage = 'Arahkan wajah HR ke kamera';
      });
      // Try again after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && !_isProcessing) {
          _processValidation();
        }
      });
    } else {
      Navigator.of(context).pop(); // Exit page if hard error
    }
  }

  void _showPasswordDialog() {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.black.withValues(alpha: 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white24),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Verifikasi Password', style: TextStyle(color: AppColors.white, fontSize: 18)),
              SizedBox(height: 8),
              Text('Masukkan password HR', style: TextStyle(color: Colors.amber, fontSize: 12)),
            ],
          ),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop(); // Close HR validation page entirely
              },
              child: const Text('Batal', style: TextStyle(color: AppColors.grey400)),
            ),
            ElevatedButton(
              onPressed: () async {
                final enteredPassword = passwordController.text.trim();
                final storedPassword = await _authStorage.getPassword();

                if (enteredPassword == storedPassword) {
                  if (!mounted || !dialogContext.mounted) return;
                  Navigator.of(dialogContext).pop(); // Close dialog
                  // Navigate to register and keep validation page in stack to prevent gate bloc from restarting
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RegisterFacePage()),
                  ).then((_) {
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  });
                } else {
                  if (!mounted || !dialogContext.mounted) return;
                  Navigator.of(dialogContext).pop();
                  _showError('Password Salah', reset: true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Verifikasi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text('Verifikasi HR', style: TextStyle(color: AppColors.white, fontSize: 18)),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreviewWidget(
            controller: _cameraService.controller,
            isInitialized: _isCameraReady,
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
              ),
              child: Row(
                children: [
                  if (_isProcessing)
                    const SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2),
                    )
                  else
                    const Icon(Icons.face, color: AppColors.primary),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      _statusMessage,
                      style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
