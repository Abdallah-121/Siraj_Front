import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/error/error_mapper.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';

import '../../domain/usecases/get_mosques_usecase.dart';
import 'mosques_state.dart';

class MosquesCubit extends Cubit<MosquesState> {
  final GetMosquesUseCase getMosquesUseCase;

  MosquesCubit(this.getMosquesUseCase) : super(MosquesState.initial());

  Future<void> loadMosques({
    int pageNumber = 1,
    int pageSize = 20,
    String? search,
    int? regionId,
    int? cityId,
    bool? isActive,
  }) async {
    emit(
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

    result.fold(
      (failure) {
        emit(
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

        emit(
          state.copyWith(
            isLoading: false,
            mosques: activeMosques,
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
