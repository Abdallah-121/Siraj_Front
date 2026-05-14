import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/features/lessons/presentation/cubit/registered_lessons_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/registered_lessons_state.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/widgets/app_page_header.dart';
import '../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../lessons/domain/entities/lesson_entity.dart';
import '../../../lessons/domain/entities/registered_lesson_entity.dart';
import '../widgets/course_progress_card.dart';

class CompletedCoursesPage extends StatefulWidget {
  const CompletedCoursesPage({super.key});

  @override
  State<CompletedCoursesPage> createState() => _CompletedCoursesPageState();
}

class _CompletedCoursesPageState extends State<CompletedCoursesPage> {
  static const int completedStatus = 3;

  MainNavItem _currentItem = MainNavItem.bookmarks;

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    switch (item) {
      case MainNavItem.home:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      case MainNavItem.search:
        Navigator.pushReplacementNamed(context, RouteNames.search);
        break;
      case MainNavItem.settings:
        Navigator.pushReplacementNamed(context, RouteNames.settings);
        break;
      default:
        setState(() {
          _currentItem = item;
        });
        break;
    }
  }

  void _onLessonPressed(RegisteredLessonEntity lesson) {
    Navigator.pushNamed(
      context,
      RouteNames.lessonDetail,
      arguments: _toLessonEntity(lesson),
    );
  }

  LessonEntity _toLessonEntity(RegisteredLessonEntity lesson) {
    return LessonEntity(
      id: lesson.lessonId,
      categoryId: lesson.categoryId,
      categoryName: lesson.categoryName,
      mosqueId: lesson.mosqueId,
      mosqueName: lesson.mosqueName,
      teacherId: lesson.teacherId,
      name: lesson.lessonName,
      description: lesson.lessonDescription,
      isItCompleteCourse: false,
      isActive: lesson.lessonIsActive,
      status: lesson.status,
      isPublished: true,
      createdAt: lesson.registeredAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: lesson.updatedAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<RegisteredLessonsCubit>()
            ..loadLessonsByStatus(status: completedStatus),
      child: AppScaffold(
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        bottomNavigationBar: MainBottomNavBar(
          currentItem: _currentItem,
          onItemSelected: _onBottomNavItemSelected,
        ),
        body: Column(
          children: [
            AppPageHeader(onBackPressed: _onBackPressed),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.completedCoursesTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    AppGap.v24,
                    Expanded(
                      child:
                          BlocBuilder<
                            RegisteredLessonsCubit,
                            RegisteredLessonsState
                          >(
                            builder: (context, state) {
                              if (state.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state.errorMessage != null) {
                                return _CoursesErrorView(
                                  message: state.errorMessage!,
                                  onRetry: () {
                                    context
                                        .read<RegisteredLessonsCubit>()
                                        .loadLessonsByStatus(
                                          status: completedStatus,
                                        );
                                  },
                                );
                              }

                              if (state.lessons.isEmpty) {
                                return _CoursesEmptyView(
                                  message: context.l10n.noLessonsAvailable,
                                );
                              }

                              return ListView.separated(
                                itemCount: state.lessons.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: AppSpacing.lg),
                                itemBuilder: (context, index) {
                                  final lesson = state.lessons[index];

                                  return CourseProgressCard(
                                    title: lesson.lessonName,
                                    teacherLine:
                                        '${context.l10n.lessonTeacher}: ${lesson.teacherName}',
                                    timeLine:
                                        '${context.l10n.linkedMosque}: ${lesson.mosqueName}',
                                    progress: 1.0,
                                    trailingBadge: _StatusBadge(
                                      label: context.l10n.completedLessons,
                                      color: AppColors.success,
                                    ),
                                    onTap: () => _onLessonPressed(lesson),
                                  );
                                },
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CoursesErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CoursesErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.error),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
          ],
        ),
      ),
    );
  }
}

class _CoursesEmptyView extends StatelessWidget {
  final String message;

  const _CoursesEmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
