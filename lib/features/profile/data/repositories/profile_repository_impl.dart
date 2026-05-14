import 'package:dartz/dartz.dart';
import 'package:seraj/features/profile/data/model/update_profile_request_model.dart';
import 'package:seraj/features/profile/domain/usecase/update_profile_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth_session_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthSessionEntity>> updateProfile(
    UpdateProfileParams params,
  ) async {
    try {
      final result = await remoteDataSource.updateProfile(
        userId: params.userId,
        token: params.token,
        roleId: params.roleId,
        roleName: params.roleName,
        teacherId: params.teacherId,
        request: UpdateProfileRequestModel(
          cityId: params.cityId,
          email: params.email,
          firstName: params.firstName,
          lastName: params.lastName,
          phone: params.phone,
          profileImage: params.profileImage,
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
}
