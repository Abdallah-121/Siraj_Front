import 'package:flutter/material.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_constraints.dart';
import '../../../../core/responsive/responsive_wrapper.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/account_location_form.dart';
import '../widgets/auth_flow_actions.dart';
import '../widgets/auth_logo_panel.dart';
import '../widgets/auth_title_text.dart';

class AccountLocationPage extends StatelessWidget {
  const AccountLocationPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onNextPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.home);
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
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthTitleText(
                    title: context.l10n.accountLocationTitle,
                    textAlign: TextAlign.center,
                  ),
                  AppGap.v24,
                  const Expanded(
                    child: SingleChildScrollView(child: AccountLocationForm()),
                  ),
                  AppGap.v16,
                  AuthFlowActions(
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
