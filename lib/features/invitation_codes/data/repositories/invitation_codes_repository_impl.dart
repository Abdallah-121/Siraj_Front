import 'package:dartz/dartz.dart';
import 'package:seraj/features/invitation_codes/domain/entites/invitation_code_entity.dart';
import 'package:seraj/features/invitation_codes/domain/entites/redeem_invitation_result_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/invitation_codes_repository.dart';
import '../datasources/invitation_codes_remote_data_source.dart';

class InvitationCodesRepositoryImpl implements InvitationCodesRepository {
  final InvitationCodesRemoteDataSource remoteDataSource;

  InvitationCodesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, InvitationCodeEntity>>
  createMosqueManagerInvitationCode({
    required int mosqueId,
    required int expiresInDays,
    required String notes,
  }) async {
    try {
      final result = await remoteDataSource.createMosqueManagerInvitationCode(
        mosqueId: mosqueId,
        expiresInDays: expiresInDays,
        notes: notes,
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
  Future<Either<Failure, RedeemInvitationResultEntity>> redeemInvitationCode({
    required String code,
  }) async {
    try {
      final result = await remoteDataSource.redeemInvitationCode(code: code);

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
