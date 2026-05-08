import '../../../auth/domain/entities/auth_session_entity.dart';

class EditProfileState {
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;
  final AuthSessionEntity? updatedSession;

  const EditProfileState({
    required this.isSubmitting,
    required this.errorMessage,
    required this.isSuccess,
    required this.updatedSession,
  });

  factory EditProfileState.initial() {
    return const EditProfileState(
      isSubmitting: false,
      errorMessage: null,
      isSuccess: false,
      updatedSession: null,
    );
  }

  EditProfileState copyWith({
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
    AuthSessionEntity? updatedSession,
    bool clearError = false,
  }) {
    return EditProfileState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      updatedSession: updatedSession ?? this.updatedSession,
    );
  }
}
