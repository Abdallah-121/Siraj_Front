import 'package:flutter/material.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_filter_dropdown.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_search_bar.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_title_filter_header.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/new_update_badge.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

import '../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../../core/theme/app_spacing.dart';

import '../../../../../core/widgets/app_scaffold.dart';

class MosquesPage extends StatefulWidget {
  const MosquesPage({super.key});

  @override
  State<MosquesPage> createState() => _MosquesPageState();
}

class _MosquesPageState extends State<MosquesPage> {
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
    showSearch(context: context, delegate: _ExploreSearchDelegate());
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

  void _onMosquePressed() {
    Navigator.pushNamed(context, RouteNames.mosqueDetail);
  }

  @override
  Widget build(BuildContext context) {
    final String filterLabel = _selectedFilter.isEmpty
        ? context.l10n.area
        : _selectedFilter;

    return AppScaffold(
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
                    titleIcon: const Icon(Icons.mosque_outlined, size: 34),
                    title: context.l10n.mosques,
                    filterWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          context.l10n.showMosquesBy,
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
                  ListView.separated(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.lg),
                    itemBuilder: (context, index) {
                      return PlaceListItem(
                        title: context.l10n.sampleName,
                        preacherName: context.l10n.samplePreacher,
                        imamName: context.l10n.sampleImam,
                        studyType: context.l10n.sampleStudyType,
                        imageLabel: context.l10n.sampleMosqueName,
                        isFavorite: index == 1,
                        onTap: _onMosquePressed,
                        onFavoritePressed: () {},
                        topBadge: index == 2 ? const NewUpdateBadge() : null,
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
  }
}

class _ExploreSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.close)),
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
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
