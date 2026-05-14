import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_shadows.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../categories/domain/entities/category_entity.dart';
import '../../domain/entites/academy_entity.dart';
import 'academy_category_selector.dart';
import 'academy_image_picker.dart';

class AcademyFormCard extends StatelessWidget {
  final AcademyEntity? academy;
  final File? pickedImage;
  final List<CategoryEntity> categories;
  final Set<int> selectedCategoryIds;
  final TextEditingController nameController;
  final TextEditingController platformUrlController;
  final TextEditingController regionIdController;
  final TextEditingController specializationController;
  final TextEditingController descriptionController;
  final TextEditingController phoneController;
  final VoidCallback onPickImage;
  final ValueChanged<int> onToggleCategory;
  final VoidCallback onSubmit;
  final bool isSubmitting;

  const AcademyFormCard({
    super.key,
    required this.academy,
    required this.pickedImage,
    required this.categories,
    required this.selectedCategoryIds,
    required this.nameController,
    required this.platformUrlController,
    required this.regionIdController,
    required this.specializationController,
    required this.descriptionController,
    required this.phoneController,
    required this.onPickImage,
    required this.onToggleCategory,
    required this.onSubmit,
    required this.isSubmitting,
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
          AcademyImagePicker(
            pickedImage: pickedImage,
            imageUrl: academy?.imageUrl,
            onPickPressed: onPickImage,
          ),
          AppGap.v20,
          AppTextField(
            controller: nameController,
            label: context.l10n.nameLabel,
            hintText: context.l10n.nameLabel,
            prefixIcon: const Icon(Icons.school_outlined),
          ),
          AppGap.v16,
          AppTextField(
            controller: platformUrlController,
            label: 'رابط الأكاديمية',
            hintText: 'https://example.com',
            keyboardType: TextInputType.url,
            prefixIcon: const Icon(Icons.link_rounded),
          ),
          AppGap.v16,
          AppTextField(
            controller: regionIdController,
            label: 'معرف المنطقة',
            hintText: 'RegionId',
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.location_on_outlined),
          ),
          AppGap.v16,
          AppTextField(
            controller: specializationController,
            label: context.l10n.specialization,
            hintText: context.l10n.specialization,
            prefixIcon: const Icon(Icons.category_outlined),
          ),
          AppGap.v16,
          AppTextField(
            controller: phoneController,
            label: context.l10n.phoneNumber,
            hintText: context.l10n.enterPhoneNumber,
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
          AppGap.v16,
          AppTextField(
            controller: descriptionController,
            label: context.l10n.descriptionLabel,
            hintText: context.l10n.descriptionLabel,
            maxLines: 4,
            prefixIcon: const Icon(Icons.description_outlined),
          ),
          AppGap.v20,
          AcademyCategorySelector(
            categories: categories,
            selectedCategoryIds: selectedCategoryIds,
            onToggleCategory: onToggleCategory,
          ),
          AppGap.v24,
          AppButton(
            label: academy == null
                ? context.l10n.addAcademy
                : context.l10n.saveProfileChanges,
            onPressed: onSubmit,
            isLoading: isSubmitting,
          ),
        ],
      ),
    );
  }
}
