import 'registered_lesson_entity.dart';

class RegisteredLessonsPageEntity {
  final List<RegisteredLessonEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const RegisteredLessonsPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
