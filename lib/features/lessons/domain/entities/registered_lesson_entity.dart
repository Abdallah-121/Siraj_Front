class RegisteredLessonEntity {
  final int userLessonId;
  final int lessonId;
  final int status;
  final DateTime? registeredAt;
  final String notes;
  final DateTime? updatedAt;
  final String lessonName;
  final String lessonDescription;
  final int categoryId;
  final String categoryName;
  final int mosqueId;
  final String mosqueName;
  final int teacherId;
  final String teacherName;
  final bool lessonIsActive;

  const RegisteredLessonEntity({
    required this.userLessonId,
    required this.lessonId,
    required this.status,
    required this.registeredAt,
    required this.notes,
    required this.updatedAt,
    required this.lessonName,
    required this.lessonDescription,
    required this.categoryId,
    required this.categoryName,
    required this.mosqueId,
    required this.mosqueName,
    required this.teacherId,
    required this.teacherName,
    required this.lessonIsActive,
  });
}
