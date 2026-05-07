import 'package:flutter/material.dart';
import 'package:seraj/core/theme/app_colors.dart';
import 'package:seraj/core/theme/app_radius.dart';
import 'package:seraj/core/theme/app_shadows.dart';
import 'package:seraj/core/theme/app_spacing.dart';
import 'package:seraj/core/theme/app_text_styles.dart';
import 'package:seraj/core/utils/context_extensions.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';

class MosqueQuickInfoCard extends StatelessWidget {
  final MosqueEntity mosque;

  const MosqueQuickInfoCard({super.key, required this.mosque});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: context.l10n.imamLabel,
            value: mosque.imamName.isNotEmpty
                ? mosque.imamName
                : context.l10n.unknown,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            label: context.l10n.preacherLabel,
            value: mosque.khatibName.isNotEmpty
                ? mosque.khatibName
                : context.l10n.unknown,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            label: context.l10n.cityNameLabel,
            value: mosque.cityName.isNotEmpty
                ? mosque.cityName
                : context.l10n.unknown,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            label: context.l10n.phoneNumber,
            value: mosque.phoneNumber.isNotEmpty
                ? mosque.phoneNumber
                : context.l10n.unknown,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
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
      textAlign: TextAlign.start,
    );
  }
}
