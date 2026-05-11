import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/registered_lessons_page_entity.dart';
import '../repositories/lessons_repository.dart';

class GetMyRegisteredLessonsUseCase {
  final LessonsRepository repository;

  GetMyRegisteredLessonsUseCase(this.repository);

  Future<Either<Failure, RegisteredLessonsPageEntity>> call(
    GetMyRegisteredLessonsParams params,
  ) {
    return repository.getMyRegisteredLessons(params);
  }
}

class GetMyRegisteredLessonsParams {
  final int? status;
  final int pageNumber;
  final int pageSize;

  const GetMyRegisteredLessonsParams({
    this.status,
    this.pageNumber = 1,
    this.pageSize = 20,
  });
}
