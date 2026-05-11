import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/lessons/domain/usecases/attend_lesson_usecase.dart';
import 'package:seraj/features/lessons/domain/usecases/complete_lesson_usecase.dart';
import 'package:seraj/features/lessons/domain/usecases/get_lesson_detail_usecase.dart';

import 'lesson_detail_state.dart';

class LessonDetailCubit extends Cubit<LessonDetailState> {
  final GetLessonDetailUseCase getLessonDetailUseCase;
  final AttendLessonUseCase attendLessonUseCase;
  final CompleteLessonUseCase completeLessonUseCase;

  LessonDetailCubit({
    required this.getLessonDetailUseCase,
    required this.attendLessonUseCase,
    required this.completeLessonUseCase,
  }) : super(LessonDetailState.initial());

  Future<void> loadLessonDetail(int lessonId) async {
    if (isClosed) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getLessonDetailUseCase(lessonId);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (lessonDetail) {
        emit(
          state.copyWith(
            isLoading: false,
            lessonDetail: lessonDetail,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> attendLesson(int lessonId) async {
    if (isClosed) return;

    emit(
      state.copyWith(isSubmittingAttendance: true, clearActionMessages: true),
    );

    final result = await attendLessonUseCase(lessonId);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSubmittingAttendance: false,
            actionErrorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            isSubmittingAttendance: false,
            hasAttendedInCurrentSession: true,
            actionSuccessType: LessonDetailActionSuccessType.attended,
          ),
        );
      },
    );
  }

  Future<void> completeLesson(int lessonId) async {
    if (isClosed) return;

    emit(
      state.copyWith(isSubmittingCompletion: true, clearActionMessages: true),
    );

    final result = await completeLessonUseCase(lessonId);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSubmittingCompletion: false,
            actionErrorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            isSubmittingCompletion: false,
            hasCompletedInCurrentSession: true,
            actionSuccessType: LessonDetailActionSuccessType.completed,
          ),
        );
      },
    );
  }

  void clearActionMessages() {
    if (isClosed) return;
    emit(state.copyWith(clearActionMessages: true));
  }
}
