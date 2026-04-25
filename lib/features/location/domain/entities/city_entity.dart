class CityEntity {
  final int id;
  final int countryId;
  final String name;
  final bool isActive;

  const CityEntity({
    required this.id,
    required this.countryId,
    required this.name,
    required this.isActive,
  });
}
