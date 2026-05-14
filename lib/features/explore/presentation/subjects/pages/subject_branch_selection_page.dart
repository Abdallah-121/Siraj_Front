import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/categories/domain/entities/category_entity.dart';
import 'package:seraj/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:seraj/features/categories/presentation/cubit/categories_state.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_header.dart';
import 'package:seraj/features/explore/presentation/subjects/widgets/subject_option_card.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/app_text_field.dart';

class SubjectBranchSelectionPage extends StatefulWidget {
  const SubjectBranchSelectionPage({super.key});

  @override
  State<SubjectBranchSelectionPage> createState() =>
      _SubjectBranchSelectionPageState();
}

class _SubjectBranchSelectionPageState
    extends State<SubjectBranchSelectionPage> {
  MainNavItem _currentItem = MainNavItem.home;

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    switch (item) {
      case MainNavItem.home:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      default:
        setState(() {
          _currentItem = item;
        });
        break;
    }
  }

  void _onBranchPressed(CategoryEntity category) {
    Navigator.pushNamed(context, RouteNames.subjectPlaces, arguments: category);
  }

  bool _isAdmin(BuildContext context) {
    final session = context.watch<AuthSessionCubit>().state.session;
    return session?.roleName.trim().toLowerCase() == 'admin';
  }

  Future<void> _showCategoryDialog({
    required BuildContext context,
    CategoryEntity? category,
  }) async {
    final categoriesCubit = context.read<CategoriesCubit>();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return BlocProvider.value(
          value: categoriesCubit,
          child: _CategoryFormDialog(category: category),
        );
      },
    );
  }

  Future<void> _confirmDelete({
    required BuildContext context,
    required CategoryEntity category,
  }) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width < 430
                  ? MediaQuery.sizeOf(context).width - 32
                  : 380,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.deleteCategory,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    context.l10n.deleteCategoryConfirmation,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext, false),
                          child: Text(context.l10n.no),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext, true),
                          child: Text(context.l10n.yes),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
      child: Builder(
        builder: (providerContext) {
          final bool isAdmin = _isAdmin(context);

          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            bottomNavigationBar: MainBottomNavBar(
              currentItem: _currentItem,
              onItemSelected: _onBottomNavItemSelected,
            ),
            floatingActionButton: isAdmin
                ? FloatingActionButton(
                    onPressed: () {
                      _showCategoryDialog(context: providerContext);
                    },
                    child: const Icon(Icons.add_rounded),
                  )
                : null,
            body: Column(
              children: [
                ExploreHeader(onBackPressed: _onBackPressed, compact: true),
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
                      return RefreshIndicator(
                        onRefresh: () {
                          return context
                              .read<CategoriesCubit>()
                              .loadCategories();
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.lg,
                            AppSpacing.md,
                            AppSpacing.lg,
                            AppSpacing.xl,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                context.l10n.subjectBranchSelectionTitle,
                                textAlign: TextAlign.end,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              if (state.isLoading)
                                const _CategoriesLoadingState()
                              else if (state.errorMessage != null &&
                                  state.categories.isEmpty)
                                _CategoriesErrorState(
                                  message: state.errorMessage!,
                                  onRetry: () {
                                    context
                                        .read<CategoriesCubit>()
                                        .loadCategories();
                                  },
                                )
                              else if (state.categories.isEmpty)
                                _CategoriesEmptyState(
                                  message: context.l10n.noCategoriesFound,
                                )
                              else
                                _CategoriesGrid(
                                  categories: state.categories,
                                  isAdmin: isAdmin,
                                  onCategoryPressed: _onBranchPressed,
                                  onEditPressed: (category) {
                                    _showCategoryDialog(
                                      context: context,
                                      category: category,
                                    );
                                  },
                                  onDeletePressed: (category) {
                                    _confirmDelete(
                                      context: context,
                                      category: category,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryFormDialog extends StatefulWidget {
  final CategoryEntity? category;

  const _CategoryFormDialog({required this.category});

  @override
  State<_CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<_CategoryFormDialog> {
  late final TextEditingController _controller;

  bool get _isEditMode => widget.category != null;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.category?.name ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(context.l10n.pleaseFillRequiredFields)),
        );
      return;
    }

    final cubit = context.read<CategoriesCubit>();

    if (_isEditMode) {
      cubit.updateCategory(id: widget.category!.id, name: name);
    } else {
      cubit.createCategory(name);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    final double dialogWidth = screenSize.width < 430
        ? screenSize.width - (AppSpacing.lg * 2)
        : 390;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          maxHeight: screenSize.height * 0.70,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditMode
                          ? context.l10n.editCategory
                          : context.l10n.addCategory,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _controller,
                label: context.l10n.categoryName,
                hintText: context.l10n.enterCategoryName,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: AppSpacing.lg),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () => Navigator.pop(context),
                          child: Text(context.l10n.no),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.isSubmitting ? null : _submit,
                          child: state.isSubmitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(context.l10n.yes),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  final List<CategoryEntity> categories;
  final bool isAdmin;
  final ValueChanged<CategoryEntity> onCategoryPressed;
  final ValueChanged<CategoryEntity> onEditPressed;
  final ValueChanged<CategoryEntity> onDeletePressed;

  const _CategoriesGrid({
    required this.categories,
    required this.isAdmin,
    required this.onCategoryPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double spacing = AppSpacing.lg;

        final int crossAxisCount = width >= 900
            ? 4
            : width >= 640
            ? 3
            : 2;

        final double itemWidth =
            (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: categories.map((category) {
            return SizedBox(
              width: itemWidth,
              child: SubjectOptionCard(
                title: category.name,
                showAdminActions: isAdmin,
                onTap: () => onCategoryPressed(category),
                onEditPressed: () => onEditPressed(category),
                onDeletePressed: () => onDeletePressed(category),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _CategoriesLoadingState extends StatelessWidget {
  const _CategoriesLoadingState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.l10n.loading,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
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
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.error),
      ),
      child: Column(
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border),
      ),
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
