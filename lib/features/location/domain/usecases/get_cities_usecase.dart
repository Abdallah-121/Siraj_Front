import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cities_page_entity.dart';
import '../repositories/location_repository.dart';

class GetCitiesUseCase {
  final LocationRepository repository;

  GetCitiesUseCase(this.repository);

  Future<Either<Failure, CitiesPageEntity>> call(GetCitiesParams params) {
    return repository.getCities(params);
  }
}

class GetCitiesParams {
  final int pageNumber;
  final int pageSize;
  final String? search;
  final String? sortBy;
  final bool? descending;

  const GetCitiesParams({
    this.pageNumber = 1,
    this.pageSize = 50,
    this.search,
    this.sortBy,
    this.descending,
  });
}
