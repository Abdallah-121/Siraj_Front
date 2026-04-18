import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class PlaceDetailContentCard extends StatelessWidget {
  final String lessonsTitle;
  final String lessonsValue;
  final String programTitle;
  final String programValue;
  final String teachersTitle;
  final String teachersValue;
  final String? extraLabel;
  final String? extraValue;
  final String? secondExtraLabel;
  final String? secondExtraValue;
  final String noteLabel;
  final String noteValue;
  final String? centerFooterText;

  const PlaceDetailContentCard({
    super.key,
    required this.lessonsTitle,
    required this.lessonsValue,
    required this.programTitle,
    required this.programValue,
    required this.teachersTitle,
    required this.teachersValue,
    this.extraLabel,
    this.extraValue,
    this.secondExtraLabel,
    this.secondExtraValue,
    required this.noteLabel,
    required this.noteValue,
    this.centerFooterText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.9),
        boxShadow: AppShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionBlock(title: lessonsTitle, value: lessonsValue),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: _SectionBlock(title: programTitle, value: programValue),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionBlock(title: teachersTitle, value: teachersValue),
          if (extraLabel != null && extraValue != null) ...[
            const SizedBox(height: AppSpacing.lg),
            _InlineInfoRow(label: extraLabel!, value: extraValue!),
          ],
          if (secondExtraLabel != null && secondExtraValue != null) ...[
            const SizedBox(height: AppSpacing.md),
            _SectionBlock(title: secondExtraLabel!, value: secondExtraValue!),
          ],
          const SizedBox(height: AppSpacing.lg),
          RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$noteLabel ',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: noteValue,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (centerFooterText != null &&
              centerFooterText!.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              centerFooterText!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final String title;
  final String value;

  const _SectionBlock({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          textAlign: TextAlign.end,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          textAlign: TextAlign.end,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}

class _InlineInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InlineInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.end,
    );
  }
}
