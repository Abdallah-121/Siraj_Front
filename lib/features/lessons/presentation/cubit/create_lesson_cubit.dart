import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/usecases/create_lesson_usecase.dart';
import 'create_lesson_state.dart';

class CreateLessonCubit extends Cubit<CreateLessonState> {
  final CreateLessonUseCase createLessonUseCase;

  CreateLessonCubit(this.createLessonUseCase)
    : super(CreateLessonState.initial());

  Future<void> createLesson({
    required int categoryId,
    required int mosqueId,
    required int teacherId,
    required String name,
    required String description,
    required String notes,
    required bool isItACompleteCourse,
    required bool liveStreamingCapability,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await createLessonUseCase(
      CreateLessonParams(
        categoryId: categoryId,
        mosqueId: mosqueId,
        teacherId: teacherId,
        name: name,
        description: description,
        notes: notes,
        isItACompleteCourse: isItACompleteCourse,
        liveStreamingCapability: liveStreamingCapability,
      ),
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
      (_) {
        emit(
          state.copyWith(isLoading: false, isSuccess: true, clearError: true),
        );
      },
    );
  }
}
