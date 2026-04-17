import 'package:flutter/material.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../widgets/auth_page_layout.dart';
import '../widgets/auth_switch_mode_text.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void _onRegisterPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.accountLocation);
  }

  void _onLoginPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      appName: context.l10n.appName,
      title: context.l10n.registerTitle,
      headerPadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        32,
        AppSpacing.xl,
        18,
      ),
      headerLogoMaxWidth: 150,
      headerBottomRadius: 28,
      headerLogo: Image.asset(AppAssets.logo, fit: BoxFit.contain),
      content: RegisterForm(
        onRegisterPressed: () => _onRegisterPressed(context),
      ),
      footer: AuthSwitchModeText(
        leadingText: context.l10n.alreadyHaveAccount,
        actionText: context.l10n.login,
        onTap: () => _onLoginPressed(context),
      ),
    );
  }
}
