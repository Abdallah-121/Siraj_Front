import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/usecases/get_cities_usecase.dart';
import 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  final GetCitiesUseCase getCitiesUseCase;

  CitiesCubit(this.getCitiesUseCase) : super(CitiesState.initial());

  Future<void> loadCities({
    int pageNumber = 1,
    int pageSize = 50,
    String? search,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        searchQuery: search ?? '',
        clearError: true,
      ),
    );

    final result = await getCitiesUseCase(
      GetCitiesParams(
        pageNumber: pageNumber,
        pageSize: pageSize,
        search: search,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (citiesPage) {
        final List<CityEntity> activeCities = citiesPage.items
            .where((city) => city.isActive)
            .toList();

        emit(
          state.copyWith(
            isLoading: false,
            cities: activeCities,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> searchCities(String query) async {
    await loadCities(pageNumber: 1, pageSize: 50, search: query);
  }
}
