import 'package:dio/dio.dart';
import 'package:seraj/features/categories/data/model/categories_page_model.dart';
import 'package:seraj/features/categories/data/model/category_model.dart';
import 'package:seraj/features/categories/data/model/category_request_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import 'categories_remote_data_source.dart';

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final DioClient dioClient;

  const CategoriesRemoteDataSourceImpl(this.dioClient);

  @override
  Future<CategoriesPageModel> getCategories({
    required int pageNumber,
    required int pageSize,
    String? search,
    String? sortBy,
    bool? descending,
  }) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.categories,
        queryParameters: {
          'PageNumber': pageNumber,
          'PageSize': pageSize,
          if (search != null && search.trim().isNotEmpty)
            'Search': search.trim(),
          if (sortBy != null && sortBy.trim().isNotEmpty)
            'SortBy': sortBy.trim(),
          if (descending != null) 'Descending': descending,
        },
      );

      final responseMap = response.data as Map<String, dynamic>;
      _ensureSuccess(response, fallbackMessage: 'Get categories failed');

      final data = responseMap['data'] as Map<String, dynamic>;
      return CategoriesPageModel.fromJson(data);
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Get categories failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    try {
      final response = await dioClient.dio.get(ApiConstants.categoryById(id));

      final responseMap = response.data as Map<String, dynamic>;
      _ensureSuccess(response, fallbackMessage: 'Get category failed');

      final data = responseMap['data'] as Map<String, dynamic>;
      return CategoryModel.fromJson(data);
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Get category failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<CategoryModel> createCategory(CategoryRequestModel request) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.categories,
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      _ensureSuccess(response, fallbackMessage: 'Create category failed');

      final data = responseMap['data'] as Map<String, dynamic>;
      return CategoryModel.fromJson(data);
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Create category failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<CategoryModel> updateCategory({
    required int id,
    required CategoryRequestModel request,
  }) async {
    try {
      final response = await dioClient.dio.put(
        ApiConstants.categoryById(id),
        data: request.toJson(),
      );

      final responseMap = response.data as Map<String, dynamic>;
      _ensureSuccess(response, fallbackMessage: 'Update category failed');

      final data = responseMap['data'] as Map<String, dynamic>;
      return CategoryModel.fromJson(data);
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Update category failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      final response = await dioClient.dio.delete(
        ApiConstants.categoryById(id),
      );

      _ensureSuccess(response, fallbackMessage: 'Delete category failed');
    } on DioException catch (e) {
      _throwMappedDioException(e, fallbackMessage: 'Delete category failed');
    } catch (_) {
      throw UnexpectedException(message: 'Unexpected error');
    }
  }

  void _ensureSuccess(
    Response<dynamic> response, {
    required String fallbackMessage,
  }) {
    final responseMap = response.data as Map<String, dynamic>;
    final isSuccess = responseMap['isSuccess'] as bool? ?? false;

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

    final serverMessage = responseData is Map<String, dynamic>
        ? responseData['message'] as String? ?? fallbackMessage
        : fallbackMessage;

    throw ServerException(
      message: serverMessage,
      statusCode: e.response?.statusCode,
    );
  }
}
