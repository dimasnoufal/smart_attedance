import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/core/constants/app_strings.dart';

/// Full-screen camera preview widget with loading state.
/// Handles aspect ratio correction to prevent distortion.
class CameraPreviewWidget extends StatelessWidget {
  final CameraController? controller;
  final bool isInitialized;

  const CameraPreviewWidget({
    super.key,
    required this.controller,
    required this.isInitialized,
  });

  @override
  Widget build(BuildContext context) {
    if (!isInitialized || controller == null) {
      return Container(
        color: AppColors.black,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2.0,
              ),
              SizedBox(height: 16),
              Text(
                AppStrings.cameraInitializing,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller!.value.previewSize?.height ?? 1,
          height: controller!.value.previewSize?.width ?? 1,
          child: CameraPreview(controller!),
        ),
      ),
    );
  }
}
