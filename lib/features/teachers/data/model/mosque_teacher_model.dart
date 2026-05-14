import 'package:seraj/features/teachers/domain/entites/mosque_teacher_entity.dart';

class MosqueTeacherModel extends MosqueTeacherEntity {
  const MosqueTeacherModel({
    required super.teacherId,
    required super.userId,
    required super.qualification,
    required super.bio,
    required super.isActive,
    required super.isVerified,
    required super.hasPermission,
  });

  factory MosqueTeacherModel.fromJson(Map<String, dynamic> json) {
    return MosqueTeacherModel(
      teacherId: json['teacherId'] as int? ?? 0,
      userId: json['userId'] as String? ?? '',
      qualification: json['qualification'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      hasPermission: json['hasPermission'] as bool? ?? false,
    );
  }
}
