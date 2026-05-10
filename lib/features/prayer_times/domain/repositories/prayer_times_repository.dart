import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/prayer_times_entity.dart';

abstract class PrayerTimesRepository {
  Future<Either<Failure, PrayerTimesEntity>> getTodayPrayerTimes({
    required int cityId,
  });
}
