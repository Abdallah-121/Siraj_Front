import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academies_page_entity.dart';

import '../repositories/academies_repository.dart';

class GetAcademiesUseCase {
  final AcademiesRepository repository;

  GetAcademiesUseCase(this.repository);

  Future<Either<Failure, AcademiesPageEntity>> call(GetAcademiesParams params) {
    return repository.getAcademies(params);
  }
}

class GetAcademiesParams {
  final int pageNumber;
  final int pageSize;
  final String? search;
  final String? sortBy;
  final bool? descending;

  const GetAcademiesParams({
    this.pageNumber = 1,
    this.pageSize = 20,
    this.search,
    this.sortBy,
    this.descending,
  });
}
