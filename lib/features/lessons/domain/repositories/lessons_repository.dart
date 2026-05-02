import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/lesson_entity.dart';
import '../entities/lessons_page_entity.dart';
import '../usecases/create_lesson_usecase.dart';
import '../usecases/get_lessons_usecase.dart';

abstract class LessonsRepository {
  Future<Either<Failure, LessonsPageEntity>> getLessons(
    GetLessonsParams params,
  );

  Future<Either<Failure, LessonEntity>> createLesson(CreateLessonParams params);
}
