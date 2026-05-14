import '../../domain/entities/prayer_times_entity.dart';

class PrayerTimesModel extends PrayerTimesEntity {
  const PrayerTimesModel({
    required super.cityId,
    required super.cityName,
    required super.prayerDate,
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.maghrib,
    required super.isha,
    required super.nextPrayerName,
    required super.nextPrayerTime,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimesModel(
      cityId: json['cityId'] as int? ?? 0,
      cityName: json['cityName'] as String? ?? '',
      prayerDate:
          DateTime.tryParse(json['prayerDate']?.toString() ?? '') ??
          DateTime.now(),
      fajr: json['fajr'] as String? ?? '',
      sunrise: json['sunrise'] as String? ?? '',
      dhuhr: json['dhuhr'] as String? ?? '',
      asr: json['asr'] as String? ?? '',
      maghrib: json['maghrib'] as String? ?? '',
      isha: json['isha'] as String? ?? '',
      nextPrayerName: json['nextPrayerName'] as String? ?? '',
      nextPrayerTime: json['nextPrayerTime'] as String? ?? '',
    );
  }
}
