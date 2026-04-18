import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class ExploreHeader extends StatelessWidget {
  final Widget? trailing;
  final VoidCallback? onBackPressed;
  final bool compact;

  const ExploreHeader({
    super.key,
    this.trailing,
    this.onBackPressed,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        compact ? AppSpacing.lg : AppSpacing.xxl,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.xxl),
          bottomRight: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: Row(
        children: [
          _ExploreBackButton(onPressed: onBackPressed),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _ExploreBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _ExploreBackButton({required this.onPressed});

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
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
        ),
      ),
    );
  }
}
