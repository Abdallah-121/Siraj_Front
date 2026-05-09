import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/lessons/presentation/cubit/create_lesson_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/create_lesson_state.dart';
import 'package:seraj/features/lessons/presentation/widgets/create_lesson_form.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../explore/presentation/shared/widgets/detail_header_image.dart';
import '../../../explore/presentation/shared/widgets/detail_title_section.dart';

class CreateLessonPage extends StatelessWidget {
  const CreateLessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MosqueEntity mosque =
        ModalRoute.of(context)!.settings.arguments as MosqueEntity;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CreateLessonCubit>()),
        BlocProvider(create: (_) => sl<CategoriesCubit>()..loadCategories()),
      ],
      child: BlocConsumer<CreateLessonCubit, CreateLessonState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context, true);
            return;
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            body: Column(
              children: [
                DetailHeaderImage(
                  onBackPressed: () => Navigator.pop(context),
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
                          title: context.l10n.addLesson,
                          description: mosque.name,
                        ),
                        AppGap.v24,
                        CreateLessonForm(
                          mosque: mosque,
                          isLoading: state.isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
