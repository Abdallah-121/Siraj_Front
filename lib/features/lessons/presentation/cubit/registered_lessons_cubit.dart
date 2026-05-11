import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../../lessons/domain/entities/registered_lesson_entity.dart';
import '../../../lessons/domain/usecases/get_my_registered_lessons_usecase.dart';
import 'registered_lessons_state.dart';

class RegisteredLessonsCubit extends Cubit<RegisteredLessonsState> {
  final GetMyRegisteredLessonsUseCase getMyRegisteredLessonsUseCase;

  RegisteredLessonsCubit(this.getMyRegisteredLessonsUseCase)
    : super(RegisteredLessonsState.initial());

  Future<void> loadLessonsByStatus({
    required int status,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    if (isClosed) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getMyRegisteredLessonsUseCase(
      GetMyRegisteredLessonsParams(
        status: status,
        pageNumber: pageNumber,
        pageSize: pageSize,
      ),
    );

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

  Future<void> loadLessonsByStatuses({
    required List<int> statuses,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    if (isClosed) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    final List<RegisteredLessonEntity> mergedLessons = [];

    for (final status in statuses) {
      final result = await getMyRegisteredLessonsUseCase(
        GetMyRegisteredLessonsParams(
          status: status,
          pageNumber: pageNumber,
          pageSize: pageSize,
        ),
      );

      if (isClosed) return;

      final shouldStop = result.fold(
        (failure) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: ErrorMapper.mapFailureToMessage(failure),
            ),
          );
          return true;
        },
        (page) {
          mergedLessons.addAll(page.items);
          return false;
        },
      );

      if (shouldStop) return;
    }

    final uniqueLessons = <int, RegisteredLessonEntity>{};

    for (final lesson in mergedLessons) {
      uniqueLessons[lesson.lessonId] = lesson;
    }

    final sortedLessons = uniqueLessons.values.toList(growable: false)
      ..sort((a, b) {
        final aDate = a.updatedAt ?? a.registeredAt;
        final bDate = b.updatedAt ?? b.registeredAt;

        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;

        return bDate.compareTo(aDate);
      });

    emit(
      state.copyWith(
        isLoading: false,
        lessons: sortedLessons,
        clearError: true,
      ),
    );
  }
}
