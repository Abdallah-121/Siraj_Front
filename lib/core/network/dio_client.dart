// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import 'api_constants.dart';

class DioClient {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;

  DioClient(this.authLocalDataSource)
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = await authLocalDataSource.getToken();

          if (token != null && token.trim().isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('=== DIO REQUEST ===');
          print('Method: ${options.method}');
          print('URI: ${options.uri}');
          print('Headers: ${options.headers}');
          print('Query: ${options.queryParameters}');
          print('Data: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('=== DIO RESPONSE ===');
          print('Status code: ${response.statusCode}');
          print('URI: ${response.requestOptions.uri}');
          print('Data: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('=== DIO ERROR ===');
          print('Type: ${error.type}');
          print('Message: ${error.message}');
          print('URI: ${error.requestOptions.uri}');
          print('Response code: ${error.response?.statusCode}');
          print('Response data: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
  }
}
