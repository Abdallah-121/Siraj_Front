import 'package:dio/dio.dart';
import 'package:seraj/features/auth/data/models/change_password_request_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_session_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AuthSessionModel> login(LoginRequestModel request) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }

      final value = responseMap['value'] as Map<String, dynamic>;
      return AuthSessionModel.fromJson(value);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final responseData = e.response?.data;
      final serverMessage = responseData is Map<String, dynamic>
          ? (responseData['message'] as String? ?? 'Login failed')
          : 'Login failed';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<AuthSessionModel> register(RegisterRequestModel request) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.register,
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Register failed',
          statusCode: response.statusCode,
        );
      }

      final value = responseMap['value'] as Map<String, dynamic>;
      return AuthSessionModel.fromJson(value);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final responseData = e.response?.data;
      final serverMessage = responseData is Map<String, dynamic>
          ? (responseData['message'] as String? ?? 'Register failed')
          : 'Register failed';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<void> changePassword(ChangePasswordRequestModel request) async {
    try {
      final response = await dioClient.dio.put(
        ApiConstants.changePassword,
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;

      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;
      final String message =
          responseMap['message'] as String? ?? 'Change password failed';

      if (!isSuccess) {
        throw ServerException(
          message: message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final responseData = e.response?.data;

      final String serverMessage = responseData is Map<String, dynamic>
          ? responseData['message'] as String? ?? 'Change password failed'
          : 'Change password failed';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }
}
