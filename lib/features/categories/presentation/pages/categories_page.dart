import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../app/widgets/app_page_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/category_entity.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  Future<void> _showCategoryDialog({
    required BuildContext context,
    CategoryEntity? category,
  }) async {
    final controller = TextEditingController(text: category?.name ?? '');

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            category == null
                ? context.l10n.addCategory
                : context.l10n.editCategory,
          ),
          content: AppTextField(
            controller: controller,
            label: context.l10n.categoryName,
            hintText: context.l10n.enterCategoryName,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.l10n.no),
            ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          final name = controller.text.trim();

                          if (name.isEmpty) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.l10n.pleaseFillRequiredFields,
                                  ),
                                ),
                              );
                            return;
                          }

                          if (category == null) {
                            context.read<CategoriesCubit>().createCategory(
                              name,
                            );
                          } else {
                            context.read<CategoriesCubit>().updateCategory(
                              id: category.id,
                              name: name,
                            );
                          }

                          Navigator.pop(dialogContext);
                        },
                  child: Text(context.l10n.yes),
                );
              },
            ),
          ],
        );
      },
    );

    controller.dispose();
  }

  Future<void> _confirmDelete({
    required BuildContext context,
    required CategoryEntity category,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(context.l10n.deleteCategory),
          content: Text(context.l10n.deleteCategoryConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.l10n.no),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(context.l10n.yes),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      context.read<CategoriesCubit>().deleteCategory(category.id);
    }
  }

  String _successMessage(BuildContext context, CategoryActionType type) {
    switch (type) {
      case CategoryActionType.created:
        return context.l10n.categoryCreatedSuccessfully;
      case CategoryActionType.updated:
        return context.l10n.categoryUpdatedSuccessfully;
      case CategoryActionType.deleted:
        return context.l10n.categoryDeletedSuccessfully;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoriesCubit>()..loadCategories(),
      child: AppScaffold(
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showCategoryDialog(context: context);
          },
          child: const Icon(Icons.add_rounded),
        ),
        body: Column(
          children: [
            AppPageHeader(
              onBackPressed: () => Navigator.pop(context),
              bottomPadding: AppSpacing.xl,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  context.l10n.categories,
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            AppGap.v16,
            Expanded(
              child: BlocConsumer<CategoriesCubit, CategoriesState>(
                listenWhen: (previous, current) {
                  return previous.errorMessage != current.errorMessage ||
                      previous.actionSuccess != current.actionSuccess;
                },
                listener: (context, state) {
                  final error = state.errorMessage;

                  if (error != null && error.trim().isNotEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(error)));

                    context.read<CategoriesCubit>().clearMessages();
                    return;
                  }

                  final success = state.actionSuccess;

                  if (success != null) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(_successMessage(context, success)),
                        ),
                      );

                    context.read<CategoriesCubit>().clearMessages();
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.errorMessage != null && state.categories.isEmpty) {
                    return _CategoriesErrorState(
                      message: state.errorMessage!,
                      onRetry: () {
                        context.read<CategoriesCubit>().loadCategories();
                      },
                    );
                  }

                  if (state.categories.isEmpty) {
                    return _CategoriesEmptyState(
                      message: context.l10n.noCategoriesFound,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () {
                      return context.read<CategoriesCubit>().loadCategories();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        0,
                        AppSpacing.lg,
                        AppSpacing.xl,
                      ),
                      itemCount: state.categories.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final category = state.categories[index];

                        return _CategoryCard(
                          category: category,
                          onEditPressed: () {
                            _showCategoryDialog(
                              context: context,
                              category: category,
                            );
                          },
                          onDeletePressed: () {
                            _confirmDelete(
                              context: context,
                              category: category,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const _CategoryCard({
    required this.category,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Icon(Icons.category_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit_rounded),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CategoriesErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: context.l10n.retry, onPressed: onRetry),
        ],
      ),
    );
  }
}

class _CategoriesEmptyState extends StatelessWidget {
  final String message;

  const _CategoriesEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
