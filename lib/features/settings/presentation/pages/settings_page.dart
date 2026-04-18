import 'package:flutter/material.dart';
import 'package:seraj/app/local/app_locale_scope.dart';
import 'package:seraj/app/widgets/app_page_header.dart';
import 'package:seraj/app/widgets/app_section_header.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/widgets/main_bottom_nav_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/logout_confirmation_dialog.dart';
import '../widgets/settings_action_tile.dart';
import '../widgets/settings_contact_block.dart';
import '../widgets/settings_logout_button.dart';
import '../widgets/settings_section_title.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  MainNavItem _currentItem = MainNavItem.settings;

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onBottomNavItemSelected(MainNavItem item) {
    if (_currentItem == item) return;

    switch (item) {
      case MainNavItem.home:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      case MainNavItem.search:
        Navigator.pushReplacementNamed(context, RouteNames.search);
        break;
      default:
        setState(() {
          _currentItem = item;
        });
        break;
    }
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
          onConfirm: () {
            Navigator.pop(context);
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

  void _onChangeLanguagePressed() {
    AppLocaleScope.of(context).toggleLocale();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: MainBottomNavBar(
        currentItem: _currentItem,
        onItemSelected: _onBottomNavItemSelected,
      ),
      body: Column(
        children: [
          AppPageHeader(onBackPressed: _onBackPressed),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppSectionHeader(
                    title: context.l10n.settingsTitle,
                    icon: const Icon(Icons.settings_outlined, size: 30),
                  ),
                  AppGap.v24,
                  AppSectionHeader(
                    title: context.l10n.accountSection,
                    icon: const Icon(Icons.person_outline_rounded, size: 24),
                  ),
                  AppGap.v12,
                  SettingsActionTile(
                    leadingIcon: Icons.chevron_left_rounded,
                    title: context.l10n.editProfile,
                    onTap: () {},
                    showChevron: false,
                  ),
                  SettingsActionTile(
                    leadingIcon: Icons.chevron_left_rounded,
                    title: context.l10n.changePassword,
                    onTap: () {},
                    showChevron: false,
                  ),
                  AppGap.v24,
                  SettingsSectionTitle(
                    title: context.l10n.notificationsSection,
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      size: 26,
                    ),
                  ),
                  AppGap.v12,
                  SettingsActionTile(
                    leadingIcon: Icons.notifications_none_rounded,
                    title: context.l10n.latestNotifications,
                    onTap: () {},
                    showChevron: false,
                  ),
                  SettingsActionTile(
                    leadingIcon: Icons.notifications_off_outlined,
                    title: context.l10n.muteAppNotifications,
                    onTap: () {},
                    showChevron: false,
                  ),
                  AppGap.v24,
                  SettingsSectionTitle(
                    title: context.l10n.additionalSettingsSection,
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 26,
                    ),
                  ),
                  AppGap.v12,
                  SettingsActionTile(
                    leadingIcon: Icons.chevron_left_rounded,
                    title: context.l10n.changeAppLanguage,
                    onTap: _onChangeLanguagePressed,
                    showChevron: false,
                  ),
                  SettingsActionTile(
                    leadingIcon: Icons.chat_bubble_outline_rounded,
                    title: context.l10n.technicalSupport,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.technicalSupport);
                    },
                    showChevron: false,
                  ),
                  AppGap.v16,
                  SettingsContactBlock(
                    title: context.l10n.contactForSuggestions,
                    phoneNumber: '095786321457',
                  ),
                  AppGap.v40,
                  SettingsLogoutButton(
                    label: context.l10n.logoutFromApp,
                    onTap: _onLogoutPressed,
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
