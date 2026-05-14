import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class CreateCategoryUseCase {
  final CategoriesRepository repository;

  const CreateCategoryUseCase(this.repository);

  Future<Either<Failure, CategoryEntity>> call(CreateCategoryParams params) {
    return repository.createCategory(params);
  }
}

class CreateCategoryParams {
  final String name;

  const CreateCategoryParams({required this.name});
}
