import 'package:seraj/features/lessons/data/model/create_lesson_request_model.dart';
import 'package:seraj/features/lessons/data/model/lesson_detail_model.dart';
import 'package:seraj/features/lessons/data/model/lesson_model.dart';
import 'package:seraj/features/lessons/data/model/lessons_page_model.dart';
import 'package:seraj/features/lessons/data/model/registered_lessons_page_model.dart';

import '../../domain/usecases/get_lessons_usecase.dart';
import '../../domain/usecases/get_my_registered_lessons_usecase.dart';

abstract class LessonsRemoteDataSource {
  Future<LessonsPageModel> getLessons(GetLessonsParams params);

  Future<LessonModel> createLesson(CreateLessonRequestModel request);

  Future<LessonDetailModel> getLessonDetail(int lessonId);

  Future<LessonModel> publishLesson(int lessonId);

  Future<LessonModel> unpublishLesson(int lessonId);

  Future<void> attendLesson(int lessonId);

  Future<void> completeLesson(int lessonId);

  Future<RegisteredLessonsPageModel> getMyRegisteredLessons(
    GetMyRegisteredLessonsParams params,
  );
}
