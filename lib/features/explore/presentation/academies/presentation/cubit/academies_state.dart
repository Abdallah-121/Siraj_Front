import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';

class AcademiesState {
  final bool isLoading;
  final List<AcademyEntity> academies;
  final String? errorMessage;
  final String searchQuery;

  const AcademiesState({
    required this.isLoading,
    required this.academies,
    required this.errorMessage,
    required this.searchQuery,
  });

  factory AcademiesState.initial() {
    return const AcademiesState(
      isLoading: false,
      academies: [],
      errorMessage: null,
      searchQuery: '',
    );
  }

  AcademiesState copyWith({
    bool? isLoading,
    List<AcademyEntity>? academies,
    String? errorMessage,
    String? searchQuery,
    bool clearError = false,
  }) {
    return AcademiesState(
      isLoading: isLoading ?? this.isLoading,
      academies: academies ?? this.academies,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
