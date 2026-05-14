class CreateTeacherRequestModel {
  final int mosqueId;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String qualification;
  final String bio;

  const CreateTeacherRequestModel({
    required this.mosqueId,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.qualification,
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'mosqueId': mosqueId,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'qualification': qualification,
      'bio': bio,
    };
  }
}
