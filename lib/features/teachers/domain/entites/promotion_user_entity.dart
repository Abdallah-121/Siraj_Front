class PromotionUserEntity {
  final String userId;
  final String fullName;
  final String email;
  final String phone;
  final int roleId;
  final String roleName;
  final bool isActive;

  const PromotionUserEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.roleId,
    required this.roleName,
    required this.isActive,
  });
}
