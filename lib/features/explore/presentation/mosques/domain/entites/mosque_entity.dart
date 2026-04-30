class MosqueEntity {
  final int id;
  final int? managerUserId;
  final String? managerName;
  final int regionId;
  final String regionName;
  final String cityName;
  final String name;
  final String imamName;
  final String khatibName;
  final String address;
  final bool isActive;
  final String phoneNumber;
  final DateTime createdAt;

  const MosqueEntity({
    required this.id,
    required this.managerUserId,
    required this.managerName,
    required this.regionId,
    required this.regionName,
    required this.cityName,
    required this.name,
    required this.imamName,
    required this.khatibName,
    required this.address,
    required this.isActive,
    required this.phoneNumber,
    required this.createdAt,
  });
}
