import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class GetCategoryByIdUseCase {
  final CategoriesRepository repository;

  const GetCategoryByIdUseCase(this.repository);

  Future<Either<Failure, CategoryEntity>> call(int id) {
    return repository.getCategoryById(id);
  }
}
