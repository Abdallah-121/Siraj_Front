import 'package:dio/dio.dart';
import 'package:seraj/core/error/exceptions.dart';
import 'package:seraj/core/network/api_constants.dart';
import 'package:seraj/core/network/dio_client.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';

import '../models/academies_page_model.dart';
import 'academies_remote_data_source.dart';

class AcademiesRemoteDataSourceImpl implements AcademiesRemoteDataSource {
  final DioClient dioClient;

  AcademiesRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AcademiesPageModel> getAcademies(GetAcademiesParams params) async {
    try {
      final Response<dynamic> response = await dioClient.dio.get(
        ApiConstants.academies,
        queryParameters: {
          'PageNumber': params.pageNumber,
          'PageSize': params.pageSize,
          if (params.search != null && params.search!.trim().isNotEmpty)
            'Search': params.search,
          if (params.sortBy != null && params.sortBy!.trim().isNotEmpty)
            'SortBy': params.sortBy,
          if (params.descending != null) 'Descending': params.descending,
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

      return AcademiesPageModel.fromJson(data);
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
}
