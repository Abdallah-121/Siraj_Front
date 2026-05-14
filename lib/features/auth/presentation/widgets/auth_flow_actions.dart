import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

class AuthFlowActions extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  const AuthFlowActions({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AuthFlowCircleButton(
            onPressed: onBackPressed,
            icon: Icons.arrow_back_rounded,
            isFilled: false,
          ),
          _AuthFlowCircleButton(
            onPressed: onNextPressed,
            icon: Icons.arrow_forward_rounded,
            isFilled: true,
          ),
        ],
      ),
    );
  }
}

class _AuthFlowCircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isFilled;

  const _AuthFlowCircleButton({
    required this.onPressed,
    required this.icon,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color backgroundColor = isFilled
        ? theme.colorScheme.primary
        : Colors.transparent;
    final Color borderColor = theme.colorScheme.primary;
    final Color iconColor = isFilled ? Colors.white : theme.colorScheme.primary;

    return SizedBox(
      width: 58,
      height: 58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 1.4),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor, size: 28),
        ),
      ),
    );
  }
}
