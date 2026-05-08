class UpdateProfileRequestModel {
  final int cityId;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String profileImage;
  final String description;
  final DateTime birthDate;

  const UpdateProfileRequestModel({
    required this.cityId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.profileImage,
    required this.description,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'cityId': cityId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'profileImage': profileImage,
      'description': description,
      'birthDate': birthDate.toIso8601String(),
    };
  }
}
