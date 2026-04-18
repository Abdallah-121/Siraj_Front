import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import 'recent_search_item.dart';
import 'search_section_title.dart';

class RecentSearchesSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final ValueChanged<String>? onItemTap;

  const RecentSearchesSection({
    super.key,
    required this.title,
    required this.items,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SearchSectionTitle(title: title),
        const SizedBox(height: AppSpacing.md),
        ...items.map((item) {
          return RecentSearchItem(
            title: item,
            onTap: () => onItemTap?.call(item),
          );
        }),
      ],
    );
  }
}
