import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smart_attedance/core/constants/app_colors.dart';
import 'package:smart_attedance/features/face_detection/domain/entities/face_bounds.dart';

/// A dynamic face-tracking overlay that draws a rounded box following
/// the detected face position in real-time with EMA smoothing.
///
/// Uses a 60fps Ticker to interpolate the bounding box position,
/// producing smooth movement even when the Bloc emits at 3-5 fps.
class FaceTrackingOverlayWidget extends StatefulWidget {
  /// The bounding box of the tracked face (in ML Kit camera coordinates).
  final FaceBounds? faceBounds;

  /// The camera image size (ML Kit coordinate space).
  final Size? imageSize;

  /// Color of the tracking box border.
  final Color borderColor;

  const FaceTrackingOverlayWidget({
    super.key,
    this.faceBounds,
    this.imageSize,
    this.borderColor = AppColors.white,
  });

  @override
  State<FaceTrackingOverlayWidget> createState() =>
      _FaceTrackingOverlayWidgetState();
}

class _FaceTrackingOverlayWidgetState extends State<FaceTrackingOverlayWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  /// EMA alpha — higher = more responsive, lower = smoother.
  /// 0.35 is a good balance for face tracking at ~5 detections/sec.
  static const double _emaAlpha = 0.35;

  /// How long to wait (ms) after losing face before snapping to guide box.
  static const int _faceLostTimeoutMs = 500;

  /// Current smoothed rect (in screen coordinates).
  Rect? _smoothedRect;

  /// The latest target rect from the Bloc (pre-smoothing).
  Rect? _targetRect;

  /// Time when the face was last seen.
  DateTime? _lastFaceSeenAt;

  /// Cached screen size from LayoutBuilder.
  Size _screenSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FaceTrackingOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // When the Bloc emits new face data, update the target
    if (widget.faceBounds != oldWidget.faceBounds ||
        widget.imageSize != oldWidget.imageSize) {
      _updateTarget();
    }
  }

  void _updateTarget() {
    if (widget.faceBounds != null &&
        widget.imageSize != null &&
        _screenSize != Size.zero) {
      _targetRect = _transformToScreenSpace(
        widget.faceBounds!,
        widget.imageSize!,
        _screenSize,
      );
      _lastFaceSeenAt = DateTime.now();
    } else {
      // Face lost — keep target as null, will lerp to guide after timeout
      _targetRect = null;
    }
  }

  void _onTick(Duration elapsed) {
    // Determine what we should be moving toward
    Rect targetForFrame;

    if (_targetRect != null) {
      targetForFrame = _targetRect!;
    } else {
      // No face — check timeout
      final elapsed = _lastFaceSeenAt != null
          ? DateTime.now().difference(_lastFaceSeenAt!).inMilliseconds
          : _faceLostTimeoutMs + 1;

      if (elapsed > _faceLostTimeoutMs) {
        // Snap toward the guide box
        targetForFrame = _getGuideRect(_screenSize);
      } else {
        // Still within timeout — keep current position
        if (_smoothedRect != null) {
          return; // Don't update, keep at last known position
        }
        targetForFrame = _getGuideRect(_screenSize);
      }
    }

    if (_smoothedRect == null) {
      // First frame — snap directly
      _smoothedRect = targetForFrame;
    } else {
      // EMA smoothing on each edge
      _smoothedRect = Rect.fromLTRB(
        _ema(_smoothedRect!.left, targetForFrame.left),
        _ema(_smoothedRect!.top, targetForFrame.top),
        _ema(_smoothedRect!.right, targetForFrame.right),
        _ema(_smoothedRect!.bottom, targetForFrame.bottom),
      );
    }

    // Only rebuild if we actually need to (avoid unnecessary paints)
    if (mounted) {
      setState(() {});
    }
  }

  double _ema(double current, double target) {
    return current + _emaAlpha * (target - current);
  }

  Rect _getGuideRect(Size screenSize) {
    if (screenSize == Size.zero) return Rect.zero;
    final double boxWidth = screenSize.width * 0.65;
    final double boxHeight = boxWidth * 1.25;
    return Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height * 0.40),
      width: boxWidth,
      height: boxHeight,
    );
  }

  /// Transforms ML Kit face coordinates to screen widget coordinates.
  Rect _transformToScreenSpace(
    FaceBounds face,
    Size camSize,
    Size screenSize,
  ) {
    // Camera image is typically rotated 90° on mobile.
    // CameraPreviewWidget swaps width/height.
    final double camW = camSize.height;
    final double camH = camSize.width;

    // FittedBox.cover scaling
    final double scaleX = screenSize.width / camW;
    final double scaleY = screenSize.height / camH;
    final double scale = math.max(scaleX, scaleY);

    final double scaledW = camW * scale;
    final double scaledH = camH * scale;
    final double offsetX = (screenSize.width - scaledW) / 2;
    final double offsetY = (screenSize.height - scaledH) / 2;

    // Mirror horizontally for front camera
    final double mirroredLeft = camW - face.left - face.width;

    final double left = mirroredLeft * scale + offsetX;
    final double top = face.top * scale + offsetY;
    final double width = face.width * scale;
    final double height = face.height * scale;

    // Add padding around the face (20%)
    const double padding = 0.20;
    final double padW = width * padding;
    final double padH = height * padding;

    return Rect.fromLTWH(
      left - padW,
      top - padH,
      width + padW * 2,
      height + padH * 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final newSize = Size(constraints.maxWidth, constraints.maxHeight);
        if (newSize != _screenSize) {
          _screenSize = newSize;
          _updateTarget(); // Recalculate target with new screen size
        }

        return CustomPaint(
          size: Size.infinite,
          painter: _FaceTrackingPainter(
            faceRect: _smoothedRect,
            borderColor: widget.borderColor,
            screenSize: _screenSize,
          ),
        );
      },
    );
  }
}

