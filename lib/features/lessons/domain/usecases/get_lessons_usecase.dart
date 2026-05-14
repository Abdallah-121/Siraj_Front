import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/lessons_page_entity.dart';
import '../repositories/lessons_repository.dart';

class GetLessonsUseCase {
  final LessonsRepository repository;

  GetLessonsUseCase(this.repository);

  Future<Either<Failure, LessonsPageEntity>> call(GetLessonsParams params) {
    return repository.getLessons(params);
  }
}

class GetLessonsParams {
  final int pageNumber;
  final int pageSize;
  final String? search;
  final int? mosqueId;
  final int? categoryId;
  final int? teacherId;
  final bool? isActive;
  final int? status;

  const GetLessonsParams({
    this.pageNumber = 1,
    this.pageSize = 20,
    this.search,
    this.mosqueId,
    this.categoryId,
    this.teacherId,
    this.isActive,
    this.status,
  });
}
