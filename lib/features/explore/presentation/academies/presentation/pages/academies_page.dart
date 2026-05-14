import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/app/widgets/main_bottom_nav_bar.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/theme/app_radius.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/core/widgets/app_scaffold.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academies_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academies_state.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academy_favorites_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academy_favorites_state.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_filter_dropdown.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_search_bar.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_title_filter_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

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

  void _toggleFilter() {
    setState(() => _isFilterExpanded = !_isFilterExpanded);
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
      case MainNavItem.search:
        Navigator.pushReplacementNamed(context, RouteNames.search);
        break;
      case MainNavItem.settings:
        Navigator.pushReplacementNamed(context, RouteNames.settings);
        break;
      case MainNavItem.profile:
        Navigator.pushReplacementNamed(context, RouteNames.profile);
        break;
      default:
        setState(() => _currentItem = item);
        break;
    }
  }

  Future<void> _onAcademyPressed({
    required BuildContext context,
    required AcademyEntity academy,
  }) async {
    final result = await Navigator.pushNamed(
      context,
      RouteNames.academyDetail,
      arguments: academy,
    );

    if (result == true && context.mounted) {
      context.read<AcademiesCubit>().loadAcademies();
      context.read<AcademyFavoritesCubit>().loadFavoriteAcademies();
    }
  }

  Future<void> _onCreateAcademyPressed(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      RouteNames.createEditAcademy,
    );

    if (result != null && context.mounted) {
      context.read<AcademiesCubit>().loadAcademies();
      context.read<AcademyFavoritesCubit>().loadFavoriteAcademies();
    }
  }

  bool _isAdmin(BuildContext context) {
    final session = context.watch<AuthSessionCubit>().state.session;
    return session?.roleName.trim().toLowerCase() == 'admin';
  }

  @override
  Widget build(BuildContext context) {
    final filterLabel = _selectedFilter.isEmpty
        ? context.l10n.area
        : _selectedFilter;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AcademiesCubit>()..loadAcademies()),
        BlocProvider(
          create: (_) => sl<AcademyFavoritesCubit>()..loadFavoriteAcademies(),
        ),
      ],
      child: Builder(
        builder: (providerContext) {
          final bool isAdmin = _isAdmin(providerContext);

          void onSearchPressed() {
            showSearch(
              context: providerContext,
              delegate: _ExploreSearchDelegate(
                onQueryChanged: (query) {
                  providerContext.read<AcademiesCubit>().searchAcademies(query);
                },
              ),
            );
          }

          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            bottomNavigationBar: MainBottomNavBar(
              currentItem: _currentItem,
              onItemSelected: _onBottomNavItemSelected,
            ),
            floatingActionButton: isAdmin
                ? FloatingActionButton(
                    onPressed: () => _onCreateAcademyPressed(providerContext),
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppColors.white,
                    ),
                  )
                : null,
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
                            onTap: onSearchPressed,
                          ),
                          titleIcon: const Icon(
                            Icons.school_outlined,
                            size: 34,
                          ),
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
                                  context
                                      .read<AcademiesCubit>()
                                      .loadAcademies();
                                },
                              );
                            }

                            if (state.academies.isEmpty) {
                              return _AcademiesEmptyState(
                                message: context.l10n.noAcademiesFound,
                              );
                            }

                            return BlocBuilder<
                              AcademyFavoritesCubit,
                              AcademyFavoritesState
                            >(
                              builder: (context, favoritesState) {
                                return ListView.separated(
                                  itemCount: state.academies.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: AppSpacing.lg),
                                  itemBuilder: (context, index) {
                                    final academy = state.academies[index];

                                    return PlaceListItem(
                                      title: academy.name,
                                      preacherName:
                                          academy.specialization.isNotEmpty
                                          ? academy.specialization
                                          : context.l10n.unknown,
                                      imamName: academy.platformName.isNotEmpty
                                          ? academy.platformName
                                          : context.l10n.unknown,
                                      studyType: academy.description.isNotEmpty
                                          ? academy.description
                                          : context.l10n.unknown,
                                      imageLabel: academy.categories.isNotEmpty
                                          ? academy
                                                .categories
                                                .first
                                                .categoryName
                                          : context.l10n.academyDetails,
                                      imageUrl: academy.imageUrl,
                                      isFavorite: favoritesState.isFavorite(
                                        academy.id,
                                      ),
                                      onTap: () => _onAcademyPressed(
                                        context: context,
                                        academy: academy,
                                      ),
                                      onFavoritePressed: () {
                                        context
                                            .read<AcademyFavoritesCubit>()
                                            .toggleFavorite(academy.id);
                                      },
                                    );
                                  },
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
          );
        },
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
