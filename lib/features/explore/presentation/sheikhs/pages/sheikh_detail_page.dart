import 'package:flutter/material.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_header_image.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_info_card.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_title_section.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/register_in_course_button.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../../core/widgets/app_gap.dart';
import '../../../../../core/widgets/app_scaffold.dart';

class SheikhDetailPage extends StatelessWidget {
  const SheikhDetailPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFavoritePressed(BuildContext context) {}

  void _onRegisterPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.registrationComingSoon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<DetailInfoRowData> rows = [
      DetailInfoRowData(
        label: context.l10n.specialization,
        value: context.l10n.sampleSpecializationValue,
      ),
      DetailInfoRowData(
        label: context.l10n.availableLessons,
        value: context.l10n.sampleLessonsValue,
      ),
      DetailInfoRowData(
        label: context.l10n.studyProgram,
        value: context.l10n.sampleProgramValue,
      ),
      DetailInfoRowData(
        label: context.l10n.teachingLocations,
        value: context.l10n.sampleTeachingLocationsValue,
      ),
      DetailInfoRowData(
        label: context.l10n.contactNumber,
        value: context.l10n.sampleContactValue,
      ),
    ];

    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      body: Column(
        children: [
          DetailHeaderImage(
            onBackPressed: () => _onBackPressed(context),
            onFavoritePressed: () => _onFavoritePressed(context),
            isFavorite: false,
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
                    title: context.l10n.sampleSheikhTitle,
                    description: context.l10n.sampleSheikhDescription,
                  ),
                  AppGap.v24,
                  DetailInfoCard(rows: rows),
                  AppGap.v24,
                  RegisterInCourseButton(
                    label: context.l10n.registerWithSheikh,
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
