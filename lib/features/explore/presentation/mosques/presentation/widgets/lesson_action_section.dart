import 'package:flutter/material.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/core/widgets/app_button.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';

class LessonActionSection extends StatelessWidget {
  final MosqueEntity mosque;
  final List<LessonEntity> lessons;
  final bool canCreateLesson;
  final VoidCallback onLessonCreated;

  const LessonActionSection({
    super.key,
    required this.mosque,
    required this.lessons,
    required this.canCreateLesson,
    required this.onLessonCreated,
  });

  @override
  Widget build(BuildContext context) {
    if (!canCreateLesson) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: AppButton(
        label: context.l10n.addLesson,
        onPressed: () async {
          final bool? created =
              await Navigator.pushNamed(
                    context,
                    RouteNames.createLesson,
                    arguments: mosque,
                  )
                  as bool?;

          if (created == true) {
            onLessonCreated();
          }
        },
      ),
    );
  }
}
