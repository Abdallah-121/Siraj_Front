class LessonDetailEntity {
  final int lessonId;
  final String name;
  final String description;
  final String notes;
  final bool isItACompleteCourse;
  final bool liveStreamingCapability;
  final String status;
  final bool isActive;
  final bool isPublished;
  final LessonCategoryEntity category;
  final LessonMosqueEntity mosque;
  final LessonTeacherEntity teacher;

  const LessonDetailEntity({
    required this.lessonId,
    required this.name,
    required this.description,
    required this.notes,
    required this.isItACompleteCourse,
    required this.liveStreamingCapability,
    required this.status,
    required this.isActive,
    required this.isPublished,
    required this.category,
    required this.mosque,
    required this.teacher,
  });
}

class LessonCategoryEntity {
  final int categoryId;
  final String categoryName;

  const LessonCategoryEntity({
    required this.categoryId,
    required this.categoryName,
  });
}

class LessonMosqueEntity {
  final int mosqueId;
  final String mosqueName;
  final String address;
  final String phoneNumber;

  const LessonMosqueEntity({
    required this.mosqueId,
    required this.mosqueName,
    required this.address,
    required this.phoneNumber,
  });
}

class LessonTeacherEntity {
  final int teacherId;
  final String fullName;
  final String qualification;
  final String bio;

  const LessonTeacherEntity({
    required this.teacherId,
    required this.fullName,
    required this.qualification,
    required this.bio,
  });
}
