import '../../domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  const CityModel({
    required super.id,
    required super.countryId,
    required super.name,
    required super.isActive,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      countryId: json['countryId'] as int,
      name: json['name'] as String,
      isActive: json['isActive'] as bool,
    );
  }
}
