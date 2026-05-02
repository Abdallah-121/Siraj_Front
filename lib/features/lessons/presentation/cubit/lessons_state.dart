import '../../domain/entities/lesson_entity.dart';

class LessonsState {
  final bool isLoading;
  final List<LessonEntity> lessons;
  final String? errorMessage;

  const LessonsState({
    required this.isLoading,
    required this.lessons,
    required this.errorMessage,
  });

  factory LessonsState.initial() {
    return const LessonsState(
      isLoading: false,
      lessons: [],
      errorMessage: null,
    );
  }

  LessonsState copyWith({
    bool? isLoading,
    List<LessonEntity>? lessons,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LessonsState(
      isLoading: isLoading ?? this.isLoading,
      lessons: lessons ?? this.lessons,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
