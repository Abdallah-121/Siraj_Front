import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class UpdateCategoryUseCase {
  final CategoriesRepository repository;

  const UpdateCategoryUseCase(this.repository);

  Future<Either<Failure, CategoryEntity>> call(UpdateCategoryParams params) {
    return repository.updateCategory(params);
  }
}

class UpdateCategoryParams {
  final int id;
  final String name;

  const UpdateCategoryParams({required this.id, required this.name});
}
