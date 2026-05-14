import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth_session_entity.dart';
import '../../domain/usecases/clear_auth_session_usecase.dart';
import '../../domain/usecases/get_auth_session_usecase.dart';
import '../../domain/usecases/save_auth_session_usecase.dart';
import 'auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  final SaveAuthSessionUseCase saveAuthSessionUseCase;
  final GetAuthSessionUseCase getAuthSessionUseCase;
  final ClearAuthSessionUseCase clearAuthSessionUseCase;

  AuthSessionCubit({
    required this.saveAuthSessionUseCase,
    required this.getAuthSessionUseCase,
    required this.clearAuthSessionUseCase,
  }) : super(AuthSessionState.initial());

  Future<void> restoreSession() async {
    emit(state.copyWith(isLoading: true));

    final session = await getAuthSessionUseCase();

    emit(state.copyWith(isLoading: false, session: session));
  }

  Future<void> setSession(AuthSessionEntity session) async {
    await saveAuthSessionUseCase(session);

    emit(state.copyWith(isLoading: false, session: session));
  }

  Future<void> logout() async {
    await clearAuthSessionUseCase();

    emit(state.copyWith(isLoading: false, clearSession: true));
  }
}
