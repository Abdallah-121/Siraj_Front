import 'package:seraj/features/auth/domain/entities/register_draft_entity.dart';

class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final RegisterDraftEntity? draft;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
    required this.draft,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
      draft: null,
    );
  }

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    RegisterDraftEntity? draft,
    bool clearError = false,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      draft: draft ?? this.draft,
    );
  }
}
