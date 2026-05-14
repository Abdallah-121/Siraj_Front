import '../../domain/entities/user_lesson_entity.dart';

class UserLessonModel extends UserLessonEntity {
  const UserLessonModel({
    required super.userLessonId,
    required super.lessonId,
    required super.status,
    required super.notes,
    required super.registeredAt,
    required super.updatedAt,
    required super.lessonName,
    required super.lessonDescription,
    required super.categoryId,
    required super.categoryName,
    required super.mosqueId,
    required super.mosqueName,
    required super.teacherId,
    required super.teacherName,
    required super.lessonIsActive,
  });

  factory UserLessonModel.fromJson(Map<String, dynamic> json) {
    return UserLessonModel(
      userLessonId: json['userLessonId'] as int? ?? json['id'] as int? ?? 0,
      lessonId: json['lessonId'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      notes: json['notes'] as String? ?? '',
      registeredAt: json['registeredAt'] == null
          ? null
          : DateTime.tryParse(json['registeredAt'].toString()),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'].toString()),
      lessonName: json['lessonName'] as String? ?? '',
      lessonDescription: json['lessonDescription'] as String? ?? '',
      categoryId: json['categoryId'] as int? ?? 0,
      categoryName: json['categoryName'] as String? ?? '',
      mosqueId: json['mosqueId'] as int? ?? 0,
      mosqueName: json['mosqueName'] as String? ?? '',
      teacherId: json['teacherId'] as int? ?? 0,
      teacherName: json['teacherName'] as String? ?? '',
      lessonIsActive: json['lessonIsActive'] as bool? ?? false,
    );
  }
}
