import 'package:flutter/material.dart';
import 'package:seraj/features/explore/presentation/shared/widgets/explore_header.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../../core/widgets/app_gap.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../widgets/course_registration_form.dart';
import '../widgets/registration_result_dialog.dart';

class CourseRegistrationPage extends StatefulWidget {
  const CourseRegistrationPage({super.key});

  @override
  State<CourseRegistrationPage> createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  Future<void> _onSubmit() async {
    final bool isValid = _validateForm();

    if (!isValid) {
      _showFailureDialog();
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    _showSuccessDialog();
  }

  bool _validateForm() {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String username = _usernameController.text.trim();
    final String phone = _phoneController.text.trim();
    final String email = _emailController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        username.isEmpty ||
        phone.isEmpty ||
        email.isEmpty) {
      return false;
    }

    if (!phone.startsWith('09') || phone.length < 10) {
      return false;
    }

    if (!email.contains('@') || !email.contains('.')) {
      return false;
    }

    return true;
  }

  Future<void> _showSuccessDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return RegistrationResultDialog(
          isSuccess: true,
          title: context.l10n.registrationSuccessTitle,
          onClose: () => Navigator.pop(context),
        );
      },
    );
  }

  Future<void> _showFailureDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return RegistrationResultDialog(
          isSuccess: false,
          title: context.l10n.registrationFailureTitle,
          message: context.l10n.registrationFailureMessage,
          onClose: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      body: Column(
        children: [
          ExploreHeader(onBackPressed: _onBackPressed, compact: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.registrationFormTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  AppGap.v32,
                  CourseRegistrationForm(
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    usernameController: _usernameController,
                    phoneController: _phoneController,
                    emailController: _emailController,
                    onSubmit: _onSubmit,
                    isSubmitting: _isSubmitting,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
