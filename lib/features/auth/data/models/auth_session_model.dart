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
    super.firstName,
    super.lastName,
    super.phone,
    super.profileImage,
    super.description,
    super.cityId,
    super.birthDate,
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

    final String firstName = json['firstName'] as String? ?? '';
    final String lastName = json['lastName'] as String? ?? '';
    final String fullNameFromParts = '$firstName $lastName'.trim();

    return AuthSessionModel(
      userId: json['userId'] as String? ?? parsed.userId,
      fullName:
          json['fullName'] as String? ??
          (fullNameFromParts.isNotEmpty ? fullNameFromParts : parsed.fullName),
      email: json['email'] as String? ?? parsed.email,
      roleId: json['roleId'] as int? ?? parsed.roleId,
      roleName: json['roleName'] as String? ?? parsed.roleName,
      token: token,
      teacherId: parsed.teacherId,
      firstName: firstName,
      lastName: lastName,
      phone: json['phone'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      description: json['description'] as String? ?? '',
      cityId: json['cityId'] as int?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.tryParse(json['birthDate'].toString()),
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
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      description: json['description'] as String? ?? '',
      cityId: json['cityId'] as int?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.tryParse(json['birthDate'].toString()),
    );
  }

  factory AuthSessionModel.fromEntity(AuthSessionEntity entity) {
    return AuthSessionModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      roleId: entity.roleId,
      roleName: entity.roleName,
      token: entity.token,
      teacherId: entity.teacherId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phone: entity.phone,
      profileImage: entity.profileImage,
      description: entity.description,
      cityId: entity.cityId,
      birthDate: entity.birthDate,
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
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'profileImage': profileImage,
      'description': description,
      'cityId': cityId,
      'birthDate': birthDate?.toIso8601String(),
    };
  }
}
