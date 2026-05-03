class RedeemInvitationResultEntity {
  final String userId;
  final int mosqueId;
  final int roleId;
  final String roleName;
  final String message;

  const RedeemInvitationResultEntity({
    required this.userId,
    required this.mosqueId,
    required this.roleId,
    required this.roleName,
    required this.message,
  });
}
