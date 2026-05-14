class PromoteUserRequestModel {
  final String userId;
  final int mosqueId;
  final String qualification;
  final String bio;

  const PromoteUserRequestModel({
    required this.userId,
    required this.mosqueId,
    required this.qualification,
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'mosqueId': mosqueId,
      'qualification': qualification,
      'bio': bio,
    };
  }
}
