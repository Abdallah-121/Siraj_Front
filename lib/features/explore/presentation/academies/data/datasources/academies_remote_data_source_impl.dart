import 'dart:io';

import 'package:dio/dio.dart';
import 'package:seraj/core/error/exceptions.dart';
import 'package:seraj/core/network/api_constants.dart';
import 'package:seraj/core/network/dio_client.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';

import '../models/academies_page_model.dart';
import '../models/academy_model.dart';
import '../models/create_update_academy_request_model.dart';
import '../models/upload_academy_image_response_model.dart';
import 'academies_remote_data_source.dart';

class AcademiesRemoteDataSourceImpl implements AcademiesRemoteDataSource {
  final DioClient dioClient;

  AcademiesRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AcademiesPageModel> getAcademies(GetAcademiesParams params) async {
    return _getPagedAcademies(
      path: ApiConstants.academies,
      queryParameters: {
        'PageNumber': params.pageNumber,
        'PageSize': params.pageSize,
        if (params.search != null && params.search!.trim().isNotEmpty)
          'Search': params.search,
        if (params.sortBy != null && params.sortBy!.trim().isNotEmpty)
          'SortBy': params.sortBy,
        if (params.descending != null) 'Descending': params.descending,
      },
      fallbackMessage: 'Get academies failed',
    );
  }

  @override
  Future<AcademyModel> getAcademyById(int academyId) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.academyById(academyId),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Get academy failed',
          statusCode: response.statusCode,
        );
      }

      return AcademyModel.fromJson(responseMap['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      _handleDioException(e, 'Get academy failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<AcademiesPageModel> getAcademiesByLocation({
    int? regionId,
    int? cityId,
    int? excludeRegionId,
    bool? isActive,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    return _getPagedAcademies(
      path: ApiConstants.academiesByLocation,
      queryParameters: {
        if (regionId != null) 'RegionId': regionId,
        if (cityId != null) 'CityId': cityId,
        if (excludeRegionId != null) 'ExcludeRegionId': excludeRegionId,
        if (isActive != null) 'IsActive': isActive,
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      },
      fallbackMessage: 'Get academies by location failed',
    );
  }

  @override
  Future<AcademyModel> createAcademy(
    CreateUpdateAcademyRequestModel request,
  ) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.academies,
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Create academy failed',
          statusCode: response.statusCode,
        );
      }

      return AcademyModel.fromJson(responseMap['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      _handleDioException(e, 'Create academy failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<AcademyModel> updateAcademy({
    required int academyId,
    required CreateUpdateAcademyRequestModel request,
  }) async {
    try {
      final response = await dioClient.dio.put(
        ApiConstants.academyById(academyId),
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Update academy failed',
          statusCode: response.statusCode,
        );
      }

      return AcademyModel.fromJson(responseMap['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      _handleDioException(e, 'Update academy failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<void> deleteAcademy(int academyId) async {
    try {
      final response = await dioClient.dio.delete(
        ApiConstants.academyById(academyId),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? 'Delete academy failed',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioException(e, 'Delete academy failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<UploadAcademyImageResponseModel> uploadAcademyImage({
    required int academyId,
    required File image,
  }) async {
    try {
      final fileName = image.path.split('/').last;

      final formData = FormData.fromMap({
        'File': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await dioClient.dio.post(
        ApiConstants.academyImage(academyId),
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final responseMap = response.data as Map<String, dynamic>;
      final isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message:
              responseMap['message'] as String? ??
              'Upload academy image failed',
          statusCode: response.statusCode,
        );
      }

      return UploadAcademyImageResponseModel.fromJson(
        responseMap['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      _handleDioException(e, 'Upload academy image failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<void> addFavoriteAcademy(int academyId) async {
    await _favoriteRequest(
      academyId: academyId,
      method: 'POST',
      fallbackMessage: 'Add academy favorite failed',
    );
  }

  @override
  Future<void> removeFavoriteAcademy(int academyId) async {
    await _favoriteRequest(
      academyId: academyId,
      method: 'DELETE',
      fallbackMessage: 'Remove academy favorite failed',
    );
  }

  @override
  Future<AcademiesPageModel> getFavoriteAcademies({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    return _getPagedAcademies(
      path: ApiConstants.favoriteAcademies,
      queryParameters: {'PageNumber': pageNumber, 'PageSize': pageSize},
      fallbackMessage: 'Get favorite academies failed',
    );
  }

  Future<AcademiesPageModel> _getPagedAcademies({
    required String path,
    required Map<String, dynamic> queryParameters,
    required String fallbackMessage,
  }) async {
    try {
      final response = await dioClient.dio.get(
        path,
        queryParameters: queryParameters,
      );

      final responseMap = response.data as Map<String, dynamic>;
      final isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? fallbackMessage,
          statusCode: response.statusCode,
        );
      }

      return AcademiesPageModel.fromJson(
        responseMap['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      _handleDioException(e, fallbackMessage);
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  Future<void> _favoriteRequest({
    required int academyId,
    required String method,
    required String fallbackMessage,
  }) async {
    try {
      final response = method == 'POST'
          ? await dioClient.dio.post(ApiConstants.favoriteAcademy(academyId))
          : await dioClient.dio.delete(ApiConstants.favoriteAcademy(academyId));

      final responseMap = response.data as Map<String, dynamic>;
      final isSuccess = responseMap['isSuccess'] as bool? ?? false;

      if (!isSuccess) {
        throw ServerException(
          message: responseMap['message'] as String? ?? fallbackMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioException(e, fallbackMessage);
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  Never _handleDioException(DioException e, String fallbackMessage) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw NetworkException(message: 'No internet connection');
    }

    final responseData = e.response?.data;
    final serverMessage = responseData is Map<String, dynamic>
        ? responseData['message'] as String? ?? fallbackMessage
        : fallbackMessage;

    throw ServerException(
      message: serverMessage,
      statusCode: e.response?.statusCode,
    );
  }
}
