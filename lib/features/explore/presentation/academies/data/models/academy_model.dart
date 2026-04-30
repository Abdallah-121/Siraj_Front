import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';

class AcademyModel extends AcademyEntity {
  const AcademyModel({
    required super.id,
    required super.platformName,
    required super.regionId,
    required super.name,
    required super.specialization,
    required super.description,
    required super.isActive,
    required super.isRegistrationOpen,
    required super.createdAt,
    required super.phoneNumber,
  });

  factory AcademyModel.fromJson(Map<String, dynamic> json) {
    return AcademyModel(
      id: json['id'] as int,
      platformName: json['platformName'] as String? ?? '',
      regionId: json['regionId'] as int,
      name: json['name'] as String? ?? '',
      specialization: json['specialization'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
      isRegistrationOpen: json['isRegistrationOpen'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      phoneNumber: json['phoneNumber'] as String? ?? '',
    );
  }
}
