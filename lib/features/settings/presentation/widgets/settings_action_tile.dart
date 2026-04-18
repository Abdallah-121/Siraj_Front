import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class SettingsActionTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;
  final bool showChevron;
  final Color? titleColor;

  const SettingsActionTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
    this.showChevron = true,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(leadingIcon, color: AppColors.textSecondary, size: 22),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: titleColor ?? AppColors.textSecondary,
              ),
            ),
            if (showChevron) ...[
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.chevron_left_rounded,
                color: AppColors.textSecondary,
                size: 22,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
