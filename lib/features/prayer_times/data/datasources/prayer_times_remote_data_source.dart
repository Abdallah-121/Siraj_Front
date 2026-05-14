import 'package:seraj/features/prayer_times/data/model/prayer_times_model.dart';

abstract class PrayerTimesRemoteDataSource {
  Future<PrayerTimesModel> getTodayPrayerTimes({required int cityId});
}
