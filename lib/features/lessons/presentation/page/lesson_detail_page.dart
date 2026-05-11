import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/app/widgets/app_page_header.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/theme/app_radius.dart';
import 'package:seraj/core/theme/app_shadows.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/core/widgets/app_button.dart';
import 'package:seraj/core/widgets/app_gap.dart';
import 'package:seraj/core/widgets/app_scaffold.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_detail_entity.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';
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
      child: BlocConsumer<LessonDetailCubit, LessonDetailState>(
        listenWhen: (previous, current) {
          return previous.actionErrorMessage != current.actionErrorMessage ||
              previous.actionSuccessType != current.actionSuccessType;
        },
        listener: (context, state) {
          final String? message =
              state.actionErrorMessage ??
              switch (state.actionSuccessType) {
                LessonDetailActionSuccessType.attended =>
                  context.l10n.lessonAttendedSuccessfully,
                LessonDetailActionSuccessType.completed =>
                  context.l10n.lessonCompletedSuccessfully,
                null => null,
              };

          if (message == null || message.trim().isEmpty) return;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));

          context.read<LessonDetailCubit>().clearActionMessages();
        },
        builder: (context, state) {
          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            body: Column(
              children: [
                AppPageHeader(
                  onBackPressed: () => Navigator.pop(context),
                  bottomPadding: AppSpacing.xxxl,
                ),
                Expanded(
                  child: _LessonDetailBody(lesson: lesson, state: state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LessonDetailBody extends StatelessWidget {
  final LessonEntity lesson;
  final LessonDetailState state;

  const _LessonDetailBody({required this.lesson, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return _LessonDetailErrorView(
        message: state.errorMessage!,
        onRetry: () {
          context.read<LessonDetailCubit>().loadLessonDetail(lesson.id);
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
          _LessonActionsCard(
            lessonId: lesson.id,
            isSubmittingAttendance: state.isSubmittingAttendance,
            isSubmittingCompletion: state.isSubmittingCompletion,
            hasAttendedInCurrentSession: state.hasAttendedInCurrentSession,
            hasCompletedInCurrentSession: state.hasCompletedInCurrentSession,
          ),
          AppGap.v20,
          _SectionTitle(title: context.l10n.lessonOverview),
          AppGap.v12,
          _InfoCard(
            child: _DescriptionBlock(
              description: detail.description,
              notes: detail.notes,
            ),
          ),
          AppGap.v20,
          _SectionTitle(title: context.l10n.lessonInformation),
          AppGap.v12,
          _InfoCard(
            child: Column(
              children: [
                _InfoTile(
                  icon: Icons.menu_book_rounded,
                  label: context.l10n.lessonCategory,
                  value: detail.category.categoryName,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoTile(
                  icon: Icons.school_rounded,
                  label: context.l10n.lessonType,
                  value: detail.isItACompleteCourse
                      ? context.l10n.completeCourse
                      : context.l10n.singleLesson,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoTile(
                  icon: Icons.live_tv_rounded,
                  label: context.l10n.liveStreaming,
                  value: detail.liveStreamingCapability
                      ? context.l10n.available
                      : context.l10n.notAvailable,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoTile(
                  icon: Icons.verified_rounded,
                  label: context.l10n.status,
                  value: detail.status,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoTile(
                  icon: Icons.visibility_rounded,
                  label: context.l10n.isPublishedLabel,
                  value: detail.isPublished
                      ? context.l10n.yes
                      : context.l10n.no,
                ),
              ],
            ),
          ),
          AppGap.v20,
          _SectionTitle(title: context.l10n.lessonTeacher),
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
                  label: context.l10n.qualification,
                  value: detail.teacher.qualification,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoTile(
                  icon: Icons.article_rounded,
                  label: context.l10n.bio,
                  value: detail.teacher.bio,
                ),
              ],
            ),
          ),
          AppGap.v20,
          _SectionTitle(title: context.l10n.linkedMosque),
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
                  label: context.l10n.addressLabel,
                  value: detail.mosque.address,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoTile(
                  icon: Icons.phone_rounded,
                  label: context.l10n.phoneNumber,
                  value: detail.mosque.phoneNumber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonActionsCard extends StatelessWidget {
  final int lessonId;
  final bool isSubmittingAttendance;
  final bool isSubmittingCompletion;
  final bool hasAttendedInCurrentSession;
  final bool hasCompletedInCurrentSession;

  const _LessonActionsCard({
    required this.lessonId,
    required this.isSubmittingAttendance,
    required this.isSubmittingCompletion,
    required this.hasAttendedInCurrentSession,
    required this.hasCompletedInCurrentSession,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBusy = isSubmittingAttendance || isSubmittingCompletion;

    final attendButton = AppButton(
      label: context.l10n.attendLesson,
      isLoading: isSubmittingAttendance,
      onPressed: isBusy || hasAttendedInCurrentSession
          ? null
          : () {
              context.read<LessonDetailCubit>().attendLesson(lessonId);
            },
      leading: const Icon(Icons.play_circle_outline_rounded),
    );

    final completeButton = AppButton(
      label: context.l10n.completeLessonAction,
      isLoading: isSubmittingCompletion,
      onPressed: isBusy || hasCompletedInCurrentSession
          ? null
          : () {
              context.read<LessonDetailCubit>().completeLesson(lessonId);
            },
      leading: const Icon(Icons.check_circle_outline_rounded),
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.9),
        boxShadow: AppShadows.subtle,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isNarrow = constraints.maxWidth < 520;

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                attendButton,
                const SizedBox(height: AppSpacing.md),
                completeButton,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: attendButton),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: completeButton),
            ],
          );
        },
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
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _StatusChip(
                label: detail.isPublished
                    ? context.l10n.published
                    : context.l10n.notPublished,
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                textColor: AppColors.white,
              ),
              _StatusChip(
                label: detail.liveStreamingCapability
                    ? context.l10n.withLiveStreaming
                    : context.l10n.withoutLiveStreaming,
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                textColor: AppColors.white,
              ),
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
                  title: context.l10n.lessonType,
                  value: detail.isItACompleteCourse
                      ? context.l10n.fullCourseShort
                      : context.l10n.singleLessonShort,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _HeroMiniStat(
                  title: context.l10n.status,
                  value: detail.status,
                ),
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
            value.trim().isNotEmpty ? value : context.l10n.unavailable,
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
        _TextBlock(label: context.l10n.lessonDescription, value: description),
        if (notes.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _TextBlock(label: context.l10n.notes, value: notes),
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
          value.trim().isNotEmpty ? value : context.l10n.unavailable,
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
                value.trim().isNotEmpty ? value : context.l10n.unavailable,
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
                title.trim().isNotEmpty ? title : context.l10n.unavailable,
                textAlign: TextAlign.end,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle.trim().isNotEmpty
                    ? subtitle
                    : context.l10n.unavailable,
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
              TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
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
        context.l10n.noLessonDetailsFound,
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
