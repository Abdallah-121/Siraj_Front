import 'package:seraj/features/invitation_codes/domain/entites/invitation_code_entity.dart';

class InvitationCodeModel extends InvitationCodeEntity {
  const InvitationCodeModel({
    required super.invitationCodeId,
    required super.code,
    required super.mosqueId,
    required super.type,
    required super.expiresAt,
  });

  factory InvitationCodeModel.fromJson(Map<String, dynamic> json) {
    return InvitationCodeModel(
      invitationCodeId: json['invitationCodeId'] as int? ?? 0,
      code: json['code'] as String? ?? '',
      mosqueId: json['mosqueId'] as int? ?? 0,
      type: json['type'] as int? ?? 0,
      expiresAt:
          DateTime.tryParse(json['expiresAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
