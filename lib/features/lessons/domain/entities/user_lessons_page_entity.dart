import 'user_lesson_entity.dart';

class UserLessonsPageEntity {
  final List<UserLessonEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const UserLessonsPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
