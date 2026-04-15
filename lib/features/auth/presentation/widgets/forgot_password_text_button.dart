import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';

class ForgotPasswordTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;

  const ForgotPasswordTextButton({
    super.key,
    required this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedLabel = label ?? context.l10n.forgotPassword;

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          resolvedLabel,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
