import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';

class MosqueModel extends MosqueEntity {
  const MosqueModel({
    required super.id,
    required super.managerUserId,
    required super.managerName,
    required super.regionId,
    required super.regionName,
    required super.cityName,
    required super.name,
    required super.imamName,
    required super.khatibName,
    required super.address,
    required super.isActive,
    required super.phoneNumber,
    required super.createdAt,
    required super.imageUrl,
  });

  factory MosqueModel.fromJson(Map<String, dynamic> json) {
    return MosqueModel(
      id: json['id'] as int? ?? json['mosqueId'] as int? ?? 0,
      managerUserId: json['managerUserId']?.toString(),
      managerName: json['managerName'] as String?,
      regionId: json['regionId'] as int? ?? 0,
      regionName: json['regionName'] as String? ?? '',
      cityName: json['cityName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imamName: json['imamName'] as String? ?? '',
      khatibName: json['khatibName'] as String? ?? '',
      address: json['address'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}
