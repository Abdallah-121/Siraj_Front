import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/usecases/get_teachers_by_mosque_usecase.dart';
import 'mosque_teachers_state.dart';

class MosqueTeachersCubit extends Cubit<MosqueTeachersState> {
  final GetTeachersByMosqueUseCase getTeachersByMosqueUseCase;

  MosqueTeachersCubit(this.getTeachersByMosqueUseCase)
    : super(MosqueTeachersState.initial());

  Future<void> loadTeachersByMosque({required int mosqueId}) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getTeachersByMosqueUseCase(
      GetTeachersByMosqueParams(mosqueId: mosqueId),
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
      (teachers) {
        emit(
          state.copyWith(
            isLoading: false,
            teachers: teachers,
            clearError: true,
          ),
        );
      },
    );
  }
}
