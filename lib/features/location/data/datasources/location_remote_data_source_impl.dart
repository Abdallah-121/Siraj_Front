import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/usecases/get_cities_usecase.dart';
import '../models/cities_page_model.dart';
import 'location_remote_data_source.dart';

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final DioClient dioClient;

  LocationRemoteDataSourceImpl(this.dioClient);

  @override
  Future<CitiesPageModel> getCities(GetCitiesParams params) async {
    try {
      final Response<dynamic> response = await dioClient.dio.get(
        ApiConstants.cities,
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

      return CitiesPageModel.fromJson(data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'No internet connection');
      }

      final String serverMessage = (e.response?.data is Map<String, dynamic>)
          ? ((e.response?.data['message'] as String?) ?? 'Server error')
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
