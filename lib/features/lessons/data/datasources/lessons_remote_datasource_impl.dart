import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:seraj/features/lessons/data/datasources/lessons_remote_datasource.dart';
import 'package:seraj/features/lessons/data/model/create_lesson_request_model.dart';
import 'package:seraj/features/lessons/data/model/lesson_detail_model.dart';
import 'package:seraj/features/lessons/data/model/lesson_model.dart';
import 'package:seraj/features/lessons/data/model/lessons_page_model.dart';

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

      debugPrint('LESSONS RESPONSE: ${response.data}');

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
      throw ServerException(
        message: e.message ?? 'Lessons request failed',
        statusCode: e.response?.statusCode,
      );
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
      throw ServerException(
        message: e.message ?? 'Create lesson request failed',
        statusCode: e.response?.statusCode,
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
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final responseData = e.response?.data;
      final serverMessage = responseData is Map<String, dynamic>
          ? (responseData['message'] as String? ?? 'Get lesson detail failed')
          : 'Get lesson detail failed';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }
}
