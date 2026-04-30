class RegisterRequestModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final int cityId;
  final String phone;
  final String description;
  final DateTime? birthDate;

  const RegisterRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.cityId,
    required this.phone,
    required this.description,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'cityId': cityId,
      'phone': phone,
      'description': description,
      'birthDate': birthDate?.toUtc().toIso8601String(),
    };
  }
}
