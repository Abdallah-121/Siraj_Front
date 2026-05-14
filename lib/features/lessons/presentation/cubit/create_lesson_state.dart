class CreateLessonState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const CreateLessonState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
  });

  factory CreateLessonState.initial() {
    return const CreateLessonState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  CreateLessonState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CreateLessonState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
