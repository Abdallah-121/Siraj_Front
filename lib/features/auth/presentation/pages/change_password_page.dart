import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../app/widgets/app_page_header.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';
import '../widgets/change_password_form.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangePasswordCubit>(),
      child: Builder(
        builder: (pageContext) {
          return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));

                context.read<ChangePasswordCubit>().clearMessages();
                return;
              }

              if (state.isSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.passwordChangedSuccessfully),
                    ),
                  );

                context.read<ChangePasswordCubit>().clearMessages();
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return AppScaffold(
                useSafeArea: true,
                bodyPadding: EdgeInsets.zero,
                body: Column(
                  children: [
                    AppPageHeader(
                      onBackPressed: () => _onBackPressed(pageContext),
                      bottomPadding: AppSpacing.xxl,
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
                            Text(
                              context.l10n.changePassword,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            AppGap.v8,
                            Text(
                              context.l10n.changePasswordDescription,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            AppGap.v24,
                            ChangePasswordForm(
                              isSubmitting: state.isSubmitting,
                            ),
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
