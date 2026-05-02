import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/auth/domain/entities/register_draft_entity.dart';
import 'package:seraj/features/auth/domain/usecases/register_usecase.dart';

import '../../../../../core/error/error_mapper.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterState.initial());

  void saveDraft(RegisterDraftEntity draft) {
    emit(state.copyWith(draft: draft, clearError: true));
  }

  Future<void> submitRegister({
    required int cityId,
    required String neighborhood,
  }) async {
    final draft = state.draft;

    if (draft == null) {
      emit(state.copyWith(errorMessage: 'Register draft is missing'));
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await registerUseCase(
      RegisterParams(
        email: draft.email,
        password: draft.password,
        firstName: draft.firstName,
        lastName: draft.lastName,
        cityId: cityId,
        phone: draft.phone,
        description: neighborhood,
        birthDate: draft.birthDate,
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
      (session) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            session: session,
            clearError: true,
          ),
        );
      },
    );
  }
}
