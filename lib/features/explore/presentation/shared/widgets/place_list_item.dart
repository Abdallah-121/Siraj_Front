import 'package:flutter/material.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _PlaceInfoColumn(
              title: title,
              preacherName: preacherName,
              imamName: imamName,
              studyType: studyType,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          _PlaceImageBlock(
            imageLabel: imageLabel,
            isFavorite: isFavorite,
            onFavoritePressed: onFavoritePressed,
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

    if (topBadge == null) {
      return wrapped;
    }

    return Column(
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
      crossAxisAlignment: CrossAxisAlignment.end,
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
              fontWeight: FontWeight.w500,
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
      textAlign: TextAlign.end,
    );
  }
}

class _PlaceImageBlock extends StatelessWidget {
  final String imageLabel;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;

  const _PlaceImageBlock({
    required this.imageLabel,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 156,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              PositionedDirectional(
                top: 8,
                end: 8,
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: IconButton(
                    onPressed: onFavoritePressed,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 24,
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
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
