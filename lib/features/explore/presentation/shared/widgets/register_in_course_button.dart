import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_button.dart';

class RegisterInCourseButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const RegisterInCourseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(label: label, onPressed: onPressed, isLoading: isLoading);
  }
}
