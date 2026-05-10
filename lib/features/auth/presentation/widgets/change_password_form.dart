import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/change_password_cubit.dart';

class ChangePasswordForm extends StatefulWidget {
  final bool isSubmitting;

  const ChangePasswordForm({super.key, required this.isSubmitting});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;

  bool _hideCurrentPassword = true;
  bool _hideNewPassword = true;
  bool _hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmNewPassword = _confirmNewPasswordController.text.trim();

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmNewPassword.isEmpty) {
      _showMessage(context.l10n.pleaseFillRequiredFields);
      return;
    }

    if (newPassword != confirmNewPassword) {
      _showMessage(context.l10n.passwordsDoNotMatch);
      return;
    }

    if (newPassword.length < 6) {
      _showMessage(context.l10n.passwordTooShort);
      return;
    }

    context.read<ChangePasswordCubit>().changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _visibilityButton({
    required bool isHidden,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.9),
        boxShadow: AppShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: context.l10n.currentPassword,
            hintText: context.l10n.enterCurrentPassword,
            controller: _currentPasswordController,
            obscureText: _hideCurrentPassword,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: _visibilityButton(
              isHidden: _hideCurrentPassword,
              onPressed: () {
                setState(() {
                  _hideCurrentPassword = !_hideCurrentPassword;
                });
              },
            ),
          ),
          AppGap.v16,
          AppTextField(
            label: context.l10n.newPassword,
            hintText: context.l10n.enterNewPassword,
            controller: _newPasswordController,
            obscureText: _hideNewPassword,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.lock_reset_rounded),
            suffixIcon: _visibilityButton(
              isHidden: _hideNewPassword,
              onPressed: () {
                setState(() {
                  _hideNewPassword = !_hideNewPassword;
                });
              },
            ),
          ),
          AppGap.v16,
          AppTextField(
            label: context.l10n.confirmNewPassword,
            hintText: context.l10n.enterPasswordAgain,
            controller: _confirmNewPasswordController,
            obscureText: _hideConfirmPassword,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.verified_user_outlined),
            suffixIcon: _visibilityButton(
              isHidden: _hideConfirmPassword,
              onPressed: () {
                setState(() {
                  _hideConfirmPassword = !_hideConfirmPassword;
                });
              },
            ),
            onSubmitted: (_) {
              if (!widget.isSubmitting) _submit();
            },
          ),
          AppGap.v24,
          AppButton(
            label: context.l10n.changePassword,
            onPressed: widget.isSubmitting ? null : _submit,
            isLoading: widget.isSubmitting,
          ),
        ],
      ),
    );
  }
}
