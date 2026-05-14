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
  final bool canManageLesson;
  final bool isPublishing;
  final bool isUnpublishing;
  final VoidCallback? onPublishPressed;
  final VoidCallback? onUnpublishPressed;

  const LessonListCard({
    super.key,
    required this.lesson,
    required this.onTap,
    this.canManageLesson = false,
    this.isPublishing = false,
    this.isUnpublishing = false,
    this.onPublishPressed,
    this.onUnpublishPressed,
  });

  bool get _isPublished {
    return lesson.isPublished || lesson.status == 5;
  }

  bool get _isActionLoading {
    return isPublishing || isUnpublishing;
  }

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: _isActionLoading ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 0.9),
          boxShadow: AppShadows.subtle,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool compact = constraints.maxWidth < 520;

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LessonIconBox(),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(child: _LessonContent(lesson: lesson)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _BottomRow(
                    lesson: lesson,
                    isRtl: isRtl,
                    isPublished: _isPublished,
                    canManageLesson: canManageLesson,
                    isPublishing: isPublishing,
                    isUnpublishing: isUnpublishing,
                    onPublishPressed: onPublishPressed,
                    onUnpublishPressed: onUnpublishPressed,
                  ),
                ],
              );
            }

            return Row(
              textDirection: Directionality.of(context),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LessonIconBox(),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _LessonContent(lesson: lesson),
                      const SizedBox(height: AppSpacing.sm),
                      _BottomRow(
                        lesson: lesson,
                        isRtl: isRtl,
                        isPublished: _isPublished,
                        canManageLesson: canManageLesson,
                        isPublishing: isPublishing,
                        isUnpublishing: isUnpublishing,
                        onPublishPressed: onPublishPressed,
                        onUnpublishPressed: onUnpublishPressed,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LessonIconBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: const Icon(
        Icons.menu_book_rounded,
        color: AppColors.primary,
        size: 34,
      ),
    );
  }
}

class _LessonContent extends StatelessWidget {
  final LessonEntity lesson;

  const _LessonContent({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lesson.name,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          lesson.categoryName,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          lesson.description,
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _BottomRow extends StatelessWidget {
  final LessonEntity lesson;
  final bool isRtl;
  final bool isPublished;
  final bool canManageLesson;
  final bool isPublishing;
  final bool isUnpublishing;
  final VoidCallback? onPublishPressed;
  final VoidCallback? onUnpublishPressed;

  const _BottomRow({
    required this.lesson,
    required this.isRtl,
    required this.isPublished,
    required this.canManageLesson,
    required this.isPublishing,
    required this.isUnpublishing,
    required this.onPublishPressed,
    required this.onUnpublishPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: Directionality.of(context),
      children: [
        _LessonTypeChip(lesson: lesson),
        if (canManageLesson) ...[
          const SizedBox(width: AppSpacing.sm),
          _PublishStatusChip(isPublished: isPublished),
          const Spacer(),
          _PublishActionButton(
            isPublished: isPublished,
            isPublishing: isPublishing,
            isUnpublishing: isUnpublishing,
            onPublishPressed: onPublishPressed,
            onUnpublishPressed: onUnpublishPressed,
          ),
        ] else ...[
          const Spacer(),
          Icon(
            isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
            color: AppColors.textSecondary,
            size: 22,
          ),
        ],
      ],
    );
  }
}

class _LessonTypeChip extends StatelessWidget {
  final LessonEntity lesson;

  const _LessonTypeChip({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        lesson.isItCompleteCourse
            ? context.l10n.completeCourse
            : context.l10n.singleLesson,
        textAlign: TextAlign.start,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.success,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PublishStatusChip extends StatelessWidget {
  final bool isPublished;

  const _PublishStatusChip({required this.isPublished});

  @override
  Widget build(BuildContext context) {
    final Color color = isPublished
        ? AppColors.success
        : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        isPublished ? context.l10n.published : context.l10n.unpublished,
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PublishActionButton extends StatelessWidget {
  final bool isPublished;
  final bool isPublishing;
  final bool isUnpublishing;
  final VoidCallback? onPublishPressed;
  final VoidCallback? onUnpublishPressed;

  const _PublishActionButton({
    required this.isPublished,
    required this.isPublishing,
    required this.isUnpublishing,
    required this.onPublishPressed,
    required this.onUnpublishPressed,
  });

  bool get _isLoading => isPublishing || isUnpublishing;

  @override
  Widget build(BuildContext context) {
    final String label = isPublished
        ? context.l10n.unpublish
        : context.l10n.publish;
    final VoidCallback? onPressed = _isLoading
        ? null
        : isPublished
        ? onUnpublishPressed
        : onPublishPressed;

    return TextButton.icon(
      onPressed: onPressed,
      icon: _isLoading
          ? const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(
              isPublished
                  ? Icons.visibility_off_rounded
                  : Icons.publish_rounded,
            ),
      label: Text(label),
    );
  }
}
