import 'package:flutter/material.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController birthDateController;
  final TextEditingController cityController;
  final TextEditingController descriptionController;

  final VoidCallback onBirthDatePressed;
  final VoidCallback onCityPressed;

  const EditProfileForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.birthDateController,
    required this.cityController,
    required this.descriptionController,
    required this.onBirthDatePressed,
    required this.onCityPressed,
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
          hintText: context.l10n.enterFirstName,
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.lastName),
        AppGap.v8,
        AppTextField(
          controller: lastNameController,
          hintText: context.l10n.enterLastName,
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
        _FieldLabel(label: context.l10n.phoneNumber),
        AppGap.v8,
        AppTextField(
          controller: phoneController,
          hintText: context.l10n.enterPhoneNumber,
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.cityNameLabel),
        AppGap.v8,
        AppTextField(
          controller: cityController,
          hintText: context.l10n.searchGovernorate,
          readOnly: true,
          onTap: onCityPressed,
          prefixIcon: const Icon(Icons.location_city_outlined),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.birthDate),
        AppGap.v8,
        AppTextField(
          controller: birthDateController,
          hintText: context.l10n.enterBirthDate,
          readOnly: true,
          onTap: onBirthDatePressed,
          prefixIcon: const Icon(Icons.calendar_month_outlined),
        ),
        AppGap.v16,
        _FieldLabel(label: context.l10n.descriptionLabel),
        AppGap.v8,
        AppTextField(
          controller: descriptionController,
          hintText: context.l10n.profileDescriptionHint,
          maxLines: 4,
          prefixIcon: const Icon(Icons.notes_outlined),
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
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        label,
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
