import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_by_location_usecase.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';

import 'academies_state.dart';

class AcademiesCubit extends Cubit<AcademiesState> {
  final GetAcademiesUseCase getAcademiesUseCase;
  final GetAcademiesByLocationUseCase getAcademiesByLocationUseCase;

  AcademiesCubit({
    required this.getAcademiesUseCase,
    required this.getAcademiesByLocationUseCase,
  }) : super(AcademiesState.initial());

  void _safeEmit(AcademiesState newState) {
    if (!isClosed) emit(newState);
  }

  Future<void> loadAcademies({
    int pageNumber = 1,
    int pageSize = 20,
    String? search,
  }) async {
    _safeEmit(
      state.copyWith(
        isLoading: true,
        searchQuery: search ?? '',
        clearError: true,
      ),
    );

    final result = await getAcademiesUseCase(
      GetAcademiesParams(
        pageNumber: pageNumber,
        pageSize: pageSize,
        search: search,
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
      (page) {
        final activeAcademies = page.items
            .where((academy) => academy.isActive)
            .toList(growable: false);

        _safeEmit(
          state.copyWith(
            isLoading: false,
            academies: activeAcademies,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> loadAcademiesByLocation({
    int? regionId,
    int? cityId,
    int? excludeRegionId,
    bool? isActive = true,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    _safeEmit(state.copyWith(isLoading: true, clearError: true));

    final result = await getAcademiesByLocationUseCase(
      GetAcademiesByLocationParams(
        regionId: regionId,
        cityId: cityId,
        excludeRegionId: excludeRegionId,
        isActive: isActive,
        pageNumber: pageNumber,
        pageSize: pageSize,
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
      (page) {
        final activeAcademies = page.items
            .where((academy) => academy.isActive)
            .toList(growable: false);

        _safeEmit(
          state.copyWith(
            isLoading: false,
            academies: activeAcademies,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> searchAcademies(String query) async {
    await loadAcademies(pageNumber: 1, pageSize: 20, search: query);
  }

  void replaceAcademy(AcademyEntity academy) {
    final updated = state.academies
        .map((item) {
          return item.id == academy.id ? academy : item;
        })
        .toList(growable: false);

    _safeEmit(state.copyWith(academies: updated));
  }

  void removeAcademy(int academyId) {
    final updated = state.academies
        .where((item) => item.id != academyId)
        .toList(growable: false);

    _safeEmit(state.copyWith(academies: updated));
  }
}
