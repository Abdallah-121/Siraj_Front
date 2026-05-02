import 'package:seraj/features/auth/domain/entities/auth_session_entity.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final AuthSessionEntity? session;

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
    required this.session,
  });

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
      session: null,
    );
  }

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    AuthSessionEntity? session,
    bool clearError = false,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      session: session ?? this.session,
    );
  }
}
