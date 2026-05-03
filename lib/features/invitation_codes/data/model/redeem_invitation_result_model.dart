import 'package:seraj/features/invitation_codes/domain/entites/redeem_invitation_result_entity.dart';

class RedeemInvitationResultModel extends RedeemInvitationResultEntity {
  const RedeemInvitationResultModel({
    required super.userId,
    required super.mosqueId,
    required super.roleId,
    required super.roleName,
    required super.message,
  });

  factory RedeemInvitationResultModel.fromJson(Map<String, dynamic> json) {
    return RedeemInvitationResultModel(
      userId: json['userId'] as String? ?? '',
      mosqueId: json['mosqueId'] as int? ?? 0,
      roleId: json['roleId'] as int? ?? 0,
      roleName: json['roleName'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }
}
