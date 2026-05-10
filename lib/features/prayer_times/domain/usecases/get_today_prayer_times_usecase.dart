import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/prayer_times_entity.dart';
import '../repositories/prayer_times_repository.dart';

class GetTodayPrayerTimesUseCase {
  final PrayerTimesRepository repository;

  GetTodayPrayerTimesUseCase(this.repository);

  Future<Either<Failure, PrayerTimesEntity>> call({required int cityId}) {
    return repository.getTodayPrayerTimes(cityId: cityId);
  }
}
