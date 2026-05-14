import 'package:dartz/dartz.dart';
import 'package:seraj/features/teachers/data/model/create_teacher_request_model.dart';
import 'package:seraj/features/teachers/data/model/promote_user_request_model.dart';
import 'package:seraj/features/teachers/domain/entites/mosque_teacher_entity.dart';
import 'package:seraj/features/teachers/domain/entites/promotion_user_entity.dart';
import 'package:seraj/features/teachers/domain/usecases/create_teacher_usecase.dart';
import 'package:seraj/features/teachers/domain/usecases/get_teachers_by_mosque_usecase.dart';
import 'package:seraj/features/teachers/domain/usecases/promote_user_to_teacher_usecase.dart';
import 'package:seraj/features/teachers/domain/usecases/search_users_for_promotion_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/teacher_promotion_repository.dart';
import '../datasources/teacher_promotion_remote_data_source.dart';

class TeacherPromotionRepositoryImpl implements TeacherPromotionRepository {
  final TeacherPromotionRemoteDataSource remoteDataSource;

  const TeacherPromotionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<PromotionUserEntity>>> searchUsersForPromotion(
    SearchUsersForPromotionParams params,
  ) async {
    try {
      final result = await remoteDataSource.searchUsersForPromotion(
        search: params.search,
        maxResults: params.maxResults,
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
  Future<Either<Failure, Unit>> promoteUserToTeacher(
    PromoteUserToTeacherParams params,
  ) async {
    try {
      await remoteDataSource.promoteUserToTeacher(
        PromoteUserRequestModel(
          userId: params.userId,
          mosqueId: params.mosqueId,
          qualification: params.qualification,
          bio: params.bio,
        ),
      );

      return const Right(unit);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> createTeacher(
    CreateTeacherParams params,
  ) async {
    try {
      await remoteDataSource.createTeacher(
        CreateTeacherRequestModel(
          mosqueId: params.mosqueId,
          email: params.email,
          password: params.password,
          firstName: params.firstName,
          lastName: params.lastName,
          qualification: params.qualification,
          bio: params.bio,
        ),
      );

      return const Right(unit);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MosqueTeacherEntity>>> getTeachersByMosque(
    GetTeachersByMosqueParams params,
  ) async {
    try {
      final result = await remoteDataSource.getTeachersByMosque(
        mosqueId: params.mosqueId,
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
}
