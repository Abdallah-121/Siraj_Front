import 'package:seraj/features/lessons/domain/entities/lesson_detail_entity.dart';

enum LessonDetailActionSuccessType { attended, completed }

class LessonDetailState {
  final bool isLoading;
  final bool isSubmittingAttendance;
  final bool isSubmittingCompletion;
  final bool hasAttendedInCurrentSession;
  final bool hasCompletedInCurrentSession;
  final LessonDetailEntity? lessonDetail;
  final String? errorMessage;
  final String? actionErrorMessage;
  final LessonDetailActionSuccessType? actionSuccessType;

  const LessonDetailState({
    required this.isLoading,
    required this.isSubmittingAttendance,
    required this.isSubmittingCompletion,
    required this.hasAttendedInCurrentSession,
    required this.hasCompletedInCurrentSession,
    required this.lessonDetail,
    required this.errorMessage,
    required this.actionErrorMessage,
    required this.actionSuccessType,
  });

  factory LessonDetailState.initial() {
    return const LessonDetailState(
      isLoading: false,
      isSubmittingAttendance: false,
      isSubmittingCompletion: false,
      hasAttendedInCurrentSession: false,
      hasCompletedInCurrentSession: false,
      lessonDetail: null,
      errorMessage: null,
      actionErrorMessage: null,
      actionSuccessType: null,
    );
  }

  LessonDetailState copyWith({
    bool? isLoading,
    bool? isSubmittingAttendance,
    bool? isSubmittingCompletion,
    bool? hasAttendedInCurrentSession,
    bool? hasCompletedInCurrentSession,
    LessonDetailEntity? lessonDetail,
    String? errorMessage,
    String? actionErrorMessage,
    LessonDetailActionSuccessType? actionSuccessType,
    bool clearError = false,
    bool clearActionMessages = false,
  }) {
    return LessonDetailState(
      isLoading: isLoading ?? this.isLoading,
      isSubmittingAttendance:
          isSubmittingAttendance ?? this.isSubmittingAttendance,
      isSubmittingCompletion:
          isSubmittingCompletion ?? this.isSubmittingCompletion,
      hasAttendedInCurrentSession:
          hasAttendedInCurrentSession ?? this.hasAttendedInCurrentSession,
      hasCompletedInCurrentSession:
          hasCompletedInCurrentSession ?? this.hasCompletedInCurrentSession,
      lessonDetail: lessonDetail ?? this.lessonDetail,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      actionErrorMessage: clearActionMessages
          ? null
          : actionErrorMessage ?? this.actionErrorMessage,
      actionSuccessType: clearActionMessages
          ? null
          : actionSuccessType ?? this.actionSuccessType,
    );
  }
}
