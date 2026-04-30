import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/features/auth/presentation/cubit/register_cubit.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/register_draft_entity.dart';
import '../widgets/auth_page_layout.dart';
import '../widgets/auth_switch_mode_text.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void _onLoginPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<RegisterCubit>(),
      child: Builder(
        builder: (context) {
          return AuthPageLayout(
            appName: context.l10n.appName,
            title: context.l10n.registerTitle,
            headerPadding: const EdgeInsets.fromLTRB(24, 32, 24, 18),
            headerLogoMaxWidth: 150,
            headerBottomRadius: 28,
            headerLogo: Image.asset(AppAssets.logo, fit: BoxFit.contain),
            content: RegisterForm(
              onRegisterPressed:
                  (RegisterDraftEntity draft, String confirmPassword) {
                    if (draft.firstName.isEmpty ||
                        draft.lastName.isEmpty ||
                        draft.email.isEmpty ||
                        draft.password.isEmpty ||
                        draft.phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.pleaseFillRequiredFields),
                        ),
                      );
                      return;
                    }

                    if (draft.password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.passwordsDoNotMatch),
                        ),
                      );
                      return;
                    }
                    debugPrint('SAVE DRAFT CALLED');
                    debugPrint('Draft firstName: ${draft.firstName}');
                    debugPrint('Draft email: ${draft.email}');
                    context.read<RegisterCubit>().saveDraft(draft);

                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.accountLocation,
                    );
                  },
            ),
            footer: AuthSwitchModeText(
              leadingText: context.l10n.alreadyHaveAccount,
              actionText: context.l10n.login,
              onTap: () => _onLoginPressed(context),
            ),
          );
        },
      ),
    );
  }
}
