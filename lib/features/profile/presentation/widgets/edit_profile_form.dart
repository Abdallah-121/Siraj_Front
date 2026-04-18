import 'package:flutter/material.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  const EditProfileForm({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldLabel(label: context.l10n.username),
        AppGap.v8,
        AppTextField(
          controller: usernameController,
          hintText: context.l10n.enterUsername,
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.email),
        AppGap.v8,
        AppTextField(
          controller: emailController,
          hintText: context.l10n.enterEmail,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.password),
        AppGap.v8,
        AppTextField(
          controller: passwordController,
          hintText: context.l10n.enterPassword,
          obscureText: true,
          prefixIcon: const Icon(Icons.visibility_outlined),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.confirmPassword),
        AppGap.v8,
        AppTextField(
          controller: confirmPasswordController,
          hintText: context.l10n.enterPasswordAgain,
          obscureText: true,
          prefixIcon: const Icon(Icons.visibility_off_outlined),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.phoneNumber),
        AppGap.v8,
        AppTextField(
          controller: phoneController,
          hintText: context.l10n.enterPhoneNumber,
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
