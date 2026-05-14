class RedeemInvitationCodeRequestModel {
  final String code;

  const RedeemInvitationCodeRequestModel({required this.code});

  Map<String, dynamic> toJson() {
    return {'code': code};
  }
}
