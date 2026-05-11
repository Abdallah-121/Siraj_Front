import '../../domain/entities/user_lessons_page_entity.dart';
import 'user_lesson_model.dart';

class UserLessonsPageModel extends UserLessonsPageEntity {
  const UserLessonsPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
  });

  factory UserLessonsPageModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];

    return UserLessonsPageModel(
      items: rawItems
          .map((item) => UserLessonModel.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      totalCount: json['totalCount'] as int? ?? 0,
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
    );
  }
}
