import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/core/widgets/app_button.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/lessons/domain/entities/lesson_entity.dart';

class LessonActionSection extends StatelessWidget {
  final MosqueEntity mosque;
  final List<LessonEntity> lessons;
  final VoidCallback onLessonCreated;

  const LessonActionSection({
    super.key,
    required this.mosque,
    required this.lessons,
    required this.onLessonCreated,
  });

  bool _canCreateLesson(String roleName) {
    final role = roleName.trim().toLowerCase();

    return role == 'admin' || role == 'mosquemanager' || role == 'teacher';
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthSessionCubit>().state.session;

    if (session == null || !_canCreateLesson(session.roleName)) {
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
