import '../../domain/entities/auth_session_entity.dart';
import 'auth_user_model.dart';

class AuthSessionModel extends AuthSessionEntity {
  const AuthSessionModel({required super.user, required super.token});

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      user: AuthUserModel.fromJson(json),
      token: json['token'] as String? ?? '',
    );
  }
}
