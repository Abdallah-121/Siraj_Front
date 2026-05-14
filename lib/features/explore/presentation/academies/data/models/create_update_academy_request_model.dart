class CreateUpdateAcademyRequestModel {
  final String platformUrl;
  final int regionId;
  final String name;
  final String specialization;
  final String description;
  final bool isRegistrationOpen;
  final String phoneNumber;
  final List<int> categoryIds;

  const CreateUpdateAcademyRequestModel({
    required this.platformUrl,
    required this.regionId,
    required this.name,
    required this.specialization,
    required this.description,
    required this.isRegistrationOpen,
    required this.phoneNumber,
    required this.categoryIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'platformUrl': platformUrl,
      'regionId': regionId,
      'name': name,
      'specialization': specialization,
      'description': description,
      'isRegistrationOpen': isRegistrationOpen,
      'phoneNumber': phoneNumber,
      'categoryIds': categoryIds,
    };
  }
}
