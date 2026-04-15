import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppOutlinedButtonVariant { primary, light }

class AppOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final bool expand;
  final AppOutlinedButtonVariant variant;

  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leading,
    this.isLoading = false,
    this.padding,
    this.height,
    this.width,
    this.expand = true,
    this.variant = AppOutlinedButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final _AppOutlinedButtonStyle style = _resolveStyle();

    return SizedBox(
      height: height ?? 56,
      width: expand ? double.infinity : width,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: style.foregroundColor,
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
          side: BorderSide(color: style.borderColor, width: 1.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          textStyle: style.textStyle,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      style.loadingColor,
                    ),
                  ),
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _AppOutlinedButtonStyle _resolveStyle() {
    switch (variant) {
      case AppOutlinedButtonVariant.primary:
        return const _AppOutlinedButtonStyle(
          foregroundColor: AppColors.primary,
          borderColor: AppColors.primary,
          loadingColor: AppColors.primary,
          textStyle: AppTextStyles.buttonOutlined,
        );
      case AppOutlinedButtonVariant.light:
        return _AppOutlinedButtonStyle(
          foregroundColor: AppColors.white,
          borderColor: AppColors.white,
          loadingColor: AppColors.white,
          textStyle: AppTextStyles.buttonOutlined.copyWith(
            color: AppColors.white,
          ),
        );
    }
  }
}

class _AppOutlinedButtonStyle {
  final Color foregroundColor;
  final Color borderColor;
  final Color loadingColor;
  final TextStyle textStyle;

  const _AppOutlinedButtonStyle({
    required this.foregroundColor,
    required this.borderColor,
    required this.loadingColor,
    required this.textStyle,
  });
}
