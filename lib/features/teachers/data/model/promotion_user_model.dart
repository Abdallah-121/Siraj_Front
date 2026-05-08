import 'package:seraj/features/teachers/domain/entites/promotion_user_entity.dart';

class PromotionUserModel extends PromotionUserEntity {
  const PromotionUserModel({
    required super.userId,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.roleId,
    required super.roleName,
    required super.isActive,
  });

  factory PromotionUserModel.fromJson(Map<String, dynamic> json) {
    return PromotionUserModel(
      userId: json['userId'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      roleId: json['roleId'] as int? ?? 0,
      roleName: json['roleName'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );
  }
}
