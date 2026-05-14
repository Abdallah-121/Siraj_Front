import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SubjectOptionCard extends StatelessWidget {
  static const double cardWidth = 170;
  static const double cardHeight = 190;
  static const double imageHeight = 118;

  final String title;
  final VoidCallback? onTap;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final bool showAdminActions;

  const SubjectOptionCard({
    super.key,
    required this.title,
    this.onTap,
    this.onEditPressed,
    this.onDeletePressed,
    this.showAdminActions = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.9),
        boxShadow: AppShadows.subtle,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.category_rounded,
                  color: AppColors.primary,
                  size: 38,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (showAdminActions)
            PositionedDirectional(
              top: AppSpacing.xs,
              end: AppSpacing.xs,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SmallActionButton(
                    icon: Icons.edit_rounded,
                    color: AppColors.primary,
                    onPressed: onEditPressed,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _SmallActionButton(
                    icon: Icons.delete_outline_rounded,
                    color: AppColors.error,
                    onPressed: onDeletePressed,
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: content,
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const _SmallActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }
}
