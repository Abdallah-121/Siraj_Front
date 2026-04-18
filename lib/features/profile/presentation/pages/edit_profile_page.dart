import 'package:flutter/material.dart';

import '../../../../app/widgets/app_page_header.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/profile_avatar_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onSavePressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: true,
      bodyPadding: EdgeInsets.zero,
      body: Column(
        children: [
          AppPageHeader(
            onBackPressed: _onBackPressed,
            trailing: IconButton(
              onPressed: _onSavePressed,
              icon: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            bottomPadding: AppSpacing.xxxl,
          ),
          Transform.translate(
            offset: const Offset(0, -34),
            child: ProfileAvatarPicker(size: 130, onPickImage: () {}),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditProfileForm(
                    usernameController: _usernameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    phoneController: _phoneController,
                  ),
                  AppGap.v32,
                  AppButton(
                    label: context.l10n.saveProfileChanges,
                    onPressed: _onSavePressed,
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
