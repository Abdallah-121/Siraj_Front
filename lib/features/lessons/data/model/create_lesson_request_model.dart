class CreateLessonRequestModel {
  final int categoryId;
  final int mosqueId;
  final int teacherId;
  final String name;
  final String description;
  final String notes;
  final bool isItACompleteCourse;
  final bool liveStreamingCapability;

  const CreateLessonRequestModel({
    required this.categoryId,
    required this.mosqueId,
    required this.teacherId,
    required this.name,
    required this.description,
    required this.notes,
    required this.isItACompleteCourse,
    required this.liveStreamingCapability,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'mosqueId': mosqueId,
      'teacherId': teacherId,
      'name': name,
      'description': description,
      'notes': notes,
      'isItACompleteCourse': isItACompleteCourse,
      'liveStreamingCapability': liveStreamingCapability,
    };
  }
}
