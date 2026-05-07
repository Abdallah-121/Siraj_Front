import 'package:seraj/features/lessons/domain/entities/lesson_detail_entity.dart';

class LessonDetailState {
  final bool isLoading;
  final LessonDetailEntity? lessonDetail;
  final String? errorMessage;

  const LessonDetailState({
    required this.isLoading,
    required this.lessonDetail,
    required this.errorMessage,
  });

  factory LessonDetailState.initial() {
    return const LessonDetailState(
      isLoading: false,
      lessonDetail: null,
      errorMessage: null,
    );
  }

  LessonDetailState copyWith({
    bool? isLoading,
    LessonDetailEntity? lessonDetail,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LessonDetailState(
      isLoading: isLoading ?? this.isLoading,
      lessonDetail: lessonDetail ?? this.lessonDetail,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
