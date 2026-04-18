import 'package:flutter/material.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../widgets/recent_searches_section.dart';
import '../widgets/search_header.dart';
import '../widgets/search_section_title.dart';
import '../widgets/search_suggestions_wrap.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  MainNavItem _currentItem = MainNavItem.search;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

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

  void _onSearchChanged(String value) {
    setState(() {});
  }

  void _onSuggestionPressed(String value) {
    _searchController.text = value;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
    _searchFocusNode.requestFocus();
    setState(() {});
  }

  void _onRecentSearchPressed(String value) {
    _searchController.text = value;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
    _searchFocusNode.requestFocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<String> suggestions = [
      context.l10n.mosquesSuggestion,
      context.l10n.academiesSuggestion,
      context.l10n.shariaSuggestion,
      context.l10n.quranSuggestion,
      context.l10n.fiqhSuggestion,
      context.l10n.hadithSuggestion,
      context.l10n.sheikhSuggestion,
    ];

    final List<String> recentSearches = [context.l10n.sampleRecentSearch];

    final String query = _searchController.text.trim();

    final List<String> filteredSuggestions = query.isEmpty
        ? suggestions
        : suggestions
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();

    final List<String> filteredRecentSearches = query.isEmpty
        ? recentSearches
        : recentSearches
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();

    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: MainBottomNavBar(
        currentItem: _currentItem,
        onItemSelected: _onBottomNavItemSelected,
      ),
      body: Column(
        children: [
          SearchHeader(onBackPressed: _onBackPressed),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppSearchField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    hintText: context.l10n.searchPlaceholderTitle,
                    onChanged: _onSearchChanged,
                    autofocus: true,
                  ),
                  AppGap.v24,
                  SearchSectionTitle(title: context.l10n.suggestions),
                  AppGap.v16,
                  SearchSuggestionsWrap(
                    suggestions: filteredSuggestions,
                    onSuggestionTap: _onSuggestionPressed,
                  ),
                  AppGap.v32,
                  RecentSearchesSection(
                    title: context.l10n.recentSearches,
                    items: filteredRecentSearches,
                    onItemTap: _onRecentSearchPressed,
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
