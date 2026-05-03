import 'package:seraj/features/auth/data/helper/auth_token_parser.dart';

import '../../domain/entities/auth_session_entity.dart';

class AuthSessionModel extends AuthSessionEntity {
  const AuthSessionModel({
    required super.userId,
    required super.fullName,
    required super.email,
    required super.roleId,
    required super.roleName,
    required super.token,
    super.teacherId,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final String token = json['token'] as String? ?? '';

    final parsed = AuthTokenParser.parse(
      token: token,
      fallbackUserId: json['userId'] as String? ?? '',
      fallbackFullName: json['fullName'] as String? ?? '',
      fallbackEmail: json['email'] as String? ?? '',
      fallbackRoleId: json['roleId'] as int? ?? 0,
      fallbackRoleName: json['roleName'] as String? ?? '',
    );

    return AuthSessionModel(
      userId: json['userId'] as String? ?? parsed.userId,
      fullName: json['fullName'] as String? ?? parsed.fullName,
      email: json['email'] as String? ?? parsed.email,
      roleId: json['roleId'] as int? ?? parsed.roleId,
      roleName: json['roleName'] as String? ?? parsed.roleName,
      token: token,
      teacherId: parsed.teacherId,
    );
  }
  factory AuthSessionModel.fromStorageJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      userId: json['userId'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      roleId: json['roleId'] as int? ?? 0,
      roleName: json['roleName'] as String? ?? '',
      token: json['token'] as String? ?? '',
      teacherId: json['teacherId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'roleId': roleId,
      'roleName': roleName,
      'token': token,
      'teacherId': teacherId,
    };
  }
}
