import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../entites/mosque_entity.dart';
import '../repositories/mosques_repository.dart';

class GetMosquesByLessonCategoryUseCase {
  final MosquesRepository repository;

  const GetMosquesByLessonCategoryUseCase(this.repository);

  Future<Either<Failure, List<MosqueEntity>>> call(
    GetMosquesByLessonCategoryParams params,
  ) {
    return repository.getMosquesByLessonCategory(
      categoryId: params.categoryId,
      cityId: params.cityId,
      regionId: params.regionId,
      isActive: params.isActive,
    );
  }
}

class GetMosquesByLessonCategoryParams {
  final int categoryId;
  final int? cityId;
  final int? regionId;
  final bool? isActive;

  const GetMosquesByLessonCategoryParams({
    required this.categoryId,
    this.cityId,
    this.regionId,
    this.isActive,
  });
}
