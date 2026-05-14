import 'package:flutter/material.dart';
import 'package:seraj/core/utils/context_extensions.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_gap.dart';
import '../../../../../core/widgets/app_text_field.dart';

class CourseRegistrationForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final VoidCallback onSubmit;
  final bool isSubmitting;

  const CourseRegistrationForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.phoneController,
    required this.emailController,
    required this.onSubmit,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldLabel(label: context.l10n.firstName),
        AppGap.v8,
        AppTextField(
          controller: firstNameController,
          hintText: context.l10n.enterArabicName,
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.lastName),
        AppGap.v8,
        AppTextField(
          controller: lastNameController,
          hintText: context.l10n.enterArabicLastName,
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.appUsername),
        AppGap.v8,
        AppTextField(
          controller: usernameController,
          hintText: context.l10n.enterAppUsername,
          prefixIcon: const Icon(Icons.person_outline_rounded),
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
        AppGap.v16,
        _FieldLabel(label: context.l10n.email),
        AppGap.v8,
        AppTextField(
          controller: emailController,
          hintText: context.l10n.enterEmail,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        AppGap.v8,
        Text(
          context.l10n.registrationAgreement,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        AppGap.v32,
        AppButton(
          label: context.l10n.confirmRegistration,
          onPressed: onSubmit,
          isLoading: isSubmitting,
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
