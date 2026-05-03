class CreateMosqueRequestModel {
  final int regionId;
  final String name;
  final String imamName;
  final String khatibName;
  final String address;
  final String phoneNumber;
  final double latitude;
  final double longitude;
  final String timezone;
  final int calculationMethod;
  final int madhab;

  const CreateMosqueRequestModel({
    required this.regionId,
    required this.name,
    required this.imamName,
    required this.khatibName,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.calculationMethod,
    required this.madhab,
  });

  Map<String, dynamic> toJson() {
    return {
      'regionId': regionId,
      'name': name,
      'imamName': imamName,
      'khatibName': khatibName,
      'address': address,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'calculationMethod': calculationMethod,
      'madhab': madhab,
    };
  }
}
