import 'package:dartz/dartz.dart';
import 'package:seraj/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:seraj/features/categories/domain/usecases/update_category_usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/categories_page_entity.dart';
import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, CategoriesPageEntity>> getCategories(
    GetCategoriesParams params,
  );

  Future<Either<Failure, CategoryEntity>> getCategoryById(int id);

  Future<Either<Failure, CategoryEntity>> createCategory(
    CreateCategoryParams params,
  );

  Future<Either<Failure, CategoryEntity>> updateCategory(
    UpdateCategoryParams params,
  );

  Future<Either<Failure, Unit>> deleteCategory(int id);
}
