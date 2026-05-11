import 'package:dartz/dartz.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_detail_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/lesson_entity.dart';
import '../entities/lessons_page_entity.dart';
import '../entities/registered_lessons_page_entity.dart';
import '../usecases/create_lesson_usecase.dart';
import '../usecases/get_lessons_usecase.dart';
import '../usecases/get_my_registered_lessons_usecase.dart';

abstract class LessonsRepository {
  Future<Either<Failure, LessonsPageEntity>> getLessons(
    GetLessonsParams params,
  );

  Future<Either<Failure, LessonEntity>> createLesson(CreateLessonParams params);

  Future<Either<Failure, LessonDetailEntity>> getLessonDetail(int lessonId);

  Future<Either<Failure, LessonEntity>> publishLesson(int lessonId);

  Future<Either<Failure, LessonEntity>> unpublishLesson(int lessonId);

  Future<Either<Failure, Unit>> attendLesson(int lessonId);

  Future<Either<Failure, Unit>> completeLesson(int lessonId);

  Future<Either<Failure, RegisteredLessonsPageEntity>> getMyRegisteredLessons(
    GetMyRegisteredLessonsParams params,
  );
}
