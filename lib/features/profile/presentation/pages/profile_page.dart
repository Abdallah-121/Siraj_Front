import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/cubit/auth_session_cubit.dart';
import '../../../settings/presentation/widgets/logout_confirmation_dialog.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_menu_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MainNavItem _currentItem = MainNavItem.bookmarks;

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    switch (item) {
      case MainNavItem.home:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      case MainNavItem.search:
        Navigator.pushReplacementNamed(context, RouteNames.search);
        break;
      case MainNavItem.settings:
        Navigator.pushReplacementNamed(context, RouteNames.settings);
        break;
      default:
        setState(() {
          _currentItem = item;
        });
        break;
    }
  }

  void _onEditProfilePressed() {
    Navigator.pushNamed(context, RouteNames.editProfile);
  }

  void _onCurrentCoursesPressed() {
    Navigator.pushNamed(context, RouteNames.currentCourses);
  }

  void _onCompletedCoursesPressed() {
    Navigator.pushNamed(context, RouteNames.completedCourses);
  }

  Future<void> _onLogoutPressed() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return LogoutConfirmationDialog(
          title: context.l10n.confirmLogoutTitle,
          yesLabel: context.l10n.yes,
          noLabel: context.l10n.no,
          onClose: () => Navigator.pop(context),
          onCancel: () => Navigator.pop(context),
          onConfirm: () async {
            Navigator.pop(context);

            await context.read<AuthSessionCubit>().logout();

            if (!mounted) return;

            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.welcome,
              (route) => false,
              arguments: true,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthSessionCubit>().state;
    final session = authState.session;

    final String userName = session?.fullName.trim().isNotEmpty == true
        ? session!.fullName
        : context.l10n.sampleUserName;

    final String email = session?.email.trim().isNotEmpty == true
        ? session!.email
        : context.l10n.sampleUserEmail;

    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: MainBottomNavBar(
        currentItem: _currentItem,
        onItemSelected: _onBottomNavItemSelected,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppGap.v16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                width: 44,
                height: 44,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ProfileHeaderCard(
            userName: userName,
            email: email,
            imageUrl: session?.profileImage ?? '',
            buttonLabel: context.l10n.editProfileButton,
            onEditPressed: _onEditProfilePressed,
            onPickImage: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.md),
                  ProfileMenuTile(
                    title: context.l10n.favorites,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.favoriteMosques);
                    },
                  ),
                  ProfileMenuTile(
                    title: context.l10n.currentLessons,
                    onTap: _onCurrentCoursesPressed,
                  ),
                  ProfileMenuTile(
                    title: context.l10n.completedLessons,
                    onTap: _onCompletedCoursesPressed,
                  ),
                  ProfileMenuTile(
                    title: context.l10n.changeLanguage,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.changeLanguage);
                    },
                  ),
                  ProfileMenuTile(
                    title: context.l10n.technicalSupport,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.technicalSupport);
                    },
                  ),
                  const SizedBox(height: 56),
                  InkWell(
                    onTap: _onLogoutPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            color: AppColors.success,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            context.l10n.logoutFromApp,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
