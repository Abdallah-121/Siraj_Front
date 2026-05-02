import 'package:jwt_decoder/jwt_decoder.dart';

import '../../domain/entities/auth_session_entity.dart';

abstract final class AuthTokenParser {
  static AuthSessionEntity parse({
    required String token,
    required String fallbackUserId,
    required String fallbackFullName,
    required String fallbackEmail,
    required int fallbackRoleId,
    required String fallbackRoleName,
  }) {
    final Map<String, dynamic> claims = JwtDecoder.decode(token);

    final String userId =
        _readString(claims, const [
          'sub',
          'userId',
          'nameid',
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier',
        ]) ??
        fallbackUserId;

    final String fullName =
        _readString(claims, const [
          'fullName',
          'name',
          'unique_name',
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name',
        ]) ??
        fallbackFullName;

    final String email =
        _readString(claims, const [
          'email',
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress',
        ]) ??
        fallbackEmail;

    final int roleId =
        _readInt(claims, const ['roleId', 'role_id']) ?? fallbackRoleId;

    final String roleName =
        _readString(claims, const ['roleName', 'role', 'roles']) ??
        fallbackRoleName;

    final int? teacherId = _readInt(claims, const [
      'teacherId',
      'teacher_id',
      'TeacherId',
    ]);

    return AuthSessionEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      roleId: roleId,
      roleName: roleName,
      token: token,
      teacherId: teacherId,
    );
  }

  static String? _readString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value == null) continue;
      final text = value.toString().trim();
      if (text.isNotEmpty) return text;
    }
    return null;
  }

  static int? _readInt(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value == null) continue;
      if (value is int) return value;
      final parsed = int.tryParse(value.toString());
      if (parsed != null) return parsed;
    }
    return null;
  }
}
