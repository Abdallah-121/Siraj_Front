import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SupportResultDialog extends StatelessWidget {
  final bool isSuccess;
  final String title;
  final String? message;
  final VoidCallback? onClose;

  const SupportResultDialog({
    super.key,
    required this.isSuccess,
    required this.title,
    this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isSuccess ? AppColors.success : AppColors.error;
    final IconData icon = isSuccess ? Icons.check_rounded : Icons.close_rounded;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                onTap: onClose ?? () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.xs),
                  child: Text('x'),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.white, size: 44),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (message != null && message!.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
