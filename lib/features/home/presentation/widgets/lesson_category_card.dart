import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class LessonCategoryCard extends StatelessWidget {
  static const double cardWidth = 210;
  static const double cardHeight = 118;

  final String title;
  final VoidCallback? onTap;

  const LessonCategoryCard({super.key, required this.title, this.onTap});

  IconData get _icon {
    if (title.contains('قرآن') || title.toLowerCase().contains('quran')) {
      return Icons.menu_book_rounded;
    }

    return Icons.auto_stories_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.surface,
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        textDirection: Directionality.of(context),
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Icon(_icon, color: AppColors.white, size: 28),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: content,
    );
  }
}
