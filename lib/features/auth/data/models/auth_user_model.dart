import '../../domain/entities/auth_user_entity.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.userId,
    required super.fullName,
    required super.email,
    required super.roleId,
    required super.roleName,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      userId: json['userId'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      roleId: json['roleId'] as int? ?? 0,
      roleName: json['roleName'] as String? ?? '',
    );
  }
}
