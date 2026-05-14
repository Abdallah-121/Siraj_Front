import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';

import '../../domain/usecases/add_mosque_to_favorites_usecase.dart';
import '../../domain/usecases/get_favorite_mosques_usecase.dart';
import '../../domain/usecases/remove_mosque_from_favorites_usecase.dart';
import 'mosque_favorites_state.dart';

class MosqueFavoritesCubit extends Cubit<MosqueFavoritesState> {
  final AddMosqueToFavoritesUseCase addMosqueToFavoritesUseCase;
  final RemoveMosqueFromFavoritesUseCase removeMosqueFromFavoritesUseCase;
  final GetFavoriteMosquesUseCase getFavoriteMosquesUseCase;

  MosqueFavoritesCubit({
    required this.addMosqueToFavoritesUseCase,
    required this.removeMosqueFromFavoritesUseCase,
    required this.getFavoriteMosquesUseCase,
  }) : super(MosqueFavoritesState.initial());

  Future<void> loadFavoriteMosques({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final result = await getFavoriteMosquesUseCase(
      GetFavoriteMosquesParams(pageNumber: pageNumber, pageSize: pageSize),
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
      (page) {
        final ids = page.items.map((mosque) => mosque.id).toSet();

        emit(
          state.copyWith(
            isLoading: false,
            favoriteMosques: page.items,
            favoriteIds: ids,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> toggleFavorite(int mosqueId) async {
    if (state.isActionLoading) return;

    final bool currentlyFavorite = state.isFavorite(mosqueId);

    if (currentlyFavorite) {
      await removeFromFavorites(mosqueId);
    } else {
      await addToFavorites(mosqueId);
    }
  }

  Future<void> addToFavorites(int mosqueId) async {
    emit(
      state.copyWith(
        isActionLoading: true,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final previousIds = state.favoriteIds;
    final optimisticIds = {...previousIds, mosqueId};

    emit(state.copyWith(favoriteIds: optimisticIds));

    final result = await addMosqueToFavoritesUseCase(mosqueId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isActionLoading: false,
            favoriteIds: previousIds,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            isActionLoading: false,
            favoriteIds: optimisticIds,
            successMessage: 'favorite_added',
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> removeFromFavorites(int mosqueId) async {
    emit(
      state.copyWith(
        isActionLoading: true,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final previousIds = state.favoriteIds;
    final optimisticIds = {...previousIds}..remove(mosqueId);
    final optimisticMosques = state.favoriteMosques
        .where((mosque) => mosque.id != mosqueId)
        .toList(growable: false);

    emit(
      state.copyWith(
        favoriteIds: optimisticIds,
        favoriteMosques: optimisticMosques,
      ),
    );

    final result = await removeMosqueFromFavoritesUseCase(mosqueId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isActionLoading: false,
            favoriteIds: previousIds,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            isActionLoading: false,
            favoriteIds: optimisticIds,
            favoriteMosques: optimisticMosques,
            successMessage: 'favorite_removed',
            clearError: true,
          ),
        );
      },
    );
  }

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
