import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/utils/context_extensions.dart';
import 'forgot_password_text_button.dart';
import 'google_sign_in_button.dart';

class LoginForm extends StatefulWidget {
  final Future<void> Function(String email, String password)? onLoginPressed;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onForgotPasswordPressed;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onLoginPressed,
    this.onGooglePressed,
    this.onForgotPasswordPressed,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _submit() async {
    await widget.onLoginPressed?.call(
      _emailController.text.trim(),
      _passwordController.text,
    );
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
        AppGap.v16,
        AppTextField(
          label: context.l10n.password,
          hintText: context.l10n.enterPassword,
          controller: _passwordController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          suffixIcon: IconButton(
            onPressed: _togglePasswordVisibility,
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
        ),
        AppGap.v12,
        ForgotPasswordTextButton(onPressed: widget.onForgotPasswordPressed),
        AppGap.v24,
        AppButton(
          label: context.l10n.login,
          onPressed: _submit,
          isLoading: widget.isLoading,
        ),
        AppGap.v16,
        _AuthDivider(label: context.l10n.or),
        AppGap.v16,
        GoogleSignInButton(onPressed: widget.onGooglePressed),
      ],
    );
  }
}

class _AuthDivider extends StatelessWidget {
  final String label;

  const _AuthDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
