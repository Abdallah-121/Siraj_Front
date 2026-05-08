import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/features/auth/domain/entities/auth_session_entity.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_action_section.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/lesson_list_section.dart';
import 'package:seraj/features/explore/presentation/mosques/presentation/widgets/mosque_quick_info_card.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_header_image.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_title_section.dart';
import 'package:seraj/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:seraj/features/lessons/presentation/cubit/lessons_state.dart';
import 'package:seraj/features/teachers/domain/entites/mosque_teacher_entity.dart';
import 'package:seraj/features/teachers/presentation/cubit/mosque_teachers_cubit.dart';
import 'package:seraj/features/teachers/presentation/cubit/mosque_teachers_state.dart';
import 'package:seraj/features/teachers/presentation/cubit/teacher_promotion_cubit.dart';
import 'package:seraj/features/teachers/presentation/widgets/promote_teacher_dialog.dart';

import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_scaffold.dart';

class MosqueDetailPage extends StatelessWidget {
  const MosqueDetailPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFavoritePressed(BuildContext context) {}

  bool _isAdmin(AuthSessionEntity session) {
    return session.roleName.trim().toLowerCase() == 'admin';
  }

  bool _isMosqueManager(AuthSessionEntity session) {
    return session.roleName.trim().toLowerCase() == 'mosquemanager';
  }

  bool _isTeacher(AuthSessionEntity session) {
    return session.roleName.trim().toLowerCase() == 'teacher';
  }

  bool _isManagerOfMosque({
    required AuthSessionEntity session,
    required MosqueEntity mosque,
  }) {
    final managerUserId = mosque.managerUserId?.trim().toLowerCase();
    final currentUserId = session.userId.trim().toLowerCase();

    return managerUserId != null &&
        managerUserId.isNotEmpty &&
        managerUserId == currentUserId;
  }

  bool _isTeacherOfMosque({
    required AuthSessionEntity session,
    required List<MosqueTeacherEntity> teachers,
  }) {
    final currentUserId = session.userId.trim().toLowerCase();
    final currentTeacherId = session.teacherId;

    return teachers.any((teacher) {
      final sameUser = teacher.userId.trim().toLowerCase() == currentUserId;

      final sameTeacherId =
          currentTeacherId != null && teacher.teacherId == currentTeacherId;

      return teacher.isActive &&
          teacher.isVerified &&
          teacher.hasPermission &&
          (sameUser || sameTeacherId);
    });
  }

  bool _canPromoteTeacher({
    required AuthSessionEntity? session,
    required MosqueEntity mosque,
  }) {
    if (session == null) return false;

    if (_isAdmin(session)) return true;

    if (_isMosqueManager(session)) {
      return _isManagerOfMosque(session: session, mosque: mosque);
    }

    return false;
  }

  bool _canCreateLesson({
    required AuthSessionEntity? session,
    required MosqueEntity mosque,
    required List<MosqueTeacherEntity> teachers,
  }) {
    if (session == null) return false;

    if (_isAdmin(session)) return true;

    if (_isMosqueManager(session)) {
      return _isManagerOfMosque(session: session, mosque: mosque);
    }

    if (_isTeacher(session)) {
      return _isTeacherOfMosque(session: session, teachers: teachers);
    }

    return false;
  }

  Future<void> _onPromoteTeacherPressed({
    required BuildContext context,
    required MosqueEntity mosque,
  }) async {
    final bool? saved = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider<TeacherPromotionCubit>(
          create: (_) => sl<TeacherPromotionCubit>(),
          child: PromoteTeacherDialog(mosqueId: mosque.id),
        );
      },
    );

    if (saved != true || !context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.l10n.teacherSavedSuccessfully)),
      );

    context.read<MosqueTeachersCubit>().loadTeachersByMosque(
      mosqueId: mosque.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MosqueEntity mosque =
        ModalRoute.of(context)!.settings.arguments as MosqueEntity;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              sl<LessonsCubit>()..loadMosqueLessons(mosqueId: mosque.id),
        ),
        BlocProvider(
          create: (_) =>
              sl<MosqueTeachersCubit>()
                ..loadTeachersByMosque(mosqueId: mosque.id),
        ),
      ],
      child: AppScaffold(
        useSafeArea: true,
        bodyPadding: EdgeInsets.zero,
        body: Column(
          children: [
            BlocBuilder<MosqueTeachersCubit, MosqueTeachersState>(
              builder: (context, teachersState) {
                final session = context.watch<AuthSessionCubit>().state.session;

                final bool canPromoteTeacher = _canPromoteTeacher(
                  session: session,
                  mosque: mosque,
                );

                return DetailHeaderImage(
                  imageUrl: mosque.imageUrl,
                  onBackPressed: () => _onBackPressed(context),
                  onFavoritePressed: () => _onFavoritePressed(context),
                  isFavorite: true,
                  leadingActions: [
                    if (canPromoteTeacher)
                      HeaderCircleIconButton(
                        icon: Icons.person_add_alt_1_rounded,
                        iconColor: AppColors.primary,
                        tooltip: context.l10n.promoteUserToTeacher,
                        onPressed: () => _onPromoteTeacherPressed(
                          context: context,
                          mosque: mosque,
                        ),
                      ),
                  ],
                );
              },
            ),
            Expanded(
              child: BlocConsumer<LessonsCubit, LessonsState>(
                listenWhen: (previous, current) {
                  return previous.actionErrorMessage !=
                          current.actionErrorMessage ||
                      previous.actionSuccessType != current.actionSuccessType;
                },
                listener: (context, state) {
                  final String? message =
                      state.actionErrorMessage ??
                      switch (state.actionSuccessType) {
                        LessonActionSuccessType.published =>
                          context.l10n.lessonPublishedSuccessfully,
                        LessonActionSuccessType.unpublished =>
                          context.l10n.lessonUnpublishedSuccessfully,
                        null => null,
                      };

                  if (message == null || message.trim().isEmpty) return;

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));

                  context.read<LessonsCubit>().clearActionMessages();
                },
                builder: (context, lessonsState) {
                  return BlocBuilder<MosqueTeachersCubit, MosqueTeachersState>(
                    builder: (context, teachersState) {
                      final session = context
                          .watch<AuthSessionCubit>()
                          .state
                          .session;

                      final bool canCreateLesson = _canCreateLesson(
                        session: session,
                        mosque: mosque,
                        teachers: teachersState.teachers,
                      );

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
                              lessons: lessonsState.lessons,
                              canCreateLesson: canCreateLesson,
                              onLessonCreated: () {
                                context.read<LessonsCubit>().loadMosqueLessons(
                                  mosqueId: mosque.id,
                                );
                              },
                            ),
                            AppGap.v20,
                            LessonListSection(
                              mosque: mosque,
                              state: lessonsState,
                            ),
                          ],
                        ),
                      );
                    },
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
