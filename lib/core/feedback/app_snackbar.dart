import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppSnackbarType { success, error, info, warning }

abstract final class AppSnackbar {
  static void success(BuildContext context, String message) {
    _show(
      context,
      message,
      type: AppSnackbarType.success,
      icon: Icons.check_circle_outline_rounded,
    );
  }

  static void error(BuildContext context, String message) {
    _show(
      context,
      message,
      type: AppSnackbarType.error,
      icon: Icons.error_outline_rounded,
    );
  }

  static void info(BuildContext context, String message) {
    _show(
      context,
      message,
      type: AppSnackbarType.info,
      icon: Icons.info_outline_rounded,
    );
  }

  static void warning(BuildContext context, String message) {
    _show(
      context,
      message,
      type: AppSnackbarType.warning,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required AppSnackbarType type,
    required IconData icon,
  }) {
    final trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    final colors = _colors(type);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 10,
          backgroundColor: colors.backgroundColor,
          dismissDirection: DismissDirection.horizontal,
          margin: _resolveMargin(context),
          duration: const Duration(seconds: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            side: BorderSide(color: colors.borderColor, width: 1),
          ),
          content: Row(
            textDirection: Directionality.of(context),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: colors.iconColor, size: 22),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  trimmedMessage,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colors.textColor,
                    fontWeight: FontWeight.w700,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  static EdgeInsetsGeometry _resolveMargin(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    final bottomPadding = mediaQuery?.padding.bottom ?? 0;

    return EdgeInsetsDirectional.fromSTEB(
      AppSpacing.lg,
      0,
      AppSpacing.lg,
      88 + bottomPadding,
    );
  }

  static _AppSnackbarColors _colors(AppSnackbarType type) {
    switch (type) {
      case AppSnackbarType.success:
        return _AppSnackbarColors(
          backgroundColor: AppColors.primary,
          borderColor: AppColors.primary,
          iconColor: AppColors.white,
          textColor: AppColors.white,
        );

      case AppSnackbarType.error:
        return _AppSnackbarColors(
          backgroundColor: AppColors.error,
          borderColor: AppColors.error,
          iconColor: AppColors.white,
          textColor: AppColors.white,
        );

      case AppSnackbarType.warning:
        return _AppSnackbarColors(
          backgroundColor: const Color(0xFF8A5A00),
          borderColor: const Color(0xFF8A5A00),
          iconColor: AppColors.white,
          textColor: AppColors.white,
        );

      case AppSnackbarType.info:
        return _AppSnackbarColors(
          backgroundColor: AppColors.textPrimary,
          borderColor: AppColors.textPrimary,
          iconColor: AppColors.white,
          textColor: AppColors.white,
        );
    }
  }
}

class _AppSnackbarColors {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const _AppSnackbarColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });
}
