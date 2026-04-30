import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../domain/entities/register_draft_entity.dart';

class RegisterForm extends StatefulWidget {
  final void Function(RegisterDraftEntity draft, String confirmPassword)?
  onRegisterPressed;

  const RegisterForm({super.key, required this.onRegisterPressed});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  DateTime? _selectedBirthDate;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _birthDateController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
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

  Future<void> _pickBirthDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedBirthDate ?? DateTime(now.year - 18);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 20),
    );

    if (picked == null) return;

    setState(() {
      _selectedBirthDate = picked;
      _birthDateController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    });
  }

  void _submit() {
    final draft = RegisterDraftEntity(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: _phoneController.text.trim(),
      birthDate: _selectedBirthDate,
    );

    widget.onRegisterPressed?.call(draft, _confirmPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: context.l10n.firstName,
          hintText: context.l10n.enterFirstName,
          controller: _firstNameController,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
        AppGap.v16,
        AppTextField(
          label: context.l10n.lastName,
          hintText: context.l10n.enterLastName,
          controller: _lastNameController,
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
          label: context.l10n.phoneNumber,
          hintText: context.l10n.enterPhoneNumber,
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
        AppGap.v16,
        AppTextField(
          label: context.l10n.birthDate,
          hintText: context.l10n.enterBirthDate,
          controller: _birthDateController,
          readOnly: true,
          onTap: _pickBirthDate,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.calendar_month_outlined),
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
        AppButton(label: context.l10n.createNewAccount, onPressed: _submit),
      ],
    );
  }
}
