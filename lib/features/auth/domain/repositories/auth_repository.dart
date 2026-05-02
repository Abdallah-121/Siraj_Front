import 'package:dartz/dartz.dart';
import 'package:seraj/features/auth/domain/usecases/register_usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_session_entity.dart';
import '../usecases/login_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSessionEntity>> login(LoginParams params);
  Future<Either<Failure, AuthSessionEntity>> register(RegisterParams params);

  Future<void> saveSession(AuthSessionEntity session);
  Future<AuthSessionEntity?> getSavedSession();
  Future<void> clearSession();
  Future<String?> getToken();
}
