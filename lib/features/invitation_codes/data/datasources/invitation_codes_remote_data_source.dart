import 'package:seraj/features/invitation_codes/data/model/invitation_code_entity_model.dart';
import 'package:seraj/features/invitation_codes/data/model/redeem_invitation_result_model.dart';

abstract class InvitationCodesRemoteDataSource {
  Future<InvitationCodeModel> createMosqueManagerInvitationCode({
    required int mosqueId,
    required int expiresInDays,
    required String notes,
  });

  Future<RedeemInvitationResultModel> redeemInvitationCode({
    required String code,
  });
}
