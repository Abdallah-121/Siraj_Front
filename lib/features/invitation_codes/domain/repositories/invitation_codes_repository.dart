import 'package:dartz/dartz.dart';
import 'package:seraj/features/invitation_codes/domain/entites/invitation_code_entity.dart';
import 'package:seraj/features/invitation_codes/domain/entites/redeem_invitation_result_entity.dart';

import '../../../../core/error/failures.dart';

abstract class InvitationCodesRepository {
  Future<Either<Failure, InvitationCodeEntity>>
  createMosqueManagerInvitationCode({
    required int mosqueId,
    required int expiresInDays,
    required String notes,
  });

  Future<Either<Failure, RedeemInvitationResultEntity>> redeemInvitationCode({
    required String code,
  });
}
