class AuthSessionEntity {
  final String userId;
  final String fullName;
  final String email;
  final int roleId;
  final String roleName;
  final String token;
  final int? teacherId;

  final String firstName;
  final String lastName;
  final String phone;
  final String profileImage;
  final String description;
  final int? cityId;
  final DateTime? birthDate;

  const AuthSessionEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.roleId,
    required this.roleName,
    required this.token,
    this.teacherId,
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.profileImage = '',
    this.description = '',
    this.cityId,
    this.birthDate,
  });

  AuthSessionEntity copyWith({
    String? userId,
    String? fullName,
    String? email,
    int? roleId,
    String? roleName,
    String? token,
    int? teacherId,
    String? firstName,
    String? lastName,
    String? phone,
    String? profileImage,
    String? description,
    int? cityId,
    DateTime? birthDate,
  }) {
    return AuthSessionEntity(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      token: token ?? this.token,
      teacherId: teacherId ?? this.teacherId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      description: description ?? this.description,
      cityId: cityId ?? this.cityId,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
