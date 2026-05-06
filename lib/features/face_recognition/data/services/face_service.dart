import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as dev;

@lazySingleton
class FaceService {
  final Dio _dio;

  FaceService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://recognition.hastaprimasolusi.com/v1/',
          headers: {'X-Device-Key': 'dev-key'},
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      ) {
    // TEMPORARY BYPASS FOR EXPIRED SSL CERTIFICATE
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }

  /// Registers a face to the server.
  ///
  /// Takes a [userId] and raw [imageBytes] (usually JPEG from the camera).
  /// Returns [true] if the registration is successful.
  Future<bool> registerFace({
    required String userId,
    required String name,
    required Uint8List imageBytes,
  }) async {
    try {
      dev.log(
        'Starting face registration for user: $userId',
        name: 'FaceService',
      );

      final formData = FormData.fromMap({
        'user_id': userId,
        'name': name,
        'image': MultipartFile.fromBytes(
          imageBytes,
          filename: 'face_register_$userId.jpg',
          // Optionally set content-type if the backend requires it:
          // contentType: DioMediaType('image', 'jpeg'),
        ),
      });

      final response = await _dio.post('faces/register', data: formData);

      dev.log('Registration response: ${response.data}', name: 'FaceService');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data != null && data['status'] == 'success') {
          return true;
        }
      }

      return false;
    } on DioException catch (e) {
      dev.log(
        'Registration DioException: ${e.message} - ${e.response?.data}',
        error: e,
        name: 'FaceService',
      );
      throw Exception(
        e.response?.data['message'] ?? e.message ?? 'Unknown error occurred',
      );
    } catch (e) {
      dev.log('Registration Error: $e', error: e, name: 'FaceService');
      throw Exception('Failed to register face: $e');
    }
  }
}