class _FaceTrackingPainter extends CustomPainter {
  final Rect? faceRect;
  final Color borderColor;
  final Size screenSize;

  _FaceTrackingPainter({
    required this.faceRect,
    required this.borderColor,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect targetRect;
    if (faceRect != null && faceRect != Rect.zero) {
      targetRect = faceRect!;
    } else {
      // Fallback guide box
      final double boxWidth = size.width * 0.65;
      final double boxHeight = boxWidth * 1.25;
      targetRect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.40),
        width: boxWidth,
        height: boxHeight,
      );
    }

    const double radius = 20.0;

    // Dimmed background with cutout
    final Paint bgPaint = Paint()
      ..color = AppColors.black.withValues(alpha: 0.5);
    final Path bgPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
          RRect.fromRectAndRadius(targetRect, const Radius.circular(radius)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(bgPath, bgPaint);

    // Corner brackets
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final double cornerLength = targetRect.width * 0.15;
    const double r = radius;

    // Top-Left
    canvas.drawPath(
      Path()
        ..moveTo(targetRect.left, targetRect.top + cornerLength)
        ..quadraticBezierTo(
          targetRect.left,
          targetRect.top,
          targetRect.left + r,
          targetRect.top,
        )
        ..lineTo(targetRect.left + cornerLength, targetRect.top),
      borderPaint,
    );

    // Top-Right
    canvas.drawPath(
      Path()
        ..moveTo(targetRect.right - cornerLength, targetRect.top)
        ..lineTo(targetRect.right - r, targetRect.top)
        ..quadraticBezierTo(
          targetRect.right,
          targetRect.top,
          targetRect.right,
          targetRect.top + r,
        )
        ..lineTo(targetRect.right, targetRect.top + cornerLength),
      borderPaint,
    );

    // Bottom-Left
    canvas.drawPath(
      Path()
        ..moveTo(targetRect.left, targetRect.bottom - cornerLength)
        ..lineTo(targetRect.left, targetRect.bottom - r)
        ..quadraticBezierTo(
          targetRect.left,
          targetRect.bottom,
          targetRect.left + r,
          targetRect.bottom,
        )
        ..lineTo(targetRect.left + cornerLength, targetRect.bottom),
      borderPaint,
    );

    // Bottom-Right
    canvas.drawPath(
      Path()
        ..moveTo(targetRect.right - cornerLength, targetRect.bottom)
        ..lineTo(targetRect.right - r, targetRect.bottom)
        ..quadraticBezierTo(
          targetRect.right,
          targetRect.bottom,
          targetRect.right,
          targetRect.bottom - r,
        )
        ..lineTo(targetRect.right, targetRect.bottom - cornerLength),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FaceTrackingPainter oldDelegate) =>
      oldDelegate.faceRect != faceRect ||
      oldDelegate.borderColor != borderColor;
}
