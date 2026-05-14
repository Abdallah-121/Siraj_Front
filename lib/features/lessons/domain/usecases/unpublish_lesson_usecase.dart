import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/lesson_entity.dart';
import '../repositories/lessons_repository.dart';

class UnpublishLessonUseCase {
  final LessonsRepository repository;

  const UnpublishLessonUseCase(this.repository);

  Future<Either<Failure, LessonEntity>> call(int lessonId) {
    return repository.unpublishLesson(lessonId);
  }
}
