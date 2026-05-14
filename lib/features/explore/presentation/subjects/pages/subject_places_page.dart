import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/core/widgets/app_search_field.dart';
import 'package:seraj/features/categories/domain/entities/category_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosque_favorites_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosque_favorites_state.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/cubit/mosques_state.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_listing_page_layout.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/context_extensions.dart';

class SubjectPlacesPage extends StatefulWidget {
  const SubjectPlacesPage({super.key});

  @override
  State<SubjectPlacesPage> createState() => _SubjectPlacesPageState();
}

class _SubjectPlacesPageState extends State<SubjectPlacesPage> {
  MainNavItem _currentItem = MainNavItem.home;
  bool _isFilterExpanded = false;
  String _selectedFilter = '';
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  List<String> get _filterItems => [
    context.l10n.area,
    context.l10n.sheikh,
    context.l10n.quran,
    context.l10n.shariaSciences,
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onSearchPressed() {
    _searchFocusNode.requestFocus();
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

  void _onPlacePressed(MosqueEntity mosque) {
    Navigator.pushNamed(context, RouteNames.mosqueDetail, arguments: mosque);
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;

    final CategoryEntity? category = args is CategoryEntity ? args : null;

    final String subjectName = switch (args) {
      CategoryEntity value => value.name,
      String value when value.isNotEmpty => value,
      _ => context.l10n.subjectPlacesTitle,
    };

    final String pageText = context.l10n.placesTeachingSubject(subjectName);

    final String filterLabel = _selectedFilter.isEmpty
        ? context.l10n.area
        : _selectedFilter;

    if (category == null) {
      return ExploreListingPageLayout(
        trailingIcon: null,
        titleText: pageText,
        filterDescription: context.l10n.showResultsBy,
        filterLabel: filterLabel,
        filterItems: _filterItems,
        isFilterExpanded: _isFilterExpanded,
        showSearchBar: false,
        showFilter: true,
        compactHeader: true,
        onBackPressed: _onBackPressed,
        onSearchPressed: _onSearchPressed,
        onFilterPressed: _toggleFilter,
        onFilterSelected: _onFilterSelected,
        currentNavItem: _currentItem,
        onNavItemSelected: _onBottomNavItemSelected,
        content: _SubjectPlacesEmptyFallback(
          message: context.l10n.noMosquesFound,
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              sl<MosquesCubit>()
                ..loadMosquesByLessonCategory(categoryId: category.id),
        ),
        BlocProvider(
          create: (_) => sl<MosqueFavoritesCubit>()..loadFavoriteMosques(),
        ),
      ],
      child: ExploreListingPageLayout(
        trailingIcon: null,
        titleText: pageText,
        filterDescription: context.l10n.showResultsBy,
        filterLabel: filterLabel,
        filterItems: _filterItems,
        isFilterExpanded: _isFilterExpanded,
        showSearchBar: false,
        showFilter: true,
        compactHeader: true,
        onBackPressed: _onBackPressed,
        onSearchPressed: _onSearchPressed,
        onFilterPressed: _toggleFilter,
        onFilterSelected: _onFilterSelected,
        currentNavItem: _currentItem,
        onNavItemSelected: _onBottomNavItemSelected,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSearchField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              hintText: context.l10n.searchPlaceholderTitle,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.lg),
            BlocBuilder<MosquesCubit, MosquesState>(
              builder: (context, mosquesState) {
                if (mosquesState.isLoading) {
                  return const _SubjectPlacesLoadingState();
                }

                if (mosquesState.errorMessage != null) {
                  return _SubjectPlacesErrorState(
                    message: mosquesState.errorMessage!,
                    onRetry: () {
                      context.read<MosquesCubit>().loadMosquesByLessonCategory(
                        categoryId: category.id,
                      );
                    },
                  );
                }

                final query = _searchController.text.trim().toLowerCase();

                final mosques = query.isEmpty
                    ? mosquesState.mosques
                    : mosquesState.mosques
                          .where((mosque) {
                            return mosque.name.toLowerCase().contains(query) ||
                                mosque.cityName.toLowerCase().contains(query) ||
                                mosque.khatibName.toLowerCase().contains(
                                  query,
                                ) ||
                                mosque.imamName.toLowerCase().contains(query);
                          })
                          .toList(growable: false);

                if (mosques.isEmpty) {
                  return _SubjectPlacesEmptyFallback(
                    message: context.l10n.noMosquesFound,
                  );
                }

                return BlocBuilder<MosqueFavoritesCubit, MosqueFavoritesState>(
                  builder: (context, favoritesState) {
                    return ListView.separated(
                      itemCount: mosques.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        final mosque = mosques[index];

                        return PlaceListItem(
                          title: mosque.name,
                          preacherName: mosque.khatibName.isNotEmpty
                              ? mosque.khatibName
                              : context.l10n.unknown,
                          imamName: mosque.imamName.isNotEmpty
                              ? mosque.imamName
                              : context.l10n.unknown,
                          studyType: mosque.cityName.isNotEmpty
                              ? mosque.cityName
                              : context.l10n.unknown,
                          imageLabel: subjectName,
                          imageUrl: mosque.imageUrl,
                          isFavorite: favoritesState.isFavorite(mosque.id),
                          onTap: () => _onPlacePressed(mosque),
                          onFavoritePressed: () {
                            context.read<MosqueFavoritesCubit>().toggleFavorite(
                              mosque.id,
                            );
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
    );
  }
}

class _SubjectPlacesLoadingState extends StatelessWidget {
  const _SubjectPlacesLoadingState();

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

class _SubjectPlacesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _SubjectPlacesErrorState({
    required this.message,
    required this.onRetry,
  });

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
          TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
        ],
      ),
    );
  }
}

class _SubjectPlacesEmptyFallback extends StatelessWidget {
  final String message;

  const _SubjectPlacesEmptyFallback({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
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
