import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages local storage for HR authentication data.
/// Stores token, employee NIK, and password (for face register validation).
@lazySingleton
class AuthLocalStorageService {
  static const String _keyToken = 'auth_token';
  static const String _keyEmployeeNik = 'auth_employee_nik';
  static const String _keyPassword = 'auth_password';
  static const String _keyIsLoggedIn = 'auth_is_logged_in';

  // ── Token ──

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // ── Employee NIK ──

  Future<void> saveEmployeeNik(String nik) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmployeeNik, nik);
  }

  Future<String?> getEmployeeNik() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmployeeNik);
  }

  // ── Password (for face register validation) ──

  Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  // ── Login status ──

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, value);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // ── Save all at once ──

  Future<void> saveLoginData({
    required String token,
    required String employeeNik,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_keyToken, token),
      prefs.setString(_keyEmployeeNik, employeeNik),
      prefs.setString(_keyPassword, password),
      prefs.setBool(_keyIsLoggedIn, true),
    ]);
  }

  // ── Clear all ──

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_keyToken),
      prefs.remove(_keyEmployeeNik),
      prefs.remove(_keyPassword),
      prefs.setBool(_keyIsLoggedIn, false),
    ]);
  }
}
