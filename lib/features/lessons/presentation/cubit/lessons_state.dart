import '../../domain/entities/lesson_entity.dart';

enum LessonActionSuccessType { published, unpublished }

class LessonsState {
  final bool isLoading;
  final List<LessonEntity> lessons;
  final String? errorMessage;

  final int? publishingLessonId;
  final int? unpublishingLessonId;
  final String? actionErrorMessage;
  final LessonActionSuccessType? actionSuccessType;

  const LessonsState({
    required this.isLoading,
    required this.lessons,
    required this.errorMessage,
    required this.publishingLessonId,
    required this.unpublishingLessonId,
    required this.actionErrorMessage,
    required this.actionSuccessType,
  });

  factory LessonsState.initial() {
    return const LessonsState(
      isLoading: false,
      lessons: [],
      errorMessage: null,
      publishingLessonId: null,
      unpublishingLessonId: null,
      actionErrorMessage: null,
      actionSuccessType: null,
    );
  }

  LessonsState copyWith({
    bool? isLoading,
    List<LessonEntity>? lessons,
    String? errorMessage,
    int? publishingLessonId,
    int? unpublishingLessonId,
    String? actionErrorMessage,
    LessonActionSuccessType? actionSuccessType,
    bool clearError = false,
    bool clearPublishingLessonId = false,
    bool clearUnpublishingLessonId = false,
    bool clearActionMessages = false,
  }) {
    return LessonsState(
      isLoading: isLoading ?? this.isLoading,
      lessons: lessons ?? this.lessons,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      publishingLessonId: clearPublishingLessonId
          ? null
          : publishingLessonId ?? this.publishingLessonId,
      unpublishingLessonId: clearUnpublishingLessonId
          ? null
          : unpublishingLessonId ?? this.unpublishingLessonId,
      actionErrorMessage: clearActionMessages
          ? null
          : actionErrorMessage ?? this.actionErrorMessage,
      actionSuccessType: clearActionMessages
          ? null
          : actionSuccessType ?? this.actionSuccessType,
    );
  }
}
