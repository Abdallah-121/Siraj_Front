import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/lesson_entity.dart';
import '../repositories/lessons_repository.dart';

class CreateLessonUseCase {
  final LessonsRepository repository;

  CreateLessonUseCase(this.repository);

  Future<Either<Failure, LessonEntity>> call(CreateLessonParams params) {
    return repository.createLesson(params);
  }
}

class CreateLessonParams {
  final int categoryId;
  final int mosqueId;
  final int teacherId;
  final String name;
  final String description;
  final String notes;
  final bool isItACompleteCourse;
  final bool liveStreamingCapability;

  const CreateLessonParams({
    required this.categoryId,
    required this.mosqueId,
    required this.teacherId,
    required this.name,
    required this.description,
    required this.notes,
    required this.isItACompleteCourse,
    required this.liveStreamingCapability,
  });
}
