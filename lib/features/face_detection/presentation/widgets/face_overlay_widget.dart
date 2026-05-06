import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/core/constants/face_detection_constants.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_validation_status.dart';

/// Overlay widget that draws:
/// 1. Semi-transparent dark background outside the oval guide.
/// 2. Animated oval border that changes color based on validation status.
/// 3. Corner decorations for a modern scanner look.
class FaceOverlayWidget extends StatefulWidget {
  final FaceValidationStatus validationStatus;
  final double captureProgress;
  final bool isLivenessActive;
  final double livenessProgress;

  const FaceOverlayWidget({
    super.key,
    required this.validationStatus,
    required this.captureProgress,
    this.isLivenessActive = false,
    this.livenessProgress = 0.0,
  });

  @override
  State<FaceOverlayWidget> createState() => _FaceOverlayWidgetState();
}

class _FaceOverlayWidgetState extends State<FaceOverlayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _borderColor() {
    if (widget.isLivenessActive) {
      return AppColors.primary;
    }
    
    switch (widget.validationStatus) {
      case FaceValidationStatus.valid:
        return AppColors.success;
      case FaceValidationStatus.scanning:
        return AppColors.white.withValues(alpha: 0.6);
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
    return ListenableBuilder(
      listenable: _pulseAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _FaceOverlayPainter(
            borderColor: _borderColor(),
            pulseScale: widget.validationStatus == FaceValidationStatus.scanning && !widget.isLivenessActive
                ? _pulseAnimation.value
                : 1.0,
            captureProgress: widget.captureProgress,
            livenessProgress: widget.livenessProgress,
          ),
        );
      },
    );
  }
}

class _FaceOverlayPainter extends CustomPainter {
  final Color borderColor;
  final double pulseScale;
  final double captureProgress;
  final double livenessProgress;

  _FaceOverlayPainter({
    required this.borderColor,
    required this.pulseScale,
    required this.captureProgress,
    required this.livenessProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.42);
    final ovalWidth =
        size.width * FaceDetectionConstants.guideOvalWidthRatio * pulseScale;
    final ovalHeight =
        ovalWidth * FaceDetectionConstants.guideOvalHeightRatio / FaceDetectionConstants.guideOvalWidthRatio;

    final ovalRect = Rect.fromCenter(
      center: center,
      width: ovalWidth,
      height: ovalHeight,
    );

    // Draw dark overlay with oval cutout
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;

    final overlayPaint = Paint()
      ..color = AppColors.overlayDark
      ..style = PaintingStyle.fill;

    canvas.drawPath(overlayPath, overlayPaint);

    // Draw oval border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawOval(ovalRect, borderPaint);

    // Draw glow effect for valid state
    if (captureProgress > 0) {
      final glowPaint = Paint()
        ..color = borderColor.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      canvas.drawOval(ovalRect, glowPaint);
    }

    // Draw liveness progress arc
    if (livenessProgress > 0) {
      final livenessPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        ovalRect.inflate(6),
        -math.pi / 2,
        2 * math.pi * livenessProgress,
        false,
        livenessPaint,
      );
    }

    // Draw capture progress arc (if capturing)
    if (captureProgress > 0 && captureProgress < 1.0) {
      final progressPaint = Paint()
        ..color = AppColors.success
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        ovalRect.inflate(12), // outside liveness arc
        -math.pi / 2,
        2 * math.pi * captureProgress,
        false,
        progressPaint,
      );
    }

    // Draw corner markers
    _drawCornerMarkers(canvas, ovalRect, borderColor);
  }

  void _drawCornerMarkers(Canvas canvas, Rect ovalRect, Color color) {
    final markerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    const markerLength = 20.0;
    const offset = 4.0;

    // Top-left
    canvas.drawLine(
      Offset(ovalRect.left + offset, ovalRect.top + markerLength),
      Offset(ovalRect.left + offset, ovalRect.top + offset),
      markerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.left + offset, ovalRect.top + offset),
      Offset(ovalRect.left + markerLength, ovalRect.top + offset),
      markerPaint,
    );

    // Top-right
    canvas.drawLine(
      Offset(ovalRect.right - offset, ovalRect.top + markerLength),
      Offset(ovalRect.right - offset, ovalRect.top + offset),
      markerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.right - offset, ovalRect.top + offset),
      Offset(ovalRect.right - markerLength, ovalRect.top + offset),
      markerPaint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(ovalRect.left + offset, ovalRect.bottom - markerLength),
      Offset(ovalRect.left + offset, ovalRect.bottom - offset),
      markerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.left + offset, ovalRect.bottom - offset),
      Offset(ovalRect.left + markerLength, ovalRect.bottom - offset),
      markerPaint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(ovalRect.right - offset, ovalRect.bottom - markerLength),
      Offset(ovalRect.right - offset, ovalRect.bottom - offset),
      markerPaint,
    );
    canvas.drawLine(
      Offset(ovalRect.right - offset, ovalRect.bottom - offset),
      Offset(ovalRect.right - markerLength, ovalRect.bottom - offset),
      markerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FaceOverlayPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.pulseScale != pulseScale ||
        oldDelegate.captureProgress != captureProgress ||
        oldDelegate.livenessProgress != livenessProgress;
  }
}
