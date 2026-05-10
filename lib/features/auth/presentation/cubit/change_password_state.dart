class ChangePasswordState {
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const ChangePasswordState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.errorMessage,
  });

  factory ChangePasswordState.initial() {
    return const ChangePasswordState(
      isSubmitting: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  ChangePasswordState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
    bool resetSuccess = false,
  }) {
    return ChangePasswordState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: resetSuccess ? false : isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
