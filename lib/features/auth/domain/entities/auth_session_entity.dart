class AuthSessionEntity {
  final String userId;
  final String fullName;
  final String email;
  final int roleId;
  final String roleName;
  final String token;
  final int? teacherId;

  const AuthSessionEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.roleId,
    required this.roleName,
    required this.token,
    this.teacherId,
  });
}
