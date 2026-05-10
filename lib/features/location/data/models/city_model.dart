import '../../domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  const CityModel({
    required super.id,
    required super.countryId,
    required super.name,
    required super.isActive,
    super.latitude,
    super.longitude,
    super.timeZoneId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      countryId: json['countryId'] as int,
      name: json['name'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
      latitude: _toDoubleOrNull(json['latitude']),
      longitude: _toDoubleOrNull(json['longitude']),
      timeZoneId: json['timeZoneId'] as String?,
    );
  }

  static double? _toDoubleOrNull(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
