import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_text_field.dart';

class CreateMosqueForm extends StatelessWidget {
  final TextEditingController regionIdController;
  final TextEditingController nameController;
  final TextEditingController imamNameController;
  final TextEditingController khatibNameController;
  final TextEditingController addressController;
  final TextEditingController phoneNumberController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController timezoneController;
  final TextEditingController calculationMethodController;
  final TextEditingController madhabController;
  final File? selectedImage;
  final VoidCallback onPickImage;

  const CreateMosqueForm({
    super.key,
    required this.regionIdController,
    required this.nameController,
    required this.imamNameController,
    required this.khatibNameController,
    required this.addressController,
    required this.phoneNumberController,
    required this.latitudeController,
    required this.longitudeController,
    required this.timezoneController,
    required this.calculationMethodController,
    required this.madhabController,
    required this.selectedImage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImagePickerCard(selectedImage: selectedImage, onTap: onPickImage),
        AppGap.v16,
        AppTextField(
          controller: regionIdController,
          hintText: 'رقم المنطقة',
          keyboardType: TextInputType.number,
        ),
        AppGap.v16,
        AppTextField(controller: nameController, hintText: 'اسم المسجد'),
        AppGap.v16,
        AppTextField(controller: imamNameController, hintText: 'اسم الإمام'),
        AppGap.v16,
        AppTextField(controller: khatibNameController, hintText: 'اسم الخطيب'),
        AppGap.v16,
        AppTextField(controller: addressController, hintText: 'العنوان'),
        AppGap.v16,
        AppTextField(
          controller: phoneNumberController,
          hintText: 'رقم الهاتف',
          keyboardType: TextInputType.phone,
        ),
        AppGap.v16,
        AppTextField(
          controller: latitudeController,
          hintText: 'Latitude',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        AppGap.v16,
        AppTextField(
          controller: longitudeController,
          hintText: 'Longitude',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        AppGap.v16,
        AppTextField(controller: timezoneController, hintText: 'Timezone'),
        AppGap.v16,
        AppTextField(
          controller: calculationMethodController,
          hintText: 'Calculation Method',
          keyboardType: TextInputType.number,
        ),
        AppGap.v16,
        AppTextField(
          controller: madhabController,
          hintText: 'Madhab',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class _ImagePickerCard extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onTap;

  const _ImagePickerCard({required this.selectedImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool hasImage = selectedImage != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border),
        ),
        child: hasImage
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    child: Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
                  PositionedDirectional(
                    top: AppSpacing.md,
                    end: AppSpacing.md,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: AppColors.primary,
                        size: 21,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'اختر صورة المسجد',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'اضغط لإضافة صورة من المعرض',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
