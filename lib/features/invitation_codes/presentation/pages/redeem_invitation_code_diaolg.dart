import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../auth/domain/entities/auth_session_entity.dart';
import '../../../auth/presentation/cubit/auth_session_cubit.dart';
import '../cubit/redeem_invitation_code_cubit.dart';
import '../cubit/redeem_invitation_code_state.dart';

class RedeemInvitationCodeDialog extends StatelessWidget {
  const RedeemInvitationCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RedeemInvitationCodeCubit>(),
      child: const _RedeemInvitationCodeDialogBody(),
    );
  }
}

class _RedeemInvitationCodeDialogBody extends StatefulWidget {
  const _RedeemInvitationCodeDialogBody();

  @override
  State<_RedeemInvitationCodeDialogBody> createState() =>
      _RedeemInvitationCodeDialogBodyState();
}

class _RedeemInvitationCodeDialogBodyState
    extends State<_RedeemInvitationCodeDialogBody> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _onRedeemPressed() async {
    final code = _codeController.text.trim();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final redeemInvitationCodeCubit = context.read<RedeemInvitationCodeCubit>();

    if (code.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('يرجى إدخال الكود')),
      );
      return;
    }

    await redeemInvitationCodeCubit.redeemCode(code: code);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: BlocConsumer<RedeemInvitationCodeCubit, RedeemInvitationCodeState>(
        listener: (context, state) async {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);
          final authSessionCubit = context.read<AuthSessionCubit>();

          if (state.errorMessage != null) {
            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }

          final result = state.result;

          if (result != null) {
            final currentSession = authSessionCubit.state.session;

            if (currentSession != null) {
              final updatedSession = AuthSessionEntity(
                userId: currentSession.userId,
                fullName: currentSession.fullName,
                email: currentSession.email,
                token: currentSession.token,
                teacherId: currentSession.teacherId,
                roleId: result.roleId,
                roleName: result.roleName,
              );

              await authSessionCubit.setSession(updatedSession);
            }

            if (!context.mounted) return;

            navigator.pop();

            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text(result.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                    const Spacer(),
                    const Text('تفعيل كود الدعوة', textAlign: TextAlign.end),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _codeController,
                  hintText: 'اكتب كود الدعوة',
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: state.isLoading ? 'جاري التفعيل...' : 'تفعيل الكود',
                  onPressed: state.isLoading ? null : _onRedeemPressed,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
