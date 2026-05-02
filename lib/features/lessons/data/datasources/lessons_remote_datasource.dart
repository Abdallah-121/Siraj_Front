import 'package:seraj/features/lessons/data/model/create_lesson_request_model.dart';
import 'package:seraj/features/lessons/data/model/lesson_model.dart';
import 'package:seraj/features/lessons/data/model/lessons_page_model.dart';

import '../../domain/usecases/get_lessons_usecase.dart';

abstract class LessonsRemoteDataSource {
  Future<LessonsPageModel> getLessons(GetLessonsParams params);
  Future<LessonModel> createLesson(CreateLessonRequestModel request);
}
