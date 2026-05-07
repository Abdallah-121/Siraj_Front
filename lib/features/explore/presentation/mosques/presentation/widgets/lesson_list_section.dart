import 'package:flutter/material.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_empty_card.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_error_card.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_list_card.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';
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

  @override
  Widget build(BuildContext context) {
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
        else if (state.lessons.isEmpty)
          LessonEmptyCard(message: context.l10n.noLessonsAvailable)
        else
          Column(
            children: state.lessons
                .map(
                  (lesson) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: LessonListCard(
                      lesson: lesson,
                      onTap: () => _onLessonPressed(context, lesson),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
