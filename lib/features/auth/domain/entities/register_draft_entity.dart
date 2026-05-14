class RegisterDraftEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final DateTime? birthDate;

  const RegisterDraftEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.birthDate,
  });

  RegisterDraftEntity copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    DateTime? birthDate,
  }) {
    return RegisterDraftEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
