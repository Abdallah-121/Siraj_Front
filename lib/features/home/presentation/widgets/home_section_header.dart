import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool showAction;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.onPressed,
    this.showAction = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showAction) {
      return Text(
        title,
        textAlign: TextAlign.end,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      );
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back_rounded,
              size: 22,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.end,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
