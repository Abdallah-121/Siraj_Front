import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/lesson_entity.dart';
import '../repositories/lessons_repository.dart';

class PublishLessonUseCase {
  final LessonsRepository repository;

  const PublishLessonUseCase(this.repository);

  Future<Either<Failure, LessonEntity>> call(int lessonId) {
    return repository.publishLesson(lessonId);
  }
}
