class AcademyCategoryEntity {
  final int categoryId;
  final String categoryName;

  const AcademyCategoryEntity({
    required this.categoryId,
    required this.categoryName,
  });
}

class AcademyEntity {
  final int id;
  final String platformName;
  final int regionId;
  final String regionName;
  final int? cityId;
  final String cityName;
  final String name;
  final String specialization;
  final String description;
  final String address;
  final bool isActive;
  final bool isRegistrationOpen;
  final bool isFavorite;
  final DateTime createdAt;
  final String phoneNumber;
  final String imageUrl;
  final List<AcademyCategoryEntity> categories;

  const AcademyEntity({
    required this.id,
    required this.platformName,
    required this.regionId,
    required this.regionName,
    required this.cityId,
    required this.cityName,
    required this.name,
    required this.specialization,
    required this.description,
    required this.address,
    required this.isActive,
    required this.isRegistrationOpen,
    required this.isFavorite,
    required this.createdAt,
    required this.phoneNumber,
    required this.imageUrl,
    required this.categories,
  });

  AcademyEntity copyWith({
    int? id,
    String? platformName,
    int? regionId,
    String? regionName,
    int? cityId,
    String? cityName,
    String? name,
    String? specialization,
    String? description,
    String? address,
    bool? isActive,
    bool? isRegistrationOpen,
    bool? isFavorite,
    DateTime? createdAt,
    String? phoneNumber,
    String? imageUrl,
    List<AcademyCategoryEntity>? categories,
  }) {
    return AcademyEntity(
      id: id ?? this.id,
      platformName: platformName ?? this.platformName,
      regionId: regionId ?? this.regionId,
      regionName: regionName ?? this.regionName,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      description: description ?? this.description,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      isRegistrationOpen: isRegistrationOpen ?? this.isRegistrationOpen,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      categories: categories ?? this.categories,
    );
  }
}
