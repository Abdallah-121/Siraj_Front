import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/lessons/domain/usecases/get_lesson_detail_usecase.dart';

import 'lesson_detail_state.dart';

class LessonDetailCubit extends Cubit<LessonDetailState> {
  final GetLessonDetailUseCase getLessonDetailUseCase;

  LessonDetailCubit(this.getLessonDetailUseCase)
    : super(LessonDetailState.initial());

  Future<void> loadLessonDetail(int lessonId) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getLessonDetailUseCase(lessonId);

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
}
