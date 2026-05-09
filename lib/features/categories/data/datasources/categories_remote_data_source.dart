import 'package:seraj/features/categories/data/model/categories_page_model.dart';
import 'package:seraj/features/categories/data/model/category_model.dart';
import 'package:seraj/features/categories/data/model/category_request_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoriesPageModel> getCategories({
    required int pageNumber,
    required int pageSize,
    String? search,
    String? sortBy,
    bool? descending,
  });

  Future<CategoryModel> getCategoryById(int id);

  Future<CategoryModel> createCategory(CategoryRequestModel request);

  Future<CategoryModel> updateCategory({
    required int id,
    required CategoryRequestModel request,
  });

  Future<void> deleteCategory(int id);
}
