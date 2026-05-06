import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as dev;

/// Service for HR authentication API calls.
@lazySingleton
class AuthService {
  final Dio _dio;

  AuthService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'http://10.20.100.121:8800/',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  /// Login HR with employee NIK and password.
  /// Returns the token on success, throws on failure.
  Future<String> login({
    required String employeeNik,
    required String password,
  }) async {
    try {
      dev.log('Attempting login for NIK: $employeeNik', name: 'AuthService');

      final response = await _dio.post(
        'api/login',
        data: {
          'employee_nik': employeeNik,
          'password': password,
        },
      );

      dev.log('Login response: ${response.data}', name: 'AuthService');

      if (response.data != null && response.data['status'] == true) {
        final token = response.data['data']['token'] as String;
        return token;
      }

      throw Exception(
        response.data?['message'] ?? 'Login gagal',
      );
    } on DioException catch (e) {
      dev.log(
        'Login DioException: ${e.message} - ${e.response?.data}',
        error: e,
        name: 'AuthService',
      );

      final message = e.response?.data?['message'] ?? e.message ?? 'Gagal terhubung ke server';
      throw Exception(message);
    } catch (e) {
      dev.log('Login Error: $e', error: e, name: 'AuthService');
      rethrow;
    }
  }
}
