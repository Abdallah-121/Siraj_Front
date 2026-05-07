import '../../domain/entities/lesson_detail_entity.dart';

class LessonDetailModel extends LessonDetailEntity {
  const LessonDetailModel({
    required super.lessonId,
    required super.name,
    required super.description,
    required super.notes,
    required super.isItACompleteCourse,
    required super.liveStreamingCapability,
    required super.status,
    required super.isActive,
    required super.isPublished,
    required super.category,
    required super.mosque,
    required super.teacher,
  });

  factory LessonDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    final categoryMap = data['category'] as Map<String, dynamic>;
    final mosqueMap = data['mosque'] as Map<String, dynamic>;
    final teacherMap = data['teacher'] as Map<String, dynamic>;

    return LessonDetailModel(
      lessonId: data['lessonId'] as int,
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      notes: data['notes'] as String? ?? '',
      isItACompleteCourse: data['isItACompleteCourse'] as bool? ?? false,
      liveStreamingCapability:
          data['liveStreamingCapability'] as bool? ?? false,
      status: data['status'] as String? ?? '',
      isActive: data['isActive'] as bool? ?? false,
      isPublished: data['isPublished'] as bool? ?? false,
      category: LessonCategoryEntity(
        categoryId: categoryMap['categoryId'] as int,
        categoryName: categoryMap['categoryName'] as String? ?? '',
      ),
      mosque: LessonMosqueEntity(
        mosqueId: mosqueMap['mosqueId'] as int,
        mosqueName: mosqueMap['mosqueName'] as String? ?? '',
        address: mosqueMap['address'] as String? ?? '',
        phoneNumber: mosqueMap['phoneNumber'] as String? ?? '',
      ),
      teacher: LessonTeacherEntity(
        teacherId: teacherMap['teacherId'] as int,
        fullName: teacherMap['fullName'] as String? ?? '',
        qualification: teacherMap['qualification'] as String? ?? '',
        bio: teacherMap['bio'] as String? ?? '',
      ),
    );
  }
}
