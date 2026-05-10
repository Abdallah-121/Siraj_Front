import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit(this.changePasswordUseCase)
    : super(ChangePasswordState.initial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    if (isClosed) return;

    emit(
      state.copyWith(isSubmitting: true, clearError: true, resetSuccess: true),
    );

    final result = await changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            clearError: true,
          ),
        );
      },
    );
  }

  void clearMessages() {
    if (isClosed) return;

    emit(state.copyWith(clearError: true, resetSuccess: true));
  }
}
