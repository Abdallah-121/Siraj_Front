import '../models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthSessionModel session);
  Future<AuthSessionModel?> getSession();
  Future<void> clearSession();
  Future<String?> getToken();
}
