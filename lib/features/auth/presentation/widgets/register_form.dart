import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/utils/context_extensions.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback? onRegisterPressed;

  const RegisterForm({super.key, required this.onRegisterPressed});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: context.l10n.username,
          hintText: context.l10n.enterUsername,
          controller: _userNameController,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
        AppGap.v16,
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
          textInputAction: TextInputAction.next,
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
        AppGap.v16,
        AppTextField(
          label: context.l10n.confirmPassword,
          hintText: context.l10n.enterPasswordAgain,
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          textInputAction: TextInputAction.done,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          suffixIcon: IconButton(
            onPressed: _toggleConfirmPasswordVisibility,
            icon: Icon(
              _obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
        ),
        AppGap.v24,
        AppButton(
          label: context.l10n.createNewAccount,
          onPressed: widget.onRegisterPressed,
        ),
      ],
    );
  }
}
