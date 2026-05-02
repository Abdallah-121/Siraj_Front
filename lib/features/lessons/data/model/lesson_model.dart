import '../../domain/entities/lesson_entity.dart';

class LessonModel extends LessonEntity {
  const LessonModel({
    required super.id,
    required super.categoryId,
    required super.categoryName,
    required super.mosqueId,
    required super.mosqueName,
    required super.teacherId,
    required super.name,
    required super.description,
    required super.isItCompleteCourse,
    required super.isActive,
    required super.status,
    required super.isPublished,
    required super.createdAt,
    required super.updatedAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int? ?? 0,
      categoryName: json['categoryName'] as String? ?? '',
      mosqueId: json['mosqueId'] as int? ?? 0,
      mosqueName: json['mosqueName'] as String? ?? '',
      teacherId: json['teacherId'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isItCompleteCourse: json['isItCompleteCourse'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      status: json['status'] as int? ?? 0,
      isPublished: json['isPublished'] as bool? ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'].toString()),
    );
  }
}
