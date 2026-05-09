import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/categories_repository.dart';

class DeleteCategoryUseCase {
  final CategoriesRepository repository;

  const DeleteCategoryUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int id) {
    return repository.deleteCategory(id);
  }
}
