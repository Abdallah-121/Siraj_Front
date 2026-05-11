import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/lessons_repository.dart';

class AttendLessonUseCase {
  final LessonsRepository repository;

  AttendLessonUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int lessonId) {
    return repository.attendLesson(lessonId);
  }
}
