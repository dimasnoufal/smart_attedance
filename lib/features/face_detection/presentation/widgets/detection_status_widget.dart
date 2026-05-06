import 'package:flutter/material.dart';

import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/core/constants/app_strings.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_validation_status.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/liveness_step.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/recognition_result_entity.dart';

/// Animated status indicator shown at the bottom of the face detection screen.
/// Displays contextual feedback with smooth transitions between states.
class DetectionStatusWidget extends StatelessWidget {
  final FaceValidationStatus status;
  final bool isCaptured;
  final bool isLivenessActive;
  final LivenessStep? currentLivenessStep;
  final bool isRecognizing;
  final RecognitionResultEntity? recognitionResult;

  const DetectionStatusWidget({
    super.key,
    required this.status,
    required this.isCaptured,
    required this.isLivenessActive,
    this.currentLivenessStep,
    this.isRecognizing = false,
    this.recognitionResult,
  });

  String _statusText() {
    if (isRecognizing) return 'Mencocokkan Wajah...';
    
    if (recognitionResult != null) {
      if (recognitionResult is RecognizedFace) {
        return 'Halo, ${(recognitionResult as RecognizedFace).userId}!';
      } else {
        return 'Wajah Tidak Dikenali';
      }
    }

    if (isCaptured) return AppStrings.captureSuccess;

    if (isLivenessActive && currentLivenessStep != null) {
      switch (currentLivenessStep!) {
        case LivenessStep.smile:
          return AppStrings.livenessSmile;
        case LivenessStep.turnRight:
          return AppStrings.livenessTurnRight;
        case LivenessStep.turnLeft:
          return AppStrings.livenessTurnLeft;
        case LivenessStep.lookStraight:
          return AppStrings.livenessLookStraight;
      }
    }

    switch (status) {
      case FaceValidationStatus.scanning:
        return AppStrings.scanning;
      case FaceValidationStatus.noFace:
        return AppStrings.noFaceDetected;
      case FaceValidationStatus.multipleFaces:
        return AppStrings.multipleFaces;
      case FaceValidationStatus.tooFar:
        return AppStrings.tooFar;
      case FaceValidationStatus.tooClose:
        return AppStrings.tooClose;
      case FaceValidationStatus.notCentered:
        return AppStrings.notCentered;
      case FaceValidationStatus.valid:
        return AppStrings.faceDetected;
    }
  }

  IconData _statusIcon() {
    if (isRecognizing) return Icons.face_retouching_natural_rounded;

    if (recognitionResult != null) {
      if (recognitionResult is RecognizedFace) {
        return Icons.verified_user_rounded;
      } else {
        return Icons.error_outline_rounded;
      }
    }

    if (isCaptured) return Icons.check_circle_rounded;

    if (isLivenessActive && currentLivenessStep != null) {
      switch (currentLivenessStep!) {
        case LivenessStep.smile:
          return Icons.sentiment_very_satisfied_rounded;
        case LivenessStep.turnRight:
          return Icons.turn_right_rounded;
        case LivenessStep.turnLeft:
          return Icons.turn_left_rounded;
        case LivenessStep.lookStraight:
          return Icons.face_rounded;
      }
    }

    switch (status) {
      case FaceValidationStatus.scanning:
        return Icons.face_retouching_natural;
      case FaceValidationStatus.noFace:
        return Icons.face_outlined;
      case FaceValidationStatus.multipleFaces:
        return Icons.groups_outlined;
      case FaceValidationStatus.tooFar:
        return Icons.zoom_in_rounded;
      case FaceValidationStatus.tooClose:
        return Icons.zoom_out_rounded;
      case FaceValidationStatus.notCentered:
        return Icons.center_focus_weak_rounded;
      case FaceValidationStatus.valid:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color _statusColor() {
    if (isRecognizing) return AppColors.primary;

    if (recognitionResult != null) {
      if (recognitionResult is RecognizedFace) {
        return AppColors.success;
      } else {
        return AppColors.error;
      }
    }

    if (isCaptured) return AppColors.success;

    if (isLivenessActive) return AppColors.primary;

    switch (status) {
      case FaceValidationStatus.valid:
        return AppColors.success;
      case FaceValidationStatus.scanning:
        return AppColors.white;
      case FaceValidationStatus.tooFar:
      case FaceValidationStatus.tooClose:
      case FaceValidationStatus.notCentered:
        return AppColors.warning;
      case FaceValidationStatus.noFace:
      case FaceValidationStatus.multipleFaces:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey('${status.name}-$isCaptured-${currentLivenessStep?.name}-$isRecognizing-${recognitionResult != null}'),
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _statusIcon(),
              color: color,
              size: 22,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                _statusText(),
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
