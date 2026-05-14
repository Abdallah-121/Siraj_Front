import 'package:dartz/dartz.dart';
import 'package:seraj/core/error/failures.dart';

import '../entities/lesson_detail_entity.dart';
import '../repositories/lessons_repository.dart';

class GetLessonDetailUseCase {
  final LessonsRepository repository;

  GetLessonDetailUseCase(this.repository);

  Future<Either<Failure, LessonDetailEntity>> call(int lessonId) {
    return repository.getLessonDetail(lessonId);
  }
}
