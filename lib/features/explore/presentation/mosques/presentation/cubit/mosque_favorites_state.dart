import '../../domain/entites/mosque_entity.dart';

class MosqueFavoritesState {
  final bool isLoading;
  final bool isActionLoading;
  final Set<int> favoriteIds;
  final List<MosqueEntity> favoriteMosques;
  final String? errorMessage;
  final String? successMessage;

  const MosqueFavoritesState({
    required this.isLoading,
    required this.isActionLoading,
    required this.favoriteIds,
    required this.favoriteMosques,
    required this.errorMessage,
    required this.successMessage,
  });

  factory MosqueFavoritesState.initial() {
    return const MosqueFavoritesState(
      isLoading: false,
      isActionLoading: false,
      favoriteIds: {},
      favoriteMosques: [],
      errorMessage: null,
      successMessage: null,
    );
  }

  bool isFavorite(int mosqueId) {
    return favoriteIds.contains(mosqueId);
  }

  MosqueFavoritesState copyWith({
    bool? isLoading,
    bool? isActionLoading,
    Set<int>? favoriteIds,
    List<MosqueEntity>? favoriteMosques,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return MosqueFavoritesState(
      isLoading: isLoading ?? this.isLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      favoriteMosques: favoriteMosques ?? this.favoriteMosques,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      successMessage: clearSuccess
          ? null
          : successMessage ?? this.successMessage,
    );
  }
}
