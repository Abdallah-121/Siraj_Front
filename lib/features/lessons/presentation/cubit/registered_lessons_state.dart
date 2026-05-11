import '../../../lessons/domain/entities/registered_lesson_entity.dart';

class RegisteredLessonsState {
  final bool isLoading;
  final List<RegisteredLessonEntity> lessons;
  final String? errorMessage;

  const RegisteredLessonsState({
    required this.isLoading,
    required this.lessons,
    required this.errorMessage,
  });

  factory RegisteredLessonsState.initial() {
    return const RegisteredLessonsState(
      isLoading: false,
      lessons: [],
      errorMessage: null,
    );
  }

  RegisteredLessonsState copyWith({
    bool? isLoading,
    List<RegisteredLessonEntity>? lessons,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RegisteredLessonsState(
      isLoading: isLoading ?? this.isLoading,
      lessons: lessons ?? this.lessons,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
