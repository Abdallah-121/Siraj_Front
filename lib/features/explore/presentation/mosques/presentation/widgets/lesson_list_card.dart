import 'package:flutter/material.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/theme/app_radius.dart';
import 'package:seraj/core/theme/app_shadows.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';

class LessonListCard extends StatelessWidget {
  final LessonEntity lesson;
  final VoidCallback onTap;

  const LessonListCard({super.key, required this.lesson, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 0.9),
          boxShadow: AppShadows.subtle,
        ),
        child: Row(
          children: [
            Container(
              width: 110,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    lesson.name,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    lesson.categoryName,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    lesson.description,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    lesson.isItCompleteCourse
                        ? context.l10n.completeCourse
                        : context.l10n.singleLesson,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
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
