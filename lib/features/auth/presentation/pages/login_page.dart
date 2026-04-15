import 'package:flutter/material.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../widgets/auth_page_layout.dart';
import '../widgets/auth_switch_mode_text.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onLoginPressed(BuildContext context) {}

  void _onGooglePressed(BuildContext context) {}

  void _onForgotPasswordPressed(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.forgotPassword);
  }

  void _onCreateAccountPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.register);
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      appName: context.l10n.appName,
      title: context.l10n.loginWelcomeTitle,
      headerPadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        36,
        AppSpacing.xl,
        20,
      ),
      headerLogoMaxWidth: 180,
      headerBottomRadius: 28,
      headerLogo: Image.asset(AppAssets.logo, fit: BoxFit.contain),
      content: LoginForm(
        onLoginPressed: () => _onLoginPressed(context),
        onGooglePressed: () => _onGooglePressed(context),
        onForgotPasswordPressed: () => _onForgotPasswordPressed(context),
      ),
      footer: AuthSwitchModeText(
        leadingText: context.l10n.noAccount,
        actionText: context.l10n.createNewAccount,
        onTap: () => _onCreateAccountPressed(context),
      ),
    );
  }
}
