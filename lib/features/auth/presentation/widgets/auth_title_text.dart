import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_gap.dart';

class AuthTitleText extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;

  const AuthTitleText({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(title, textAlign: textAlign, style: AppTextStyles.headlineMedium),
        if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
          AppGap.v8,
          Text(
            subtitle!,
            textAlign: textAlign,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}
