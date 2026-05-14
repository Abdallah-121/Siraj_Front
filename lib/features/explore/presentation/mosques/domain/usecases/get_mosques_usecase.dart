import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosques_page_entity.dart';

import '../repositories/mosques_repository.dart';

class GetMosquesUseCase {
  final MosquesRepository repository;

  GetMosquesUseCase(this.repository);

  Future<Either<Failure, MosquesPageEntity>> call(GetMosquesParams params) {
    return repository.getMosques(params);
  }
}

class GetMosquesParams {
  final int pageNumber;
  final int pageSize;
  final String? search;
  final String? sortBy;
  final bool? descending;
  final int? regionId;
  final int? cityId;
  final bool? isActive;

  const GetMosquesParams({
    this.pageNumber = 1,
    this.pageSize = 20,
    this.search,
    this.sortBy,
    this.descending,
    this.regionId,
    this.cityId,
    this.isActive,
  });
}
