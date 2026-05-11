import '../../domain/entities/registered_lesson_entity.dart';

class RegisteredLessonModel extends RegisteredLessonEntity {
  const RegisteredLessonModel({
    required super.userLessonId,
    required super.lessonId,
    required super.status,
    required super.registeredAt,
    required super.notes,
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

  factory RegisteredLessonModel.fromJson(Map<String, dynamic> json) {
    return RegisteredLessonModel(
      userLessonId: json['userLessonId'] as int? ?? 0,
      lessonId: json['lessonId'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      registeredAt: json['registeredAt'] == null
          ? null
          : DateTime.tryParse(json['registeredAt'].toString()),
      notes: json['notes'] as String? ?? '',
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
