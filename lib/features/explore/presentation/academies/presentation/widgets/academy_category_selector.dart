import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../categories/domain/entities/category_entity.dart';

class AcademyCategorySelector extends StatelessWidget {
  final List<CategoryEntity> categories;
  final Set<int> selectedCategoryIds;
  final ValueChanged<int> onToggleCategory;

  const AcademyCategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategoryIds,
    required this.onToggleCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.categoryName, style: AppTextStyles.fieldLabel),
        const SizedBox(height: AppSpacing.sm),
        if (categories.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              context.l10n.noCategoriesFound,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: categories.map((category) {
              final selected = selectedCategoryIds.contains(category.id);

              return FilterChip(
                label: Text(category.name),
                selected: selected,
                onSelected: (_) => onToggleCategory(category.id),
                selectedColor: AppColors.primary.withValues(alpha: 0.14),
                checkmarkColor: AppColors.primary,
                labelStyle: AppTextStyles.bodyMedium.copyWith(
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
