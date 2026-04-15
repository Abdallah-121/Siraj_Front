import 'package:flutter/material.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_constraints.dart';
import '../../../../core/responsive/responsive_wrapper.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/auth_logo_panel.dart';
import '../widgets/auth_title_text.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onNextPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      useSafeArea: false,
      body: Column(
        children: [
          AuthLogoPanel(
            appName: context.l10n.appName,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              32,
              AppSpacing.xl,
              18,
            ),
            maxLogoWidth: 150,
            bottomRadius: 28,
            logo: Image.asset(AppAssets.logo, fit: BoxFit.contain),
          ),
          Expanded(
            child: ResponsiveWrapper(
              maxWidth: ResponsiveConstraints.formMaxWidth,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xxl,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthTitleText(
                    title: context.l10n.forgotPasswordTitle,
                    textAlign: TextAlign.center,
                  ),
                  AppGap.v32,
                  const ForgotPasswordForm(),
                  const Spacer(),
                  _ForgotPasswordActions(
                    onBackPressed: () => _onBackPressed(context),
                    onNextPressed: () => _onNextPressed(context),
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

class _ForgotPasswordActions extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  const _ForgotPasswordActions({
    required this.onBackPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ActionCircleButton(
            onPressed: onBackPressed,
            icon: Icons.arrow_back_rounded,
            isFilled: false,
          ),
          _ActionCircleButton(
            onPressed: onNextPressed,
            icon: Icons.arrow_forward_rounded,
            isFilled: true,
          ),
        ],
      ),
    );
  }
}

class _ActionCircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isFilled;

  const _ActionCircleButton({
    required this.onPressed,
    required this.icon,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isFilled
        ? Theme.of(context).colorScheme.primary
        : Colors.transparent;
    final Color borderColor = Theme.of(context).colorScheme.primary;
    final Color iconColor = isFilled
        ? Colors.white
        : Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: 58,
      height: 58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 1.4),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor, size: 28),
        ),
      ),
    );
  }
}
