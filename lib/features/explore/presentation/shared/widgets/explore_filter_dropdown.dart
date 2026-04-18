import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ExploreFilterDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final bool isExpanded;
  final VoidCallback? onPressed;
  final ValueChanged<String>? onItemSelected;

  const ExploreFilterDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.isExpanded,
    this.onPressed,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.textSecondary, width: 0.8),
            ),
            child: Column(
              children: List.generate(items.length, (index) {
                final bool isLast = index == items.length - 1;

                return InkWell(
                  onTap: () => onItemSelected?.call(items[index]),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      border: isLast
                          ? null
                          : const Border(
                              bottom: BorderSide(
                                color: AppColors.divider,
                                width: 1,
                              ),
                            ),
                    ),
                    child: Text(
                      items[index],
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ],
    );
  }
}
