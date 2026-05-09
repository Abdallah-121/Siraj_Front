import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';

import '../../domain/usecases/get_mosques_by_lesson_category_usecase.dart';
import '../../domain/usecases/get_mosques_usecase.dart';
import 'mosques_state.dart';

class MosquesCubit extends Cubit<MosquesState> {
  final GetMosquesUseCase getMosquesUseCase;
  final GetMosquesByLessonCategoryUseCase getMosquesByLessonCategoryUseCase;

  MosquesCubit({
    required this.getMosquesUseCase,
    required this.getMosquesByLessonCategoryUseCase,
  }) : super(MosquesState.initial());

  void _safeEmit(MosquesState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  Future<void> loadMosques({
    int pageNumber = 1,
    int pageSize = 20,
    String? search,
    int? regionId,
    int? cityId,
    bool? isActive,
  }) async {
    _safeEmit(
      state.copyWith(
        isLoading: true,
        searchQuery: search ?? '',
        clearError: true,
      ),
    );

    final result = await getMosquesUseCase(
      GetMosquesParams(
        pageNumber: pageNumber,
        pageSize: pageSize,
        search: search,
        regionId: regionId,
        cityId: cityId,
        isActive: isActive,
      ),
    );

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
      (mosquesPage) {
        final List<MosqueEntity> activeMosques = mosquesPage.items
            .where((mosque) => mosque.isActive)
            .toList();

        _safeEmit(
          state.copyWith(
            isLoading: false,
            mosques: activeMosques,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> loadMosquesByLessonCategory({
    required int categoryId,
    int? cityId,
    int? regionId,
    bool? isActive = true,
  }) async {
    _safeEmit(state.copyWith(isLoading: true, clearError: true));

    final result = await getMosquesByLessonCategoryUseCase(
      GetMosquesByLessonCategoryParams(
        categoryId: categoryId,
        cityId: cityId,
        regionId: regionId,
        isActive: isActive,
      ),
    );

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
      (mosques) {
        _safeEmit(
          state.copyWith(
            isLoading: false,
            mosques: mosques.where((mosque) => mosque.isActive).toList(),
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> searchMosques(String query, {int? regionId, int? cityId}) async {
    await loadMosques(
      pageNumber: 1,
      pageSize: 20,
      search: query,
      regionId: regionId,
      cityId: cityId,
    );
  }
}
