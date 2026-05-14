class UserLessonEntity {
  final int userLessonId;
  final int lessonId;
  final int status;
  final String notes;
  final DateTime? registeredAt;
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

  const UserLessonEntity({
    required this.userLessonId,
    required this.lessonId,
    required this.status,
    required this.notes,
    required this.registeredAt,
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
