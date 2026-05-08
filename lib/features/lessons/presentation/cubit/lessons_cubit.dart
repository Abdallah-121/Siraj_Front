import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/usecases/get_lessons_usecase.dart';
import '../../domain/usecases/publish_lesson_usecase.dart';
import '../../domain/usecases/unpublish_lesson_usecase.dart';
import 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  final GetLessonsUseCase getLessonsUseCase;
  final PublishLessonUseCase publishLessonUseCase;
  final UnpublishLessonUseCase unpublishLessonUseCase;

  LessonsCubit({
    required this.getLessonsUseCase,
    required this.publishLessonUseCase,
    required this.unpublishLessonUseCase,
  }) : super(LessonsState.initial());

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

  Future<void> publishLesson({required int lessonId}) async {
    emit(
      state.copyWith(publishingLessonId: lessonId, clearActionMessages: true),
    );

    final result = await publishLessonUseCase(lessonId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            clearPublishingLessonId: true,
            actionErrorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (updatedLesson) {
        emit(
          state.copyWith(
            clearPublishingLessonId: true,
            lessons: _replaceLesson(updatedLesson),
            actionSuccessType: LessonActionSuccessType.published,
          ),
        );
      },
    );
  }

  Future<void> unpublishLesson({required int lessonId}) async {
    emit(
      state.copyWith(unpublishingLessonId: lessonId, clearActionMessages: true),
    );

    final result = await unpublishLessonUseCase(lessonId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            clearUnpublishingLessonId: true,
            actionErrorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (updatedLesson) {
        emit(
          state.copyWith(
            clearUnpublishingLessonId: true,
            lessons: _replaceLesson(updatedLesson),
            actionSuccessType: LessonActionSuccessType.unpublished,
          ),
        );
      },
    );
  }

  void clearActionMessages() {
    emit(state.copyWith(clearActionMessages: true));
  }

  List<LessonEntity> _replaceLesson(LessonEntity updatedLesson) {
    return state.lessons
        .map((lesson) => lesson.id == updatedLesson.id ? updatedLesson : lesson)
        .toList(growable: false);
  }
}
