import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';

class LanguageIconButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LanguageIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.changeLanguage,
      child: IconButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(AppSpacing.sm),
        visualDensity: VisualDensity.compact,
        icon: const Icon(
          Icons.language_rounded,
          color: AppColors.gold,
          size: 34,
        ),
        tooltip: context.l10n.changeLanguage,
      ),
    );
  }
}
