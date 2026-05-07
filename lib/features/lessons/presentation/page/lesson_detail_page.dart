import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/app/widgets/app_page_header.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/theme/app_radius.dart';
import 'package:seraj/core/theme/app_shadows.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/widgets/app_gap.dart';
import 'package:seraj/core/widgets/app_scaffold.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_detail_entity.dart';
import 'package:seraj/features/lessons/presentation/cubit/lesson_detail_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/lesson_detail_state.dart';

class LessonDetailPage extends StatelessWidget {
  const LessonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LessonEntity lesson =
        ModalRoute.of(context)!.settings.arguments as LessonEntity;

    return BlocProvider(
      create: (_) => sl<LessonDetailCubit>()..loadLessonDetail(lesson.id),
      child: AppScaffold(
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          children: [
            AppPageHeader(
              onBackPressed: () => Navigator.pop(context),
              bottomPadding: AppSpacing.xxxl,
            ),
            Expanded(
              child: BlocBuilder<LessonDetailCubit, LessonDetailState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.errorMessage != null) {
                    return _LessonDetailErrorView(
                      message: state.errorMessage!,
                      onRetry: () {
                        context.read<LessonDetailCubit>().loadLessonDetail(
                          lesson.id,
                        );
                      },
                    );
                  }

                  final detail = state.lessonDetail;
                  if (detail == null) {
                    return const _LessonDetailEmptyView();
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _LessonHeroCard(detail: detail),
                        AppGap.v20,
                        _SectionTitle(title: 'نبذة عن الدرس'),
                        AppGap.v12,
                        _InfoCard(
                          child: _DescriptionBlock(
                            description: detail.description,
                            notes: detail.notes,
                          ),
                        ),
                        AppGap.v20,
                        _SectionTitle(title: 'معلومات الدرس'),
                        AppGap.v12,
                        _InfoCard(
                          child: Column(
                            children: [
                              _InfoTile(
                                icon: Icons.menu_book_rounded,
                                label: 'التصنيف',
                                value: detail.category.categoryName,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _InfoTile(
                                icon: Icons.school_rounded,
                                label: 'نوع الدرس',
                                value: detail.isItACompleteCourse
                                    ? 'دورة كاملة'
                                    : 'درس مفرد',
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _InfoTile(
                                icon: Icons.live_tv_rounded,
                                label: 'البث المباشر',
                                value: detail.liveStreamingCapability
                                    ? 'متاح'
                                    : 'غير متاح',
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _InfoTile(
                                icon: Icons.verified_rounded,
                                label: 'الحالة',
                                value: detail.status,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _InfoTile(
                                icon: Icons.visibility_rounded,
                                label: 'منشور',
                                value: detail.isPublished ? 'نعم' : 'لا',
                              ),
                            ],
                          ),
                        ),
                        AppGap.v20,
                        _SectionTitle(title: 'المدرّس'),
                        AppGap.v12,
                        _InfoCard(
                          child: Column(
                            children: [
                              _ProfileHeaderMini(
                                title: detail.teacher.fullName,
                                subtitle: detail.teacher.qualification,
                                icon: Icons.person_rounded,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              _InfoTile(
                                icon: Icons.badge_rounded,
                                label: 'المؤهل',
                                value: detail.teacher.qualification,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _InfoTile(
                                icon: Icons.article_rounded,
                                label: 'نبذة',
                                value: detail.teacher.bio,
                              ),
                            ],
                          ),
                        ),
                        AppGap.v20,
                        _SectionTitle(title: 'المسجد المرتبط'),
                        AppGap.v12,
                        _InfoCard(
                          child: Column(
                            children: [
                              _ProfileHeaderMini(
                                title: detail.mosque.mosqueName,
                                subtitle: detail.mosque.address,
                                icon: Icons.mosque_rounded,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              _InfoTile(
                                icon: Icons.location_on_rounded,
                                label: 'العنوان',
                                value: detail.mosque.address,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _InfoTile(
                                icon: Icons.phone_rounded,
                                label: 'رقم الهاتف',
                                value: detail.mosque.phoneNumber,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonHeroCard extends StatelessWidget {
  final LessonDetailEntity detail;

  const _LessonHeroCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primary, Color(0xFF0E6B43)],
        ),
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              _StatusChip(
                label: detail.isPublished ? 'منشور' : 'غير منشور',
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                textColor: AppColors.white,
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatusChip(
                label: detail.liveStreamingCapability ? 'بث مباشر' : 'بدون بث',
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                textColor: AppColors.white,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            detail.name,
            textAlign: TextAlign.end,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            detail.category.categoryName,
            textAlign: TextAlign.end,
            style: AppTextStyles.titleMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _HeroMiniStat(
                  title: 'النوع',
                  value: detail.isItACompleteCourse ? 'كامل' : 'مفرد',
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _HeroMiniStat(title: 'الحالة', value: detail.status),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMiniStat extends StatelessWidget {
  final String title;
  final String value;

  const _HeroMiniStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.end,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const _StatusChip({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.end,
      style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w800),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Widget child;

  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.9),
        boxShadow: AppShadows.subtle,
      ),
      child: child,
    );
  }
}

class _DescriptionBlock extends StatelessWidget {
  final String description;
  final String notes;

  const _DescriptionBlock({required this.description, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _TextBlock(label: 'الوصف', value: description),
        if (notes.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _TextBlock(label: 'ملاحظات', value: notes),
        ],
      ],
    );
  }
}

class _TextBlock extends StatelessWidget {
  final String label;
  final String value;

  const _TextBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          textAlign: TextAlign.end,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value.trim().isNotEmpty ? value : 'غير متوفر',
          textAlign: TextAlign.end,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                label,
                textAlign: TextAlign.end,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value.trim().isNotEmpty ? value : 'غير متوفر',
                textAlign: TextAlign.end,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileHeaderMini extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ProfileHeaderMini({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.surfaceSoft,
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title.trim().isNotEmpty ? title : 'غير متوفر',
                textAlign: TextAlign.end,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle.trim().isNotEmpty ? subtitle : 'غير متوفر',
                textAlign: TextAlign.end,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LessonDetailErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _LessonDetailErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: AppColors.error),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 42,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.error),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextButton(
                onPressed: onRetry,
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonDetailEmptyView extends StatelessWidget {
  const _LessonDetailEmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'لا توجد تفاصيل للدرس',
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
