import 'package:dio/dio.dart';
import 'package:seraj/core/error/exceptions.dart';
import 'package:seraj/core/network/api_constants.dart';
import 'package:seraj/core/network/dio_client.dart';
import 'package:seraj/features/explore/presentation/mosques/data/models/create_mosque_request_model.dart';
import 'package:seraj/features/explore/presentation/mosques/data/models/mosque_model.dart';

import '../../domain/usecases/get_mosques_usecase.dart';
import '../models/mosques_page_model.dart';
import 'mosques_remote_data_source.dart';

class MosquesRemoteDataSourceImpl implements MosquesRemoteDataSource {
  final DioClient dioClient;

  MosquesRemoteDataSourceImpl(this.dioClient);

  @override
  Future<MosquesPageModel> getMosques(GetMosquesParams params) async {
    try {
      final Response<dynamic> response = await dioClient.dio.get(
        ApiConstants.mosques,
        queryParameters: {
          'PageNumber': params.pageNumber,
          'PageSize': params.pageSize,
          if (params.search != null && params.search!.trim().isNotEmpty)
            'Search': params.search,
          if (params.sortBy != null && params.sortBy!.trim().isNotEmpty)
            'SortBy': params.sortBy,
          if (params.descending != null) 'Descending': params.descending,
          if (params.regionId != null) 'RegionId': params.regionId,
          if (params.cityId != null) 'CityId': params.cityId,
          if (params.isActive != null) 'IsActive': params.isActive,
        },
      );

      final Map<String, dynamic> responseMap =
          response.data as Map<String, dynamic>;

      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;
      final String message =
          responseMap['message'] as String? ?? 'Server error';

      if (!isSuccess) {
        throw ServerException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      final Map<String, dynamic> data =
          responseMap['data'] as Map<String, dynamic>;

      return MosquesPageModel.fromJson(data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final dynamic responseData = e.response?.data;
      final String serverMessage = responseData is Map<String, dynamic>
          ? (responseData['message'] as String? ?? 'Server error')
          : 'Server error';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<MosqueModel> createMosque(CreateMosqueRequestModel request) async {
    try {
      final Response<dynamic> response = await dioClient.dio.post(
        ApiConstants.mosques,
        data: request.toJson(),
      );

      final Map<String, dynamic> responseMap =
          response.data as Map<String, dynamic>;

      final bool isSuccess = responseMap['isSuccess'] as bool? ?? false;
      final String message =
          responseMap['message'] as String? ?? 'Create mosque failed';

      if (!isSuccess) {
        throw ServerException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      final Map<String, dynamic> data =
          responseMap['data'] as Map<String, dynamic>;

      return MosqueModel.fromJson(data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final dynamic responseData = e.response?.data;
      final String serverMessage = responseData is Map<String, dynamic>
          ? (responseData['message'] as String? ?? 'Create mosque failed')
          : 'Create mosque failed';

      throw ServerException(
        message: serverMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }
}
