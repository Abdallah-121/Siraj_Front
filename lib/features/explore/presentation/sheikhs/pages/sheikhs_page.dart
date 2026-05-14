import 'package:flutter/material.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_listing_page_layout.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/context_extensions.dart';

class SheikhsPage extends StatefulWidget {
  const SheikhsPage({super.key});

  @override
  State<SheikhsPage> createState() => _SheikhsPageState();
}

class _SheikhsPageState extends State<SheikhsPage> {
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

  void _onSearchPressed() {}

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

    setState(() {
      _currentItem = item;
    });
  }

  void _onSheikhPressed() {
    Navigator.pushNamed(context, RouteNames.sheikhDetail);
  }

  @override
  Widget build(BuildContext context) {
    final String filterLabel = _selectedFilter.isEmpty
        ? context.l10n.area
        : _selectedFilter;

    return ExploreListingPageLayout(
      trailingIcon: const Icon(Icons.person_outline_rounded, size: 34),
      filterDescription: context.l10n.showResultsBy,
      filterLabel: filterLabel,
      filterItems: _filterItems,
      isFilterExpanded: _isFilterExpanded,
      onBackPressed: _onBackPressed,
      onSearchPressed: _onSearchPressed,
      onFilterPressed: _toggleFilter,
      onFilterSelected: _onFilterSelected,
      currentNavItem: _currentItem,
      onNavItemSelected: _onBottomNavItemSelected,
      content: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (context, index) {
          return PlaceListItem(
            title: context.l10n.sampleName,
            preacherName: context.l10n.samplePreacher,
            imamName: context.l10n.sampleImam,
            studyType: context.l10n.sampleStudyType,
            imageLabel: context.l10n.sheikh,
            isFavorite: index == 1,
            onTap: _onSheikhPressed,
            onFavoritePressed: () {},
          );
        },
      ),
    );
  }
}
