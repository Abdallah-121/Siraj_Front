import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/prayer_times_entity.dart';
import '../../domain/repositories/prayer_times_repository.dart';
import '../datasources/prayer_times_remote_data_source.dart';

class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  final PrayerTimesRemoteDataSource remoteDataSource;

  PrayerTimesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PrayerTimesEntity>> getTodayPrayerTimes({
    required int cityId,
  }) async {
    try {
      final result = await remoteDataSource.getTodayPrayerTimes(cityId: cityId);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
