import 'package:flutter/material.dart';
import 'package:seraj/core/utils/image_url_resolver.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/context_extensions.dart';

class PlaceListItem extends StatelessWidget {
  final String title;
  final String preacherName;
  final String imamName;
  final String studyType;
  final String imageLabel;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;
  final Widget? topBadge;
  final String? imageUrl;

  const PlaceListItem({
    super.key,
    required this.title,
    required this.preacherName,
    required this.imamName,
    required this.studyType,
    required this.imageLabel,
    this.isFavorite = false,
    this.onTap,
    this.onFavoritePressed,
    this.topBadge,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.9),
        boxShadow: AppShadows.subtle,
      ),
      child: Row(
        textDirection: Directionality.of(context),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PlaceImageBlock(
            imageLabel: imageLabel,
            imageUrl: imageUrl,
            isFavorite: isFavorite,
            onFavoritePressed: onFavoritePressed,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: _PlaceInfoColumn(
              title: title,
              preacherName: preacherName,
              imamName: imamName,
              studyType: studyType,
            ),
          ),
        ],
      ),
    );

    final Widget wrapped = onTap == null
        ? content
        : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: content,
          );

    if (topBadge == null) return wrapped;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topBadge!,
        const SizedBox(height: AppSpacing.xs),
        wrapped,
      ],
    );
  }
}

class _PlaceInfoColumn extends StatelessWidget {
  final String title;
  final String preacherName;
  final String imamName;
  final String studyType;

  const _PlaceInfoColumn({
    required this.title,
    required this.preacherName,
    required this.imamName,
    required this.studyType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoText(label: context.l10n.nameLabel, value: title),
        const SizedBox(height: AppSpacing.md),
        _InfoText(label: context.l10n.preacherLabel, value: preacherName),
        const SizedBox(height: AppSpacing.md),
        _InfoText(label: context.l10n.imamLabel, value: imamName),
        const SizedBox(height: AppSpacing.md),
        _InfoText(label: context.l10n.studyTypeLabel, value: studyType),
      ],
    );
  }
}

class _InfoText extends StatelessWidget {
  final String label;
  final String value;

  const _InfoText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}

class _PlaceImageBlock extends StatelessWidget {
  final String imageLabel;
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;

  const _PlaceImageBlock({
    required this.imageLabel,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedImageUrl = resolveImageUrl(imageUrl);
    final bool hasImage = resolvedImageUrl.isNotEmpty;

    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: SizedBox(
                  height: 156,
                  width: double.infinity,
                  child: hasImage
                      ? Image.network(
                          resolvedImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const _PlaceImagePlaceholder(),
                        )
                      : const _PlaceImagePlaceholder(),
                ),
              ),
              PositionedDirectional(
                top: 8,
                end: 8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.92),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: onFavoritePressed,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 21,
                      color: isFavorite
                          ? AppColors.error
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            imageLabel,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceImagePlaceholder extends StatelessWidget {
  const _PlaceImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.border,
      child: const Center(
        child: Icon(Icons.mosque_rounded, color: AppColors.primary, size: 42),
      ),
    );
  }
}
