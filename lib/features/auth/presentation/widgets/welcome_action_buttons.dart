import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_outlined_button.dart';
import '../../../../core/utils/context_extensions.dart';

class WelcomeActionButtons extends StatelessWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onGuestPressed;

  const WelcomeActionButtons({
    super.key,
    required this.onLoginPressed,
    required this.onGuestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = constraints.maxWidth < 360
            ? AppSpacing.sm
            : AppSpacing.lg;

        return Row(
          children: [
            Expanded(
              child: AppOutlinedButton(
                label: context.l10n.login,
                onPressed: onLoginPressed,
                variant: AppOutlinedButtonVariant.light,
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              child: AppButton(
                label: context.l10n.continueAsGuest,
                onPressed: onGuestPressed,
                variant: AppButtonVariant.light,
              ),
            ),
          ],
        );
      },
    );
  }
}
