import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';
import 'package:seraj/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/login_cubit.dart';
import 'package:seraj/features/auth/presentation/cubit/login_state.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/context_extensions.dart';
import '../widgets/auth_page_layout.dart';
import '../widgets/auth_switch_mode_text.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onGooglePressed(BuildContext context) {}

  void _onForgotPasswordPressed(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.forgotPassword);
  }

  void _onCreateAccountPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.register);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state.isSuccess && state.session != null) {
            await context.read<AuthSessionCubit>().setSession(state.session!);

            if (context.mounted) {
              Navigator.pushReplacementNamed(context, RouteNames.home);
            }
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return AuthPageLayout(
            appName: context.l10n.appName,
            title: context.l10n.loginWelcomeTitle,
            headerPadding: const EdgeInsets.fromLTRB(24, 36, 24, 20),
            headerLogoMaxWidth: 180,
            headerBottomRadius: 28,
            headerLogo: Image.asset(AppAssets.logo, fit: BoxFit.contain),
            content: LoginForm(
              isLoading: state.isLoading,
              onLoginPressed: (email, password) async {
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.pleaseFillRequiredFields),
                    ),
                  );
                  return;
                }

                await context.read<LoginCubit>().login(
                  email: email,
                  password: password,
                );
              },
              onGooglePressed: () => _onGooglePressed(context),
              onForgotPasswordPressed: () => _onForgotPasswordPressed(context),
            ),
            footer: AuthSwitchModeText(
              leadingText: context.l10n.noAccount,
              actionText: context.l10n.createNewAccount,
              onTap: () => _onCreateAccountPressed(context),
            ),
          );
        },
      ),
    );
  }
}
