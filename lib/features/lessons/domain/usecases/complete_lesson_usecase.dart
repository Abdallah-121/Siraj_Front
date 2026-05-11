import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/lessons_repository.dart';

class CompleteLessonUseCase {
  final LessonsRepository repository;

  CompleteLessonUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int lessonId) {
    return repository.completeLesson(lessonId);
  }
}
