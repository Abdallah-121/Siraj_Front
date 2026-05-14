import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_shadows.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../domain/entites/academy_entity.dart';

class AcademyInfoCard extends StatelessWidget {
  final AcademyEntity academy;

  const AcademyInfoCard({super.key, required this.academy});

  Future<void> _openPlatformUrl(BuildContext context) async {
    final value = academy.platformName.trim();

    if (value.isEmpty) return;

    final Uri? uri = Uri.tryParse(
      value.startsWith('http://') || value.startsWith('https://')
          ? value
          : 'https://$value',
    );

    if (uri == null) {
      _showMessage(context, context.l10n.unexpectedError);
      return;
    }

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        _showMessage(context, value);
      }
    } on PlatformException {
      if (!context.mounted) return;

      await Clipboard.setData(ClipboardData(text: uri.toString()));
      _showMessage(context, 'تم نسخ الرابط');
    } catch (_) {
      if (!context.mounted) return;

      await Clipboard.setData(ClipboardData(text: uri.toString()));
      _showMessage(context, 'تم نسخ الرابط');
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final categories = academy.categories.isEmpty
        ? context.l10n.unknown
        : academy.categories.map((e) => e.categoryName).join(' - ');

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
          _InfoRow(
            icon: Icons.category_outlined,
            label: context.l10n.availableLessons,
            value: categories,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            icon: Icons.school_outlined,
            label: context.l10n.specialization,
            value: academy.specialization.isNotEmpty
                ? academy.specialization
                : context.l10n.unknown,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            icon: Icons.location_on_outlined,
            label: context.l10n.area,
            value: academy.regionName.isNotEmpty
                ? academy.regionName
                : context.l10n.unknown,
          ),
          if (academy.cityName.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            _InfoRow(
              icon: Icons.location_city_outlined,
              label: context.l10n.cityNameLabel,
              value: academy.cityName,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            icon: Icons.phone_outlined,
            label: context.l10n.phoneNumber,
            value: academy.phoneNumber.isNotEmpty
                ? academy.phoneNumber
                : context.l10n.unknown,
          ),
          if (academy.address.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            _InfoRow(
              icon: Icons.map_outlined,
              label: context.l10n.neighborhood,
              value: academy.address,
            ),
          ],
          if (academy.platformName.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            InkWell(
              onTap: () => _openPlatformUrl(context),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  textDirection: Directionality.of(context),
                  children: [
                    const Icon(Icons.link_rounded, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        academy.platformName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.open_in_new_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: Directionality.of(context),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
