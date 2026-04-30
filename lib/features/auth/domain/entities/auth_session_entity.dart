import 'auth_user_entity.dart';

class AuthSessionEntity {
  final AuthUserEntity user;
  final String token;

  const AuthSessionEntity({required this.user, required this.token});
}
