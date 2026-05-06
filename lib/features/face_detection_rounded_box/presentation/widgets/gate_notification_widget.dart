import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_attedance/core/constants/app_colors.dart';

/// Type of notification to display.
enum NotificationType { success, error, warning, info }

/// A premium, non-spamming notification overlay for the Gate Detection page.
///
/// Design decisions:
/// - Uses OverlayEntry instead of SnackBar for full control over animation and stacking.
/// - Anti-spam: only ONE notification at a time. New ones are queued if one is showing.
/// - Success stays visible for 5 seconds; errors for 3 seconds.
/// - Slide + fade animation for smooth entry/exit.
class GateNotificationManager {
  OverlayEntry? _currentEntry;
  Timer? _dismissTimer;
  bool _isShowing = false;

  /// Whether a notification is currently visible.
  bool get isShowing => _isShowing;

  /// Shows a notification. If one is already visible, it is dismissed first.
  /// For errors: skips if an error notification is already showing (anti-spam).
  void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    required NotificationType type,
    String? userId,
  }) {
    if (!context.mounted) return;

    // Anti-spam: if an error is already showing and we get another error, skip
    if (_isShowing && type == NotificationType.error) return;

    // Dismiss current notification if present
    _dismiss();

    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) => _GateNotificationWidget(
        title: title,
        subtitle: subtitle,
        type: type,
        userId: userId,
        onDismiss: _dismiss,
      ),
    );

    overlay.insert(_currentEntry!);
    _isShowing = true;

    // Auto-dismiss after duration
    final duration = type == NotificationType.success
        ? const Duration(seconds: 5)
        : const Duration(seconds: 3);

    _dismissTimer = Timer(duration, _dismiss);
  }

  void _dismiss() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _currentEntry?.remove();
    _currentEntry = null;
    _isShowing = false;
  }

  /// Call this when the page is disposed to clean up.
  void dispose() {
    _dismiss();
  }
}

class _GateNotificationWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final NotificationType type;
  final String? userId;
  final VoidCallback onDismiss;

  const _GateNotificationWidget({
    required this.title,
    this.subtitle,
    required this.type,
    this.userId,
    required this.onDismiss,
  });

  @override
  State<_GateNotificationWidget> createState() =>
      _GateNotificationWidgetState();
}

class _GateNotificationWidgetState extends State<_GateNotificationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _getConfig();
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 8,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: widget.onDismiss,
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null &&
                    details.primaryVelocity! < -200) {
                  widget.onDismiss();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: config.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: config.borderColor,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: config.shadowColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Icon circle
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: config.iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        config.icon,
                        color: config.iconColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: config.titleColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                          if (widget.subtitle != null) ...[
                            const SizedBox(height: 3),
                            Text(
                              widget.subtitle!,
                              style: TextStyle(
                                color: config.subtitleColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                          if (widget.userId != null) ...[
                            const SizedBox(height: 3),
                            Text(
                              widget.userId!,
                              style: TextStyle(
                                color: config.accentColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Status badge
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: config.badgeBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        config.badgeIcon,
                        color: config.badgeIconColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _NotificationConfig _getConfig() {
    switch (widget.type) {
      case NotificationType.success:
        return _NotificationConfig(
          backgroundColor: AppColors.white,
          borderColor: AppColors.success.withValues(alpha: 0.4),
          shadowColor: AppColors.success,
          iconBgColor: AppColors.success.withValues(alpha: 0.1),
          iconColor: AppColors.success,
          icon: Icons.person_rounded,
          titleColor: AppColors.grey900,
          subtitleColor: AppColors.grey400,
          accentColor: AppColors.success,
          badgeBgColor: AppColors.success.withValues(alpha: 0.12),
          badgeIcon: Icons.check_circle_rounded,
          badgeIconColor: AppColors.success,
        );
      case NotificationType.error:
        return _NotificationConfig(
          backgroundColor: AppColors.white,
          borderColor: AppColors.error.withValues(alpha: 0.3),
          shadowColor: AppColors.error,
          iconBgColor: AppColors.error.withValues(alpha: 0.1),
          iconColor: AppColors.error,
          icon: Icons.person_off_rounded,
          titleColor: AppColors.grey900,
          subtitleColor: AppColors.grey400,
          accentColor: AppColors.error,
          badgeBgColor: AppColors.error.withValues(alpha: 0.12),
          badgeIcon: Icons.cancel_rounded,
          badgeIconColor: AppColors.error,
        );
      case NotificationType.warning:
        return _NotificationConfig(
          backgroundColor: AppColors.white,
          borderColor: AppColors.warning.withValues(alpha: 0.3),
          shadowColor: AppColors.warning,
          iconBgColor: AppColors.warning.withValues(alpha: 0.1),
          iconColor: AppColors.warning,
          icon: Icons.warning_amber_rounded,
          titleColor: AppColors.grey900,
          subtitleColor: AppColors.grey400,
          accentColor: AppColors.warning,
          badgeBgColor: AppColors.warning.withValues(alpha: 0.12),
          badgeIcon: Icons.error_rounded,
          badgeIconColor: AppColors.warning,
        );
      case NotificationType.info:
        return _NotificationConfig(
          backgroundColor: AppColors.white,
          borderColor: AppColors.primary.withValues(alpha: 0.3),
          shadowColor: AppColors.primary,
          iconBgColor: AppColors.primary.withValues(alpha: 0.1),
          iconColor: AppColors.primary,
          icon: Icons.info_outline_rounded,
          titleColor: AppColors.grey900,
          subtitleColor: AppColors.grey400,
          accentColor: AppColors.primary,
          badgeBgColor: AppColors.primary.withValues(alpha: 0.12),
          badgeIcon: Icons.info_rounded,
          badgeIconColor: AppColors.primary,
        );
    }
  }
}

/// Internal config for notification appearance.
class _NotificationConfig {
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final Color iconBgColor;
  final Color iconColor;
  final IconData icon;
  final Color titleColor;
  final Color subtitleColor;
  final Color accentColor;
  final Color badgeBgColor;
  final IconData badgeIcon;
  final Color badgeIconColor;

  const _NotificationConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    required this.iconBgColor,
    required this.iconColor,
    required this.icon,
    required this.titleColor,
    required this.subtitleColor,
    required this.accentColor,
    required this.badgeBgColor,
    required this.badgeIcon,
    required this.badgeIconColor,
  });
}
