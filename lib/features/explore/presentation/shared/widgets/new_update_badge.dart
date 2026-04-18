import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/context_extensions.dart';

class NewUpdateBadge extends StatelessWidget {
  const NewUpdateBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        context.l10n.newUpdateAvailable,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
