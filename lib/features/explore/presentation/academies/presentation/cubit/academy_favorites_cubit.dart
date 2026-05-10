import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/academy_favorites_usecases.dart';

import 'academy_favorites_state.dart';

class AcademyFavoritesCubit extends Cubit<AcademyFavoritesState> {
  final AddFavoriteAcademyUseCase addFavoriteAcademyUseCase;
  final RemoveFavoriteAcademyUseCase removeFavoriteAcademyUseCase;
  final GetFavoriteAcademiesUseCase getFavoriteAcademiesUseCase;

  AcademyFavoritesCubit({
    required this.addFavoriteAcademyUseCase,
    required this.removeFavoriteAcademyUseCase,
    required this.getFavoriteAcademiesUseCase,
  }) : super(AcademyFavoritesState.initial());

  void _safeEmit(AcademyFavoritesState newState) {
    if (!isClosed) emit(newState);
  }

  Future<void> loadFavoriteAcademies() async {
    _safeEmit(state.copyWith(isLoading: true, clearError: true));

    final result = await getFavoriteAcademiesUseCase();

    if (isClosed) return;

    result.fold(
      (failure) {
        _safeEmit(
          state.copyWith(
            isLoading: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (page) {
        _safeEmit(
          state.copyWith(
            isLoading: false,
            favoriteAcademyIds: page.items.map((e) => e.id).toSet(),
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> toggleFavorite(int academyId) async {
    if (state.processingAcademyIds.contains(academyId)) return;

    final wasFavorite = state.favoriteAcademyIds.contains(academyId);

    final optimisticFavorites = {...state.favoriteAcademyIds};
    if (wasFavorite) {
      optimisticFavorites.remove(academyId);
    } else {
      optimisticFavorites.add(academyId);
    }

    _safeEmit(
      state.copyWith(
        favoriteAcademyIds: optimisticFavorites,
        processingAcademyIds: {...state.processingAcademyIds, academyId},
        clearError: true,
      ),
    );

    final result = wasFavorite
        ? await removeFavoriteAcademyUseCase(academyId)
        : await addFavoriteAcademyUseCase(academyId);

    if (isClosed) return;

    result.fold(
      (failure) {
        final rollback = {...state.favoriteAcademyIds};
        if (wasFavorite) {
          rollback.add(academyId);
        } else {
          rollback.remove(academyId);
        }

        final processing = {...state.processingAcademyIds}..remove(academyId);

        _safeEmit(
          state.copyWith(
            favoriteAcademyIds: rollback,
            processingAcademyIds: processing,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        final processing = {...state.processingAcademyIds}..remove(academyId);
        _safeEmit(state.copyWith(processingAcademyIds: processing));
      },
    );
  }
}
