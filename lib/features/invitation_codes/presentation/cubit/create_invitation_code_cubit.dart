import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/invitation_codes/domain/usecaases/create_mosque_manager_invitation_code_usecase.dart';

import '../../../../core/error/error_mapper.dart';
import 'create_invitation_code_state.dart';

class CreateInvitationCodeCubit extends Cubit<CreateInvitationCodeState> {
  final CreateMosqueManagerInvitationCodeUseCase useCase;

  CreateInvitationCodeCubit(this.useCase)
    : super(CreateInvitationCodeState.initial());

  Future<void> createCode({
    required int mosqueId,
    required int expiresInDays,
    required String notes,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearResult: true));

    final result = await useCase(
      mosqueId: mosqueId,
      expiresInDays: expiresInDays,
      notes: notes,
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
      (codeResult) {
        emit(
          state.copyWith(
            isLoading: false,
            result: codeResult,
            clearError: true,
          ),
        );
      },
    );
  }
}
