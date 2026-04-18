import 'package:flutter/material.dart';

import '../../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import 'explore_filter_dropdown.dart';
import 'explore_header.dart';
import 'explore_search_bar.dart';

class ExploreListingPageLayout extends StatelessWidget {
  final Widget? trailingIcon;
  final String? titleText;
  final String? filterDescription;
  final String? filterLabel;
  final List<String> filterItems;
  final bool isFilterExpanded;
  final bool compactHeader;
  final bool showSearchBar;
  final bool showFilter;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onFilterPressed;
  final ValueChanged<String>? onFilterSelected;
  final MainNavItem currentNavItem;
  final ValueChanged<MainNavItem>? onNavItemSelected;
  final Widget content;

  const ExploreListingPageLayout({
    super.key,
    required this.currentNavItem,
    required this.content,
    this.trailingIcon,
    this.titleText,
    this.filterDescription,
    this.filterLabel,
    this.filterItems = const [],
    this.isFilterExpanded = false,
    this.compactHeader = true,
    this.showSearchBar = true,
    this.showFilter = false,
    this.onBackPressed,
    this.onSearchPressed,
    this.onFilterPressed,
    this.onFilterSelected,
    this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: MainBottomNavBar(
        currentItem: currentNavItem,
        onItemSelected: onNavItemSelected,
      ),
      body: Column(
        children: [
          ExploreHeader(
            onBackPressed: onBackPressed,
            trailing: trailingIcon,
            compact: compactHeader,
          ),
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
                  if (titleText != null && titleText!.trim().isNotEmpty) ...[
                    Text(
                      titleText!,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  if (showSearchBar) ...[
                    ExploreSearchBar(onTap: onSearchPressed),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  if (showFilter &&
                      filterDescription != null &&
                      filterLabel != null) ...[
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(filterDescription!, textAlign: TextAlign.end),
                          const SizedBox(height: AppSpacing.xs),
                          ExploreFilterDropdown(
                            label: filterLabel!,
                            items: filterItems,
                            isExpanded: isFilterExpanded,
                            onPressed: onFilterPressed,
                            onItemSelected: onFilterSelected,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  content,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
