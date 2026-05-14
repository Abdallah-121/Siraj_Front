import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/utils/image_url_resolver.dart';

class ProfileAvatarPicker extends StatelessWidget {
  final double size;
  final String imageUrl;
  final File? imageFile;
  final VoidCallback? onPickImage;
  final bool showEditButton;

  const ProfileAvatarPicker({
    super.key,
    this.size = 88,
    this.imageUrl = '',
    this.imageFile,
    this.onPickImage,
    this.showEditButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedImageUrl = resolveImageUrl(imageUrl);
    final bool hasLocalImage = imageFile != null;
    final bool hasNetworkImage = resolvedImageUrl.trim().isNotEmpty;

    return SizedBox(
      width: size + 18,
      height: size + 18,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  width: 1.2,
                ),
                boxShadow: AppShadows.subtle,
              ),
              child: ClipOval(
                child: Container(
                  color: AppColors.border,
                  child: hasLocalImage
                      ? Image.file(
                          imageFile!,
                          width: size,
                          height: size,
                          fit: BoxFit.cover,
                        )
                      : hasNetworkImage
                      ? Image.network(
                          resolvedImageUrl,
                          width: size,
                          height: size,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return _AvatarPlaceholder(size: size);
                          },
                        )
                      : _AvatarPlaceholder(size: size),
                ),
              ),
            ),
          ),
          if (showEditButton)
            PositionedDirectional(
              bottom: 2,
              end: 2,
              child: InkWell(
                onTap: onPickImage,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2.2),
                    boxShadow: AppShadows.subtle,
                  ),
                  child: const Icon(
                    Icons.photo_camera_rounded,
                    size: 17,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  final double size;

  const _AvatarPlaceholder({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            AppColors.primary.withValues(alpha: 0.14),
            AppColors.primary.withValues(alpha: 0.04),
          ],
        ),
      ),
      child: Icon(
        Icons.person_rounded,
        color: AppColors.primary.withValues(alpha: 0.75),
        size: size * 0.46,
      ),
    );
  }
}
