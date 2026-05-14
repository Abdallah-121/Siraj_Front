import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import 'search_suggestion_chip.dart';

class SearchSuggestionsWrap extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String>? onSuggestionTap;

  const SearchSuggestionsWrap({
    super.key,
    required this.suggestions,
    this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      alignment: WrapAlignment.end,
      children: suggestions.map((suggestion) {
        return SearchSuggestionChip(
          label: suggestion,
          onTap: () => onSuggestionTap?.call(suggestion),
        );
      }).toList(),
    );
  }
}
