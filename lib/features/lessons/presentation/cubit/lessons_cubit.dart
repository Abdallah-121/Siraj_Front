import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/usecases/get_lessons_usecase.dart';
import 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  final GetLessonsUseCase getLessonsUseCase;

  LessonsCubit(this.getLessonsUseCase) : super(LessonsState.initial());

  Future<void> loadMosqueLessons({required int mosqueId}) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getLessonsUseCase(
      GetLessonsParams(mosqueId: mosqueId, isActive: true),
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (page) {
        emit(
          state.copyWith(
            isLoading: false,
            lessons: page.items,
            clearError: true,
          ),
        );
      },
    );
  }
}
