import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/usecases/get_today_prayer_times_usecase.dart';
import 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetTodayPrayerTimesUseCase getTodayPrayerTimesUseCase;

  PrayerTimesCubit(this.getTodayPrayerTimesUseCase)
    : super(PrayerTimesState.initial());

  Future<void> loadTodayPrayerTimes({required int cityId}) async {
    if (isClosed) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await getTodayPrayerTimesUseCase(cityId: cityId);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (prayerTimes) {
        emit(
          state.copyWith(
            isLoading: false,
            prayerTimes: prayerTimes,
            clearError: true,
          ),
        );
      },
    );
  }
}
