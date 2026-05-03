class InvitationCodeEntity {
  final int invitationCodeId;
  final String code;
  final int mosqueId;
  final int type;
  final DateTime expiresAt;

  const InvitationCodeEntity({
    required this.invitationCodeId,
    required this.code,
    required this.mosqueId,
    required this.type,
    required this.expiresAt,
  });
}
