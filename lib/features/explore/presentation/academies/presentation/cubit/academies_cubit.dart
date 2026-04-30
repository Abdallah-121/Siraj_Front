import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';
import 'package:seraj/features/explore/presentation/academies/domain/usecases/get_academies_usecase.dart.dart';

import 'academies_state.dart';

class AcademiesCubit extends Cubit<AcademiesState> {
  final GetAcademiesUseCase getAcademiesUseCase;

  AcademiesCubit(this.getAcademiesUseCase) : super(AcademiesState.initial());

  Future<void> loadAcademies({
    int pageNumber = 1,
    int pageSize = 20,
    String? search,
  }) async {
    emit(
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

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (academiesPage) {
        final List<AcademyEntity> activeAcademies = academiesPage.items
            .where((academy) => academy.isActive)
            .toList();

        emit(
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
}
