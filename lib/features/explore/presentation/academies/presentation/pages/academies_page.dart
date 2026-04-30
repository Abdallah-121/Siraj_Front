import 'package:flutter/material.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/theme/app_radius.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academies_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academies_state.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_filter_dropdown.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_search_bar.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_title_filter_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

import '../../../../../../app/router/route_names.dart';
import '../../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/app_scaffold.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AcademiesPage extends StatefulWidget {
  const AcademiesPage({super.key});

  @override
  State<AcademiesPage> createState() => _AcademiesPageState();
}

class _AcademiesPageState extends State<AcademiesPage> {
  MainNavItem _currentItem = MainNavItem.home;
  bool _isFilterExpanded = false;
  String _selectedFilter = '';

  List<String> get _filterItems => [
    context.l10n.area,
    context.l10n.quran,
    context.l10n.shariaSciences,
    context.l10n.sheikh,
  ];

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onSearchPressed() {
    showSearch(
      context: context,
      delegate: _ExploreSearchDelegate(
        onQueryChanged: (query) {
          context.read<AcademiesCubit>().searchAcademies(query);
        },
      ),
    );
  }

  void _toggleFilter() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
    });
  }

  void _onFilterSelected(String value) {
    setState(() {
      _selectedFilter = value;
      _isFilterExpanded = false;
    });
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

  void _onAcademyPressed() {
    Navigator.pushNamed(context, RouteNames.academyDetail);
  }

  @override
  Widget build(BuildContext context) {
    final String filterLabel = _selectedFilter.isEmpty
        ? context.l10n.area
        : _selectedFilter;

    return BlocProvider(
      create: (_) => sl<AcademiesCubit>()..loadAcademies(),
      child: AppScaffold(
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        bottomNavigationBar: MainBottomNavBar(
          currentItem: _currentItem,
          onItemSelected: _onBottomNavItemSelected,
        ),
        body: Column(
          children: [
            ExploreHeader(onBackPressed: _onBackPressed, compact: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ExploreTitleFilterHeader(
                      leadingSearchIcon: ExploreSearchBar(
                        mode: ExploreSearchBarMode.iconOnly,
                        onTap: _onSearchPressed,
                      ),
                      titleIcon: const Icon(Icons.school_outlined, size: 34),
                      title: context.l10n.academies,
                      filterWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            context.l10n.showAcademiesBy,
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          ExploreFilterDropdown(
                            label: filterLabel,
                            items: _filterItems,
                            isExpanded: _isFilterExpanded,
                            onPressed: _toggleFilter,
                            onItemSelected: _onFilterSelected,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    BlocBuilder<AcademiesCubit, AcademiesState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const _AcademiesLoadingState();
                        }

                        if (state.errorMessage != null) {
                          return _AcademiesErrorState(
                            message: state.errorMessage!,
                            onRetry: () {
                              context.read<AcademiesCubit>().loadAcademies();
                            },
                          );
                        }

                        if (state.academies.isEmpty) {
                          return _AcademiesEmptyState(
                            message: context.l10n.noMosquesFound,
                          );
                        }

                        return ListView.separated(
                          itemCount: state.academies.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: AppSpacing.lg),
                          itemBuilder: (context, index) {
                            final AcademyEntity academy =
                                state.academies[index];

                            return PlaceListItem(
                              title: academy.name,
                              preacherName: academy.specialization.isNotEmpty
                                  ? academy.specialization
                                  : context.l10n.unknown,
                              imamName: academy.platformName.isNotEmpty
                                  ? academy.platformName
                                  : context.l10n.unknown,
                              studyType: academy.description.isNotEmpty
                                  ? academy.description
                                  : context.l10n.unknown,
                              imageLabel: academy.isRegistrationOpen
                                  ? context.l10n.freeAcademy
                                  : context.l10n.paidAcademy,
                              isFavorite: false,
                              onTap: _onAcademyPressed,
                              onFavoritePressed: () {},
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreSearchDelegate extends SearchDelegate<String> {
  final ValueChanged<String> onQueryChanged;

  _ExploreSearchDelegate({required this.onQueryChanged});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          onQueryChanged('');
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onQueryChanged(query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChanged(query);
    return const SizedBox.shrink();
  }
}

class _AcademiesLoadingState extends StatelessWidget {
  const _AcademiesLoadingState();

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

class _AcademiesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _AcademiesErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.error, width: 1),
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
        ],
      ),
    );
  }
}

class _AcademiesEmptyState extends StatelessWidget {
  final String message;

  const _AcademiesEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 1),
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
