import '../../domain/entites/academy_entity.dart';

class AcademyCategoryModel extends AcademyCategoryEntity {
  const AcademyCategoryModel({
    required super.categoryId,
    required super.categoryName,
  });

  factory AcademyCategoryModel.fromJson(Map<String, dynamic> json) {
    return AcademyCategoryModel(
      categoryId: json['categoryId'] as int? ?? 0,
      categoryName: json['categoryName'] as String? ?? '',
    );
  }
}

class AcademyModel extends AcademyEntity {
  const AcademyModel({
    required super.id,
    required super.platformName,
    required super.regionId,
    required super.regionName,
    required super.cityId,
    required super.cityName,
    required super.name,
    required super.specialization,
    required super.description,
    required super.address,
    required super.isActive,
    required super.isRegistrationOpen,
    required super.isFavorite,
    required super.createdAt,
    required super.phoneNumber,
    required super.imageUrl,
    required super.categories,
  });

  factory AcademyModel.fromJson(Map<String, dynamic> json) {
    final rawCategories = json['categories'];

    return AcademyModel(
      id: json['id'] as int? ?? json['academyId'] as int? ?? 0,
      platformName: json['platformUrl'] as String? ?? '',
      regionId: json['regionId'] as int? ?? 0,
      regionName: json['regionName'] as String? ?? '',
      cityId: json['cityId'] as int?,
      cityName: json['cityName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      specialization: json['specialization'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
      isRegistrationOpen: json['isRegistrationOpen'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      phoneNumber: json['phoneNumber'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      categories: rawCategories is List
          ? rawCategories
                .whereType<Map<String, dynamic>>()
                .map(AcademyCategoryModel.fromJson)
                .toList(growable: false)
          : const [],
    );
  }
}
