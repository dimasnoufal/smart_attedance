import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_attedance/core/services/auth_local_storage_service.dart';
import 'dart:developer' as dev;

/// Response model for attendance API.
class AttendanceResult {
  final bool success;
  final String? time;
  final String? message;

  const AttendanceResult({required this.success, this.time, this.message});
}

/// Service for submitting attendance via API.
@lazySingleton
class AttendanceService {
  final Dio _dio;
  final AuthLocalStorageService _authStorage;

  AttendanceService(this._authStorage)
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'http://10.20.100.121:8800/',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  /// Submit attendance for a recognized employee.
  Future<AttendanceResult> submitAttendance({
    required String employeeNik,
    required String latitude,
    required String longitude,
    required String addressDetail,
  }) async {
    try {
      // Get stored bearer token
      final token = await _authStorage.getToken();

      if (token == null || token.isEmpty) {
        return const AttendanceResult(
          success: false,
          message: 'Token tidak ditemukan. Silakan login ulang.',
        );
      }

      dev.log(
        'Submitting attendance for NIK: $employeeNik, Latitude: $latitude, Longitude: $longitude, Address Detail: $addressDetail, Token: $token ',
        name: 'AttendanceService',
      );

      final response = await _dio.post(
        'api/attendance',
        data: {
          'employee_nik': employeeNik,
          'latitude': latitude,
          'longitude': longitude,
          'address_detail': addressDetail,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      dev.log(
        'Attendance response: ${response.data}',
        name: 'AttendanceService',
      );

      if (response.data != null && response.data['status'] == true) {
        final time = response.data['data']?['time'] as String?;
        return AttendanceResult(success: true, time: time);
      }

      return AttendanceResult(
        success: false,
        message: response.data?['message'] ?? 'Gagal mengirim absensi',
      );
    } on DioException catch (e) {
      dev.log(
        'Attendance DioException: ${e.message} - ${e.response?.data}',
        error: e,
        name: 'AttendanceService',
      );

      final message =
          e.response?.data?['message'] ??
          e.message ??
          'Gagal terhubung ke server';
      return AttendanceResult(success: false, message: message);
    } catch (e) {
      dev.log('Attendance Error: $e', error: e, name: 'AttendanceService');
      return AttendanceResult(success: false, message: 'Terjadi kesalahan: $e');
    }
  }
}
