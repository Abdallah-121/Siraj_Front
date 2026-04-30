import 'package:flutter/material.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_header_image.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_title_section.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/place_detail_content_card.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/register_in_course_button.dart';

import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_scaffold.dart';

class MosqueDetailPage extends StatelessWidget {
  const MosqueDetailPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFavoritePressed(BuildContext context) {}

  void _onRegisterPressed(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.courseRegistration);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      body: Column(
        children: [
          DetailHeaderImage(
            onBackPressed: () => _onBackPressed(context),
            onFavoritePressed: () => _onFavoritePressed(context),
            isFavorite: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DetailTitleSection(
                    title: context.l10n.sampleMosqueTitle,
                    description: context.l10n.sampleMosqueDescription,
                  ),
                  AppGap.v24,
                  PlaceDetailContentCard(
                    lessonsTitle: context.l10n.availableLessons,
                    lessonsValue: context.l10n.sampleLessonsMultiline,
                    programTitle: context.l10n.studyProgram,
                    programValue: context.l10n.sampleProgramMultiline,
                    teachersTitle: context.l10n.teachersAndSheikhs,
                    teachersValue: context.l10n.sampleTeachersMultiline,
                    noteLabel: context.l10n.notes,
                    noteValue: context.l10n.sampleNotesValue,
                  ),
                  AppGap.v20,
                  Text(
                    context.l10n.forMoreContactInfo,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    context.l10n.sampleContactValue,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  AppGap.v24,
                  RegisterInCourseButton(
                    label: context.l10n.registerInClass,
                    onPressed: () => _onRegisterPressed(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
