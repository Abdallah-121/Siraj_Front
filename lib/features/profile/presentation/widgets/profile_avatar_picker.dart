import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class ProfileAvatarPicker extends StatelessWidget {
  final double size;
  final VoidCallback? onPickImage;

  const ProfileAvatarPicker({super.key, this.size = 88, this.onPickImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 16,
      height: size + 16,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: AppColors.border,
                shape: BoxShape.circle,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: InkWell(
              onTap: onPickImage,
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
