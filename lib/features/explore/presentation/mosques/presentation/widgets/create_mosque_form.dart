import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
