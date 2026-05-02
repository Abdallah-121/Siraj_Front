import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_session_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _sessionKey = 'auth_session';

  final FlutterSecureStorage secureStorage;

  const AuthLocalDataSourceImpl(this.secureStorage);

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    await secureStorage.write(
      key: _sessionKey,
      value: jsonEncode(session.toJson()),
    );
  }

  @override
  Future<AuthSessionModel?> getSession() async {
    final raw = await secureStorage.read(key: _sessionKey);

    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    final Map<String, dynamic> map = jsonDecode(raw) as Map<String, dynamic>;
    return AuthSessionModel.fromStorageJson(map);
  }

  @override
  Future<void> clearSession() async {
    await secureStorage.delete(key: _sessionKey);
  }

  @override
  Future<String?> getToken() async {
    final session = await getSession();
    return session?.token;
  }
}
