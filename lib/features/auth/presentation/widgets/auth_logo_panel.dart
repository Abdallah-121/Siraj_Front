import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_gap.dart';

class AuthLogoPanel extends StatelessWidget {
  final String appName;
  final String? subtitle;
  final Widget? logo;
  final EdgeInsetsGeometry? padding;
  final double? maxLogoWidth;
  final double? bottomRadius;

  const AuthLogoPanel({
    super.key,
    required this.appName,
    this.subtitle,
    this.logo,
    this.padding,
    this.maxLogoWidth,
    this.bottomRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          padding ??
          const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.xxxxl,
            AppSpacing.xl,
            AppSpacing.xxxl,
          ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomRadius ?? AppRadius.xxl),
          bottomRight: Radius.circular(bottomRadius ?? AppRadius.xxl),
        ),
      ),
      child: Column(
        children: [
          if (logo != null) ...[
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxLogoWidth ?? 220),
              child: logo!,
            ),
            AppGap.v12,
          ],
          Text(
            appName,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
            AppGap.v8,
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withValues(alpha: 0.88),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
