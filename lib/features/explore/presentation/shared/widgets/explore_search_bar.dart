import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

enum ExploreSearchBarMode { full, iconOnly }

class ExploreSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final ExploreSearchBarMode mode;

  const ExploreSearchBar({
    super.key,
    this.onTap,
    this.mode = ExploreSearchBarMode.full,
  });

  @override
  Widget build(BuildContext context) {
    if (mode == ExploreSearchBarMode.iconOnly) {
      return SizedBox(
        width: 44,
        height: 44,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.textPrimary,
              size: 30,
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 20,
                  margin: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            const Icon(
              Icons.search_rounded,
              color: AppColors.textSecondary,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
