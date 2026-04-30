class AuthUserEntity {
  final String userId;
  final String fullName;
  final String email;
  final int roleId;
  final String roleName;

  const AuthUserEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.roleId,
    required this.roleName,
  });
}
