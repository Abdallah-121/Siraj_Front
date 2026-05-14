import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/app/router/route_names.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/domain/entites/academy_entity.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academy_favorites_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/academy_favorites_state.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/manage_academy_cubit.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/cubit/manage_academy_state.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/widgets/academy_admin_actions_card.dart';
import 'package:seraj/features/explore/presentation/academies/presentation/widgets/academy_info_card.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_header_image.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/detail_title_section.dart';

import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_scaffold.dart';

class AcademyDetailPage extends StatefulWidget {
  const AcademyDetailPage({super.key});

  @override
  State<AcademyDetailPage> createState() => _AcademyDetailPageState();
}

class _AcademyDetailPageState extends State<AcademyDetailPage> {
  late AcademyEntity _academy;
  bool _didReadArgs = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didReadArgs) return;

    _academy = ModalRoute.of(context)!.settings.arguments as AcademyEntity;
    _didReadArgs = true;
  }

  bool _isAdmin(BuildContext context) {
    final session = context.watch<AuthSessionCubit>().state.session;
    return session?.roleName.trim().toLowerCase() == 'admin';
  }

  Future<void> _onEditPressed(BuildContext pageContext) async {
    final result = await Navigator.pushNamed(
      pageContext,
      RouteNames.createEditAcademy,
      arguments: _academy,
    );

    if (!mounted) return;

    if (result is AcademyEntity) {
      setState(() {
        _academy = result;
      });
    }
  }

  Future<void> _onDeletePressed(BuildContext pageContext) async {
    final confirmed = await showDialog<bool>(
      context: pageContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(pageContext.l10n.deleteAcademy),
          content: Text(pageContext.l10n.deleteAcademyConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(pageContext.l10n.no),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(pageContext.l10n.yes),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !pageContext.mounted) return;

    pageContext.read<ManageAcademyCubit>().deleteAcademy(_academy.id);
  }

  String _successMessage(BuildContext context, ManageAcademyActionType type) {
    switch (type) {
      case ManageAcademyActionType.created:
        return context.l10n.academyCreatedSuccessfully;
      case ManageAcademyActionType.updated:
        return context.l10n.academyUpdatedSuccessfully;
      case ManageAcademyActionType.deleted:
        return context.l10n.academyDeletedSuccessfully;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AcademyFavoritesCubit>()..loadFavoriteAcademies(),
        ),
        BlocProvider(create: (_) => sl<ManageAcademyCubit>()),
      ],
      child: Builder(
        builder: (pageContext) {
          final bool isAdmin = _isAdmin(pageContext);

          return BlocConsumer<ManageAcademyCubit, ManageAcademyState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));

                context.read<ManageAcademyCubit>().clearMessages();
                return;
              }

              final success = state.successAction;
              if (success == null) return;

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(_successMessage(context, success))),
                );

              context.read<ManageAcademyCubit>().clearMessages();

              if (success == ManageAcademyActionType.deleted) {
                Navigator.pop(context, true);
              }
            },
            builder: (context, manageState) {
              return AppScaffold(
                useSafeArea: true,
                bodyPadding: EdgeInsets.zero,
                body: Column(
                  children: [
                    BlocBuilder<AcademyFavoritesCubit, AcademyFavoritesState>(
                      builder: (context, favoritesState) {
                        return DetailHeaderImage(
                          imageUrl: _academy.imageUrl,
                          onBackPressed: () => Navigator.pop(context),
                          onFavoritePressed: () {
                            context
                                .read<AcademyFavoritesCubit>()
                                .toggleFavorite(_academy.id);
                          },
                          isFavorite: favoritesState.isFavorite(_academy.id),
                        );
                      },
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
                              title: _academy.name,
                              description: _academy.description.isNotEmpty
                                  ? _academy.description
                                  : _academy.specialization,
                            ),
                            AppGap.v24,
                            AcademyInfoCard(academy: _academy),
                            if (isAdmin) ...[
                              AppGap.v24,
                              AcademyAdminActionsCard(
                                isDeleting: manageState.isSubmitting,
                                onEditPressed: () =>
                                    _onEditPressed(pageContext),
                                onDeletePressed: () =>
                                    _onDeletePressed(pageContext),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
