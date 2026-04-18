import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class DetailHeaderImage extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;
  final bool isFavorite;

  const DetailHeaderImage({
    super.key,
    this.onBackPressed,
    this.onFavoritePressed,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 260,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.xxl),
              bottomRight: Radius.circular(AppRadius.xxl),
            ),
          ),
        ),
        PositionedDirectional(
          top: AppSpacing.lg,
          start: AppSpacing.lg,
          child: _CircleIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBackPressed,
          ),
        ),
        PositionedDirectional(
          top: AppSpacing.lg,
          end: AppSpacing.lg,
          child: _CircleIconButton(
            icon: isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            onPressed: onFavoritePressed,
            iconColor: isFavorite ? AppColors.error : AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;

  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor ?? AppColors.primary),
        ),
      ),
    );
  }
}
