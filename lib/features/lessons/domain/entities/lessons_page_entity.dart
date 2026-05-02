import 'lesson_entity.dart';

class LessonsPageEntity {
  final List<LessonEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const LessonsPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
