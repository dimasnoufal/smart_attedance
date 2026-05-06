import 'dart:ui';

/// Application-wide color palette.
/// Designed for a modern, clean attendance app aesthetic.
class AppColors {
  AppColors._();

  // ── Primary Brand ──
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1D4ED8);

  // ── Semantic ──
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);

  // ── Overlay ──
  static const Color overlayDark = Color(0xCC000000); // 80% black
  static const Color overlayLight = Color(0x33000000); // 20% black

  // ── Neutral ──
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey900 = Color(0xFF111827);
}
