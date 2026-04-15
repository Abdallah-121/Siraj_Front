import 'package:flutter/material.dart';
import 'package:seraj/app/local/app_locale_scope.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_constraints.dart';
import '../../../../core/responsive/responsive_wrapper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';
import '../widgets/language_icon_button.dart';
import '../widgets/welcome_action_buttons.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _onChangeLanguagePressed(BuildContext context) {
    AppLocaleScope.of(context).toggleLocale();
  }

  void _onLoginPressed(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.login);
  }

  void _onGuestPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: ResponsiveWrapper(
          maxWidth: ResponsiveConstraints.widePageMaxWidth,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.xxxl,
          ),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: LanguageIconButton(
                  onPressed: () => _onChangeLanguagePressed(context),
                ),
              ),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    Image.asset(AppAssets.logo, fit: BoxFit.contain),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      context.l10n.welcomeTagline,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.goldLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: WelcomeActionButtons(
                  onLoginPressed: () => _onLoginPressed(context),
                  onGuestPressed: () => _onGuestPressed(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
