import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../entites/academies_page_entity.dart';
import '../repositories/academies_repository.dart';

class GetAcademiesByLocationUseCase {
  final AcademiesRepository repository;

  GetAcademiesByLocationUseCase(this.repository);

  Future<Either<Failure, AcademiesPageEntity>> call(
    GetAcademiesByLocationParams params,
  ) {
    return repository.getAcademiesByLocation(
      regionId: params.regionId,
      cityId: params.cityId,
      excludeRegionId: params.excludeRegionId,
      isActive: params.isActive,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class GetAcademiesByLocationParams {
  final int? regionId;
  final int? cityId;
  final int? excludeRegionId;
  final bool? isActive;
  final int pageNumber;
  final int pageSize;

  const GetAcademiesByLocationParams({
    this.regionId,
    this.cityId,
    this.excludeRegionId,
    this.isActive,
    this.pageNumber = 1,
    this.pageSize = 20,
  });
}
