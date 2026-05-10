class CityEntity {
  final int id;
  final int countryId;
  final String name;
  final bool isActive;
  final double? latitude;
  final double? longitude;
  final String? timeZoneId;

  const CityEntity({
    required this.id,
    required this.countryId,
    required this.name,
    required this.isActive,
    this.latitude,
    this.longitude,
    this.timeZoneId,
  });
}
