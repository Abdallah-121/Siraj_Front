import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import 'profile_avatar_picker.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String userName;
  final String email;
  final String buttonLabel;
  final VoidCallback? onEditPressed;
  final VoidCallback? onPickImage;

  const ProfileHeaderCard({
    super.key,
    required this.userName,
    required this.email,
    required this.buttonLabel,
    this.onEditPressed,
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      userName,
                      textAlign: TextAlign.end,
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      email,
                      textAlign: TextAlign.end,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: SizedBox(
                        width: 190,
                        height: 55,
                        child: AppButton(
                          label: buttonLabel,
                          onPressed: onEditPressed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              ProfileAvatarPicker(size: 92, onPickImage: onPickImage),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Divider(height: 1, color: AppColors.divider),
        ],
      ),
    );
  }
}
