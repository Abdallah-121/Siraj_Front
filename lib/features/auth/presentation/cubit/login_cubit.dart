import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/auth/domain/usecases/login_usecase.dart';

import '../../../../../core/error/error_mapper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginState.initial());

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await loginUseCase(
      LoginParams(identifier: identifier, password: password),
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
