import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';

class TechnicalSupportForm extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSubmit;
  final bool isSubmitting;
  final String hintText;
  final String buttonLabel;

  const TechnicalSupportForm({
    super.key,
    required this.messageController,
    required this.onSubmit,
    required this.hintText,
    required this.buttonLabel,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3EA),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: AppColors.primary, width: 0.8),
          ),
          child: TextField(
            controller: messageController,
            maxLines: 10,
            minLines: 10,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(AppSpacing.lg),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxxl),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 190,
            child: AppButton(
              label: buttonLabel,
              onPressed: onSubmit,
              isLoading: isSubmitting,
            ),
          ),
        ),
      ],
    );
  }
}
