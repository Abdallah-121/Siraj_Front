import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_session_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_session_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, AuthSessionEntity>> login(LoginParams params) async {
    try {
      final result = await remoteDataSource.login(
        LoginRequestModel(
          identifier: params.identifier,
          password: params.password,
        ),
      );

      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthSessionEntity>> register(
    RegisterParams params,
  ) async {
    try {
      final result = await remoteDataSource.register(
        RegisterRequestModel(
          email: params.email,
          password: params.password,
          firstName: params.firstName,
          lastName: params.lastName,
          cityId: params.cityId,
          phone: params.phone,
          description: params.description,
          birthDate: params.birthDate,
        ),
      );

      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<void> saveSession(AuthSessionEntity session) async {
    await localDataSource.saveSession(
      AuthSessionModel(
        userId: session.userId,
        fullName: session.fullName,
        email: session.email,
        roleId: session.roleId,
        roleName: session.roleName,
        token: session.token,
        teacherId: session.teacherId,
      ),
    );
  }

  @override
  Future<AuthSessionEntity?> getSavedSession() async {
    return localDataSource.getSession();
  }

  @override
  Future<void> clearSession() async {
    await localDataSource.clearSession();
  }

  @override
  Future<String?> getToken() async {
    return localDataSource.getToken();
  }
}
