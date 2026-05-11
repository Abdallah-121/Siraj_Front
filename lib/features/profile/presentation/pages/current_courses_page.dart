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

class CurrentCoursesPage extends StatefulWidget {
  const CurrentCoursesPage({super.key});

  @override
  State<CurrentCoursesPage> createState() => _CurrentCoursesPageState();
}

class _CurrentCoursesPageState extends State<CurrentCoursesPage> {
  static const int registeredStatus = 1;
  static const int attendingStatus = 2;

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
      case MainNavItem.profile:
        Navigator.pushReplacementNamed(context, RouteNames.profile);
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

  Future<void> _reloadCurrentLessons(BuildContext context) async {
    await context.read<RegisteredLessonsCubit>().loadLessonsByStatuses(
      statuses: const [registeredStatus, attendingStatus],
    );
  }

  double _progressForStatus(int status) {
    if (status == attendingStatus) return 0.65;
    return 0.25;
  }

  String _statusLabel(BuildContext context, int status) {
    if (status == attendingStatus) {
      return context.l10n.currentLessons;
    }

    return context.l10n.currentCoursesTitle;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisteredLessonsCubit>()
        ..loadLessonsByStatuses(
          statuses: const [registeredStatus, attendingStatus],
        ),
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
                      context.l10n.currentCoursesTitle,
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
                                return _CurrentCoursesErrorView(
                                  message: state.errorMessage!,
                                  onRetry: () => _reloadCurrentLessons(context),
                                );
                              }

                              if (state.lessons.isEmpty) {
                                return _CurrentCoursesEmptyView(
                                  message: context.l10n.noLessonsAvailable,
                                );
                              }

                              return RefreshIndicator(
                                onRefresh: () => _reloadCurrentLessons(context),
                                child: ListView.separated(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: state.lessons.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: AppSpacing.lg),
                                  itemBuilder: (context, index) {
                                    final lesson = state.lessons[index];

                                    return CourseProgressCard(
                                      title: lesson.lessonName.isNotEmpty
                                          ? lesson.lessonName
                                          : context.l10n.courseName,
                                      teacherLine:
                                          '${context.l10n.lessonTeacher}: ${lesson.teacherName.isNotEmpty ? lesson.teacherName : context.l10n.unknown}',
                                      timeLine:
                                          '${context.l10n.linkedMosque}: ${lesson.mosqueName.isNotEmpty ? lesson.mosqueName : context.l10n.unknown}',
                                      progress: _progressForStatus(
                                        lesson.status,
                                      ),
                                      trailingBadge: _CurrentCourseStatusBadge(
                                        label: _statusLabel(
                                          context,
                                          lesson.status,
                                        ),
                                      ),
                                      onTap: () => _onLessonPressed(lesson),
                                    );
                                  },
                                ),
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

class _CurrentCourseStatusBadge extends StatelessWidget {
  final String label;

  const _CurrentCourseStatusBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 120),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CurrentCoursesErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CurrentCoursesErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.error, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 38,
            ),
            const SizedBox(height: AppSpacing.md),
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

class _CurrentCoursesEmptyView extends StatelessWidget {
  final String message;

  const _CurrentCoursesEmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_outlined,
              color: AppColors.textSecondary.withValues(alpha: 0.75),
              size: 42,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
