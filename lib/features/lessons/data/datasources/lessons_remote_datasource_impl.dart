import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:seraj/features/lessons/data/datasources/lessons_remote_datasource.dart';
import 'package:seraj/features/lessons/data/model/create_lesson_request_model.dart';
import 'package:seraj/features/lessons/data/model/lesson_detail_model.dart';
import 'package:seraj/features/lessons/data/model/lesson_model.dart';
import 'package:seraj/features/lessons/data/model/lessons_page_model.dart';
import 'package:seraj/features/lessons/data/model/registered_lessons_page_model.dart';
import 'package:seraj/features/lessons/data/model/user_lesson_model.dart';
import 'package:seraj/features/lessons/data/model/user_lessons_page_model.dart';
import 'package:seraj/features/lessons/domain/usecases/get_my_registered_lessons_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/usecases/get_lessons_usecase.dart';

class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final DioClient dioClient;

  LessonsRemoteDataSourceImpl(this.dioClient);

  @override
  Future<LessonsPageModel> getLessons(GetLessonsParams params) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.lessons,
        queryParameters: {
          'PageNumber': params.pageNumber,
          'PageSize': params.pageSize,
          if (params.search != null && params.search!.trim().isNotEmpty)
            'Search': params.search,
          if (params.mosqueId != null) 'MosqueId': params.mosqueId,
          if (params.categoryId != null) 'CategoryId': params.categoryId,
          if (params.teacherId != null) 'TeacherId': params.teacherId,
          if (params.isActive != null) 'IsActive': params.isActive,
          if (params.status != null) 'Status': params.status,
        },
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Lessons failed',
          statusCode: response.statusCode,
        );
      }

      final data = responseMap['data'] as Map<String, dynamic>;
      return LessonsPageModel.fromJson(data);
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Lessons request failed');
    } catch (e, s) {
      debugPrint('LESSONS PARSE ERROR: $e');
      debugPrint('$s');
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<LessonModel> createLesson(CreateLessonRequestModel request) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.lessons,
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Create lesson failed',
          statusCode: response.statusCode,
        );
      }

      final data = responseMap['data'] as Map<String, dynamic>;
      return LessonModel.fromJson(data);
    } on DioException catch (e) {
      _throwMappedDioException(
        e,
        fallbackMessage: 'Create lesson request failed',
      );
    } catch (e, s) {
      debugPrint('CREATE LESSON ERROR: $e');
      debugPrint('$s');
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<LessonDetailModel> getLessonDetail(int lessonId) async {
    try {
      final response = await dioClient.dio.get(
        '${ApiConstants.lessons}/$lessonId/details',
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message:
              responseMap['message'] as String? ?? 'Get lesson detail failed',
          statusCode: response.statusCode,
        );
      }

      return LessonDetailModel.fromJson(responseMap);
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Get lesson detail failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<LessonModel> publishLesson(int lessonId) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.publishLesson(lessonId),
      );

      return _parseLessonActionResponse(
        response,
        fallbackMessage: 'Publish lesson failed',
      );
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Publish lesson failed');
    } catch (e, s) {
      debugPrint('PUBLISH LESSON ERROR: $e');
      debugPrint('$s');
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<LessonModel> unpublishLesson(int lessonId) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.unpublishLesson(lessonId),
      );

      return _parseLessonActionResponse(
        response,
        fallbackMessage: 'Unpublish lesson failed',
      );
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Unpublish lesson failed');
    } catch (e, s) {
      debugPrint('UNPUBLISH LESSON ERROR: $e');
      debugPrint('$s');
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  LessonModel _parseLessonActionResponse(
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

    final data = responseMap['data'] as Map<String, dynamic>;
    return LessonModel.fromJson(data);
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
        ? (responseData['message'] as String? ?? fallbackMessage)
        : fallbackMessage;

    throw ServerException(
      message: serverMessage,
      statusCode: e.response?.statusCode,
    );
  }

  @override
  Future<UserLessonModel> attendLesson(int lessonId) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.attendLesson(lessonId),
      );

      return _parseUserLessonActionResponse(
        response,
        fallbackMessage: 'Attend lesson failed',
      );
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Attend lesson failed');
    } catch (e, s) {
      debugPrint('ATTEND LESSON ERROR: $e');
      debugPrint('$s');
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<UserLessonModel> completeLesson(int lessonId) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.completeLesson(lessonId),
      );

      return _parseUserLessonActionResponse(
        response,
        fallbackMessage: 'Complete lesson failed',
      );
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Complete lesson failed');
    } catch (e, s) {
      debugPrint('COMPLETE LESSON ERROR: $e');
      debugPrint('$s');
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  @override
  Future<RegisteredLessonsPageModel> getMyRegisteredLessons(
    GetMyRegisteredLessonsParams params,
  ) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.myRegisteredLessons,
        queryParameters: {
          if (params.status != null) 'Status': params.status,
          'PageNumber': params.pageNumber,
          'PageSize': params.pageSize,
        },
      );

      final responseMap = response.data as Map<String, dynamic>;
      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message:
              responseMap['message'] as String? ?? 'Registered lessons failed',
          statusCode: response.statusCode,
        );
      }

      final data = responseMap['data'] as Map<String, dynamic>;
      return RegisteredLessonsPageModel.fromJson(data);
    } on DioException catch (e) {
      _throwMappedDioException(
        e,
        fallbackMessage: 'Registered lessons request failed',
      );
    } catch (e, s) {
      debugPrint('REGISTERED LESSONS ERROR: $e');
      debugPrint('$s');
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  UserLessonModel _parseUserLessonActionResponse(
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

    final data = responseMap['data'] as Map<String, dynamic>;
    return UserLessonModel.fromJson(data);
  }
}
