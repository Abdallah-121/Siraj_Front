class AcademyFavoritesState {
  final bool isLoading;
  final Set<int> favoriteAcademyIds;
  final Set<int> processingAcademyIds;
  final String? errorMessage;

  const AcademyFavoritesState({
    required this.isLoading,
    required this.favoriteAcademyIds,
    required this.processingAcademyIds,
    required this.errorMessage,
  });

  factory AcademyFavoritesState.initial() {
    return const AcademyFavoritesState(
      isLoading: false,
      favoriteAcademyIds: {},
      processingAcademyIds: {},
      errorMessage: null,
    );
  }

  bool isFavorite(int academyId) => favoriteAcademyIds.contains(academyId);

  AcademyFavoritesState copyWith({
    bool? isLoading,
    Set<int>? favoriteAcademyIds,
    Set<int>? processingAcademyIds,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AcademyFavoritesState(
      isLoading: isLoading ?? this.isLoading,
      favoriteAcademyIds: favoriteAcademyIds ?? this.favoriteAcademyIds,
      processingAcademyIds: processingAcademyIds ?? this.processingAcademyIds,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
