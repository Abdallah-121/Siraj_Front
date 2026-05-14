class CreateMosqueManagerInvitationRequestModel {
  final int mosqueId;
  final int expiresInDays;
  final String notes;

  const CreateMosqueManagerInvitationRequestModel({
    required this.mosqueId,
    required this.expiresInDays,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'mosqueId': mosqueId,
      'expiresInDays': expiresInDays,
      'notes': notes,
    };
  }
}
