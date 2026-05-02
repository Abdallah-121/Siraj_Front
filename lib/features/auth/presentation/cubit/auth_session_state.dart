import '../../domain/entities/auth_session_entity.dart';

class AuthSessionState {
  final bool isLoading;
  final AuthSessionEntity? session;

  const AuthSessionState({required this.isLoading, required this.session});

  factory AuthSessionState.initial() {
    return const AuthSessionState(isLoading: false, session: null);
  }

  bool get isAuthenticated =>
      session != null && session!.token.trim().isNotEmpty;

  AuthSessionState copyWith({
    bool? isLoading,
    AuthSessionEntity? session,
    bool clearSession = false,
  }) {
    return AuthSessionState(
      isLoading: isLoading ?? this.isLoading,
      session: clearSession ? null : session ?? this.session,
    );
  }
}
