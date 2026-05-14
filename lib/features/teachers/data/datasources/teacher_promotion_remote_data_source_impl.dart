import 'package:dio/dio.dart';
import 'package:seraj/features/teachers/data/model/create_teacher_request_model.dart';
import 'package:seraj/features/teachers/data/model/mosque_teacher_model.dart';
import 'package:seraj/features/teachers/data/model/promote_user_request_model.dart';
import 'package:seraj/features/teachers/data/model/promotion_user_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import 'teacher_promotion_remote_data_source.dart';

class TeacherPromotionRemoteDataSourceImpl
    implements TeacherPromotionRemoteDataSource {
  final DioClient dioClient;

  const TeacherPromotionRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<PromotionUserModel>> searchUsersForPromotion({
    required String search,
    required int maxResults,
  }) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.searchUsersForPromotion,
        queryParameters: {'search': search, 'maxResults': maxResults},
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Search users failed',
          statusCode: response.statusCode,
        );
      }

      final List<dynamic> data = responseMap['data'] as List<dynamic>? ?? [];

      return data
          .whereType<Map<String, dynamic>>()
          .map(PromotionUserModel.fromJson)
          .toList(growable: false);
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Search users failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<void> promoteUserToTeacher(PromoteUserRequestModel request) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.promoteUserToTeacher,
        data: request.toJson(),
      );

      _ensureSuccess(response, fallbackMessage: 'Promote user failed');
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Promote user failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<void> createTeacher(CreateTeacherRequestModel request) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.teachers,
        data: request.toJson(),
      );

      _ensureSuccess(response, fallbackMessage: 'Create teacher failed');
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Create teacher failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  void _ensureSuccess(
    Response<dynamic> response, {
    required String fallbackMessage,
  }) {
    final responseMap = response.data as Map<String, dynamic>;
    final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

    if (!isSuccess) {
      throw ServerException(
        message: responseMap['message'] as String? ?? fallbackMessage,
        statusCode: response.statusCode,
      );
    }
  }

  Never _throwMappedDioException(
    DioException e, {
    required String fallbackMessage,
  }) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw NetworkException(message: 'No internet connection');
    }

    final responseData = e.response?.data;

    final String serverMessage = responseData is Map<String, dynamic>
        ? responseData['message'] as String? ?? fallbackMessage
        : fallbackMessage;

    throw ServerException(
      message: serverMessage,
      statusCode: e.response?.statusCode,
    );
  }

  @override
  Future<List<MosqueTeacherModel>> getTeachersByMosque({
    required int mosqueId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.teachersByMosque(mosqueId),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message:
              responseMap['message'] as String? ?? 'Get mosque teachers failed',
          statusCode: response.statusCode,
        );
      }

      final List<dynamic> data = responseMap['data'] as List<dynamic>? ?? [];

      return data
          .whereType<Map<String, dynamic>>()
          .map(MosqueTeacherModel.fromJson)
          .toList(growable: false);
    } on DioException catch (e) {
      _throwMappedDioException(
        e,
        fallbackMessage: 'Get mosque teachers failed',
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }
}
