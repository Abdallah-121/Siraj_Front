import '../../domain/entities/category_entity.dart';

enum CategoryActionType { created, updated, deleted }

class CategoriesState {
  final bool isLoading;
  final bool isSubmitting;
  final List<CategoryEntity> categories;
  final String? errorMessage;
  final CategoryActionType? actionSuccess;

  const CategoriesState({
    required this.isLoading,
    required this.isSubmitting,
    required this.categories,
    required this.errorMessage,
    required this.actionSuccess,
  });

  factory CategoriesState.initial() {
    return const CategoriesState(
      isLoading: false,
      isSubmitting: false,
      categories: [],
      errorMessage: null,
      actionSuccess: null,
    );
  }

  CategoriesState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    List<CategoryEntity>? categories,
    String? errorMessage,
    CategoryActionType? actionSuccess,
    bool clearError = false,
    bool clearActionSuccess = false,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      categories: categories ?? this.categories,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      actionSuccess: clearActionSuccess
          ? null
          : actionSuccess ?? this.actionSuccess,
    );
  }
}
