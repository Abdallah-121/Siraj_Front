import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/invitation_codes/domain/usecaases/redeem_invitation_code_usecase.dart';

import '../../../../core/error/error_mapper.dart';
import 'redeem_invitation_code_state.dart';

class RedeemInvitationCodeCubit extends Cubit<RedeemInvitationCodeState> {
  final RedeemInvitationCodeUseCase useCase;

  RedeemInvitationCodeCubit(this.useCase)
    : super(RedeemInvitationCodeState.initial());

  Future<void> redeemCode({required String code}) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearResult: true));

    final result = await useCase(code: code);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (redeemResult) {
        emit(
          state.copyWith(
            isLoading: false,
            result: redeemResult,
            clearError: true,
          ),
        );
      },
    );
  }
}
