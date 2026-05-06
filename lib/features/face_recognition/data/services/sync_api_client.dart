import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as dev;

@lazySingleton
class SyncApiClient {
  final Dio _dio;

  SyncApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://recognition.hastaprimasolusi.com/v1/',
          headers: {'X-Device-Key': 'dev-key'},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    // TEMPORARY BYPASS FOR EXPIRED SSL CERTIFICATE
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }

  /// Fetches embeddings from the API starting from a specific version.
  Future<Map<String, dynamic>> fetchEmbeddings({
    required int version,
    int limit = 500,
  }) async {
    try {
      final response = await _dio.get(
        'faces/sync',
        queryParameters: {'version': version, 'limit': limit},
      );

      dev.log('Response fetching face embeddings: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      } else {
        dev.log(
          'Failed to fetch embeddings: ${response.statusCode} - ${response.data}',
        );
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to fetch embeddings: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
