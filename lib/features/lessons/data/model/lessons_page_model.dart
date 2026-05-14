import '../../domain/entities/lessons_page_entity.dart';
import 'lesson_model.dart';

class LessonsPageModel extends LessonsPageEntity {
  const LessonsPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory LessonsPageModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawItems = json['items'] as List<dynamic>;

    return LessonsPageModel(
      items: rawItems
          .map((item) => LessonModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int? ?? 0,
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 20,
    );
  }
}
