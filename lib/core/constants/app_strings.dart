/// Centralized UI strings — i18n-ready.
/// All user-facing text resides here for easy localization.
class AppStrings {
  AppStrings._();

  // ── Face Detection Status ──
  static const String scanning = 'Memindai wajah...';
  static const String faceDetected = 'Wajah terdeteksi';
  static const String noFaceDetected = 'Tidak ada wajah terdeteksi';
  static const String multipleFaces = 'Pastikan hanya 1 wajah';
  static const String tooFar = 'Terlalu jauh, dekatkan wajah';
  static const String tooClose = 'Terlalu dekat, jauhkan wajah';
  static const String notCentered = 'Posisikan wajah di tengah';
  static const String processing = 'Memproses...';
  static const String captureSuccess = 'Foto berhasil diambil';

  // ── Liveness Instructions ──
  static const String livenessSmile = 'Silakan Tersenyum';
  static const String livenessTurnRight = 'Tengok ke Kanan';
  static const String livenessTurnLeft = 'Tengok ke Kiri';
  static const String livenessLookStraight = 'Kembali ke Tengah & Muka Datar';
  static const String livenessComplete = 'Verifikasi Berhasil';

  // ── Camera ──
  static const String cameraInitializing = 'Memulai kamera...';
  static const String cameraError = 'Gagal mengakses kamera';
  static const String cameraPermissionDenied =
      'Izin kamera diperlukan untuk absensi';

  // ── General ──
  static const String appName = 'Smart Attendance';
  static const String faceDetectionTitle = 'Verifikasi Wajah';
  static const String retry = 'Coba Lagi';
}
