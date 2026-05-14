import '../../domain/entities/prayer_times_entity.dart';

class PrayerTimesState {
  final bool isLoading;
  final PrayerTimesEntity? prayerTimes;
  final String? errorMessage;

  const PrayerTimesState({
    required this.isLoading,
    required this.prayerTimes,
    required this.errorMessage,
  });

  factory PrayerTimesState.initial() {
    return const PrayerTimesState(
      isLoading: false,
      prayerTimes: null,
      errorMessage: null,
    );
  }

  PrayerTimesState copyWith({
    bool? isLoading,
    PrayerTimesEntity? prayerTimes,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PrayerTimesState(
      isLoading: isLoading ?? this.isLoading,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
