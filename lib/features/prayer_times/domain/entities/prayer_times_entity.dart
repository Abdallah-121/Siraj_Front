class PrayerTimesEntity {
  final int cityId;
  final String cityName;
  final DateTime prayerDate;
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String nextPrayerName;
  final String nextPrayerTime;

  const PrayerTimesEntity({
    required this.cityId,
    required this.cityName,
    required this.prayerDate,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.nextPrayerName,
    required this.nextPrayerTime,
  });
}
