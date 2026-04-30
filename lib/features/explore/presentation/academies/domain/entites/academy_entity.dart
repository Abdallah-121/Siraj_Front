class AcademyEntity {
  final int id;
  final String platformName;
  final int regionId;
  final String name;
  final String specialization;
  final String description;
  final bool isActive;
  final bool isRegistrationOpen;
  final DateTime createdAt;
  final String phoneNumber;

  const AcademyEntity({
    required this.id,
    required this.platformName,
    required this.regionId,
    required this.name,
    required this.specialization,
    required this.description,
    required this.isActive,
    required this.isRegistrationOpen,
    required this.createdAt,
    required this.phoneNumber,
  });
}
