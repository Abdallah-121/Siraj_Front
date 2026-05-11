import '../../domain/entities/registered_lessons_page_entity.dart';
import 'registered_lesson_model.dart';

class RegisteredLessonsPageModel extends RegisteredLessonsPageEntity {
  const RegisteredLessonsPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory RegisteredLessonsPageModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];

    return RegisteredLessonsPageModel(
      items: rawItems
          .map(
            (item) =>
                RegisteredLessonModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(growable: false),
      totalCount: json['totalCount'] as int? ?? 0,
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
    );
  }
}
