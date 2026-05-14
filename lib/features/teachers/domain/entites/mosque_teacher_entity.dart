class MosqueTeacherEntity {
  final int teacherId;
  final String userId;
  final String qualification;
  final String bio;
  final bool isActive;
  final bool isVerified;
  final bool hasPermission;

  const MosqueTeacherEntity({
    required this.teacherId,
    required this.userId,
    required this.qualification,
    required this.bio,
    required this.isActive,
    required this.isVerified,
    required this.hasPermission,
  });
}
