import '../../domain/entities/city_entity.dart';

class CitiesState {
  final bool isLoading;
  final List<CityEntity> cities;
  final String? errorMessage;
  final String searchQuery;

  const CitiesState({
    required this.isLoading,
    required this.cities,
    required this.errorMessage,
    required this.searchQuery,
  });

  factory CitiesState.initial() {
    return const CitiesState(
      isLoading: false,
      cities: [],
      errorMessage: null,
      searchQuery: '',
    );
  }

  CitiesState copyWith({
    bool? isLoading,
    List<CityEntity>? cities,
    String? errorMessage,
    String? searchQuery,
    bool clearError = false,
  }) {
    return CitiesState(
      isLoading: isLoading ?? this.isLoading,
      cities: cities ?? this.cities,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
