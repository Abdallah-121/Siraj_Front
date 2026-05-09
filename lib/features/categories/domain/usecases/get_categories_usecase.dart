import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/categories_page_entity.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  const GetCategoriesUseCase(this.repository);

  Future<Either<Failure, CategoriesPageEntity>> call(
    GetCategoriesParams params,
  ) {
    return repository.getCategories(params);
  }
}

class GetCategoriesParams {
  final int pageNumber;
  final int pageSize;
  final String? search;
  final String? sortBy;
  final bool? descending;

  const GetCategoriesParams({
    this.pageNumber = 1,
    this.pageSize = 50,
    this.search,
    this.sortBy,
    this.descending,
  });
}
