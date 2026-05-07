import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_action_section.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_list_section.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/mosque_quick_info_card.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_header_image.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_title_section.dart';
import 'package:seraj/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/lessons_state.dart';

import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_scaffold.dart';

class MosqueDetailPage extends StatelessWidget {
  const MosqueDetailPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFavoritePressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final MosqueEntity mosque =
        ModalRoute.of(context)!.settings.arguments as MosqueEntity;

    return BlocProvider(
      create: (_) => sl<LessonsCubit>()..loadMosqueLessons(mosqueId: mosque.id),
      child: AppScaffold(
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          children: [
            DetailHeaderImage(
              imageUrl: mosque.imageUrl,
              onBackPressed: () => _onBackPressed(context),
              onFavoritePressed: () => _onFavoritePressed(context),
              isFavorite: true,
            ),
            Expanded(
              child: BlocBuilder<LessonsCubit, LessonsState>(
                builder: (context, state) {
                  return SingleChildScrollView(
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
                          title: mosque.name,
                          description: mosque.address.isNotEmpty
                              ? mosque.address
                              : mosque.cityName,
                        ),
                        AppGap.v24,
                        MosqueQuickInfoCard(mosque: mosque),
                        AppGap.v20,
                        LessonActionSection(
                          mosque: mosque,
                          lessons: state.lessons,
                          onLessonCreated: () {
                            context.read<LessonsCubit>().loadMosqueLessons(
                              mosqueId: mosque.id,
                            );
                          },
                        ),
                        AppGap.v20,
                        LessonListSection(mosque: mosque, state: state),
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
