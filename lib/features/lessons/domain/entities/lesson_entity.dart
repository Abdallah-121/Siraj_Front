class LessonEntity {
  final int id;
  final int categoryId;
  final String categoryName;
  final int mosqueId;
  final String mosqueName;
  final int teacherId;
  final String name;
  final String description;
  final bool isItCompleteCourse;
  final bool isActive;
  final int status;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LessonEntity({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.mosqueId,
    required this.mosqueName,
    required this.teacherId,
    required this.name,
    required this.description,
    required this.isItCompleteCourse,
    required this.isActive,
    required this.status,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
  });
}
