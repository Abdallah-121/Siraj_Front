import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_empty_card.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_error_card.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_list_card.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';
import 'package:seraj/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/lessons_state.dart';

class LessonListSection extends StatelessWidget {
  final MosqueEntity mosque;
  final LessonsState state;

  const LessonListSection({
    super.key,
    required this.mosque,
    required this.state,
  });

  void _onLessonPressed(BuildContext context, LessonEntity lesson) {
    Navigator.pushNamed(context, RouteNames.lessonDetail, arguments: lesson);
  }

  bool _canManageLesson(String roleName) {
    final role = roleName.trim().toLowerCase();

    return role == 'teacher' || role == 'mosquemanager' || role == 'admin';
  }

  bool _isPublished(LessonEntity lesson) {
    return lesson.isPublished || lesson.status == 5;
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthSessionCubit>().state.session;
    final bool canManageLessons =
        session != null && _canManageLesson(session.roleName);

    final List<LessonEntity> visibleLessons = canManageLessons
        ? state.lessons
        : state.lessons.where(_isPublished).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.l10n.availableLessons,
          textAlign: TextAlign.start,
          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (state.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: CircularProgressIndicator(),
            ),
          )
        else if (state.errorMessage != null)
          LessonErrorCard(message: state.errorMessage!)
        else if (visibleLessons.isEmpty)
          LessonEmptyCard(message: context.l10n.noLessonsAvailable)
        else
          Column(
            children: visibleLessons
                .map(
                  (lesson) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: LessonListCard(
                      lesson: lesson,
                      canManageLesson: canManageLessons,
                      isPublishing: state.publishingLessonId == lesson.id,
                      isUnpublishing: state.unpublishingLessonId == lesson.id,
                      onTap: () => _onLessonPressed(context, lesson),
                      onPublishPressed: () {
                        context.read<LessonsCubit>().publishLesson(
                          lessonId: lesson.id,
                        );
                      },
                      onUnpublishPressed: () {
                        context.read<LessonsCubit>().unpublishLesson(
                          lessonId: lesson.id,
                        );
                      },
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
