import 'package:dartz/dartz.dart';
import 'package:seraj/features/invitation_codes/domain/entites/redeem_invitation_result_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/invitation_codes_repository.dart';

class RedeemInvitationCodeUseCase {
  final InvitationCodesRepository repository;

  RedeemInvitationCodeUseCase(this.repository);

  Future<Either<Failure, RedeemInvitationResultEntity>> call({
    required String code,
  }) {
    return repository.redeemInvitationCode(code: code);
  }
}
