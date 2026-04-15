import 'package:flutter/material.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmationCodeController;

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmationCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: context.l10n.email,
          hintText: context.l10n.enterEmail,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.mail_outline_rounded),
        ),
        AppGap.v24,
        AppTextField(
          label: context.l10n.newPassword,
          hintText: context.l10n.enterNewPassword,
          controller: _newPasswordController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          suffixIcon: IconButton(
            onPressed: _togglePasswordVisibility,
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
        ),
        AppGap.v24,
        AppTextField(
          label: context.l10n.confirmationCode,
          hintText: context.l10n.enterConfirmationCode,
          controller: _confirmationCodeController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
