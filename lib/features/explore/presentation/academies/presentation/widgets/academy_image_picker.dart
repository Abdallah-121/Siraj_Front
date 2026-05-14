import 'dart:io';

import 'package:flutter/material.dart';
import 'package:seraj/core/utils/image_url_resolver.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class AcademyImagePicker extends StatelessWidget {
  final File? pickedImage;
  final String? imageUrl;
  final VoidCallback onPickPressed;

  const AcademyImagePicker({
    super.key,
    required this.pickedImage,
    required this.imageUrl,
    required this.onPickPressed,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedUrl = resolveImageUrl(imageUrl);
    final hasNetworkImage = resolvedUrl.isNotEmpty;

    return InkWell(
      onTap: onPickPressed,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        height: 190,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (pickedImage != null)
              Image.file(pickedImage!, fit: BoxFit.cover)
            else if (hasNetworkImage)
              Image.network(
                resolvedUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const _ImagePlaceholder(),
              )
            else
              const _ImagePlaceholder(),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.45),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.white,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'اختيار صورة',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.school_outlined, color: AppColors.primary, size: 54),
    );
  }
}
