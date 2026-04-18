import 'package:flutter/material.dart';
import 'package:seraj/core/widgets/app_search_field.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_listing_page_layout.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/new_update_badge.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_list_item.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../core/theme/app_spacing.dart';
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

  void _onPlacePressed() {
    Navigator.pushNamed(context, RouteNames.mosqueDetail);
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final String subjectName = args is String && args.isNotEmpty
        ? args
        : context.l10n.subjectPlacesTitle;

    final String pageText = context.l10n.placesTeachingSubject(subjectName);

    final String filterLabel = _selectedFilter.isEmpty
        ? context.l10n.area
        : _selectedFilter;

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
          ListView.separated(
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
                imageLabel: subjectName,
                isFavorite: index == 1,
                onTap: _onPlacePressed,
                onFavoritePressed: () {},
                topBadge: index == 2 ? const NewUpdateBadge() : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
