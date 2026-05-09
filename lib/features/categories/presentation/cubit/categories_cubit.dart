import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/usecases/create_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.createCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(CategoriesState.initial());

  void _safeEmit(CategoriesState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  Future<void> loadCategories({
    int pageNumber = 1,
    int pageSize = 50,
    String? search,
  }) async {
    _safeEmit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        clearActionSuccess: true,
      ),
    );

    final result = await getCategoriesUseCase(
      GetCategoriesParams(
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
        final activeCategories = page.items
            .where((category) => category.isActive)
            .toList(growable: false);

        _safeEmit(
          state.copyWith(
            isLoading: false,
            categories: activeCategories,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> createCategory(String name) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return;

    _safeEmit(
      state.copyWith(
        isSubmitting: true,
        clearError: true,
        clearActionSuccess: true,
      ),
    );

    final result = await createCategoryUseCase(
      CreateCategoryParams(name: trimmedName),
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (category) {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            categories: [category, ...state.categories],
            actionSuccess: CategoryActionType.created,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> updateCategory({required int id, required String name}) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return;

    _safeEmit(
      state.copyWith(
        isSubmitting: true,
        clearError: true,
        clearActionSuccess: true,
      ),
    );

    final result = await updateCategoryUseCase(
      UpdateCategoryParams(id: id, name: trimmedName),
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (updatedCategory) {
        final updatedList = state.categories
            .map(
              (category) => category.id == updatedCategory.id
                  ? updatedCategory
                  : category,
            )
            .where((category) => category.isActive)
            .toList(growable: false);

        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            categories: updatedList,
            actionSuccess: CategoryActionType.updated,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> deleteCategory(int id) async {
    _safeEmit(
      state.copyWith(
        isSubmitting: true,
        clearError: true,
        clearActionSuccess: true,
      ),
    );

    final result = await deleteCategoryUseCase(id);

    if (isClosed) return;

    result.fold(
      (failure) {
        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: ErrorMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        final updatedList = state.categories
            .where((category) => category.id != id)
            .toList(growable: false);

        _safeEmit(
          state.copyWith(
            isSubmitting: false,
            categories: updatedList,
            actionSuccess: CategoryActionType.deleted,
            clearError: true,
          ),
        );
      },
    );
  }

  void clearMessages() {
    _safeEmit(state.copyWith(clearError: true, clearActionSuccess: true));
  }
}
