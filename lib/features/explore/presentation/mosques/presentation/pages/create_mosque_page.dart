import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/app/di/service_locator.dart';

import '../../../../../../app/widgets/app_page_header.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_scaffold.dart';
import '../cubit/create_mosque_cubit.dart';
import '../cubit/create_mosque_state.dart';
import '../widgets/create_mosque_form.dart';

class CreateMosquePage extends StatefulWidget {
  const CreateMosquePage({super.key});

  @override
  State<CreateMosquePage> createState() => _CreateMosquePageState();
}

class _CreateMosquePageState extends State<CreateMosquePage> {
  late final TextEditingController _regionIdController;
  late final TextEditingController _nameController;
  late final TextEditingController _imamNameController;
  late final TextEditingController _khatibNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;
  late final TextEditingController _timezoneController;
  late final TextEditingController _calculationMethodController;
  late final TextEditingController _madhabController;

  @override
  void initState() {
    super.initState();
    _regionIdController = TextEditingController();
    _nameController = TextEditingController();
    _imamNameController = TextEditingController();
    _khatibNameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _latitudeController = TextEditingController(text: '0');
    _longitudeController = TextEditingController(text: '0');
    _timezoneController = TextEditingController(text: 'Asia/Damascus');
    _calculationMethodController = TextEditingController(text: '1');
    _madhabController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _regionIdController.dispose();
    _nameController.dispose();
    _imamNameController.dispose();
    _khatibNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _timezoneController.dispose();
    _calculationMethodController.dispose();
    _madhabController.dispose();
    super.dispose();
  }

  void _onCreatePressed(BuildContext context) {
    final int? regionId = int.tryParse(_regionIdController.text.trim());
    final double? latitude = double.tryParse(_latitudeController.text.trim());
    final double? longitude = double.tryParse(_longitudeController.text.trim());
    final int? calculationMethod = int.tryParse(
      _calculationMethodController.text.trim(),
    );
    final int? madhab = int.tryParse(_madhabController.text.trim());

    if (regionId == null ||
        latitude == null ||
        longitude == null ||
        calculationMethod == null ||
        madhab == null ||
        _nameController.text.trim().isEmpty ||
        _imamNameController.text.trim().isEmpty ||
        _khatibNameController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty ||
        _phoneNumberController.text.trim().isEmpty ||
        _timezoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة جميع الحقول بشكل صحيح')),
      );
      return;
    }

    context.read<CreateMosqueCubit>().createMosque(
      regionId: regionId,
      name: _nameController.text.trim(),
      imamName: _imamNameController.text.trim(),
      khatibName: _khatibNameController.text.trim(),
      address: _addressController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      latitude: latitude,
      longitude: longitude,
      timezone: _timezoneController.text.trim(),
      calculationMethod: calculationMethod,
      madhab: madhab,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CreateMosqueCubit>(),
      child: BlocConsumer<CreateMosqueCubit, CreateMosqueState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تمت إضافة المسجد بنجاح')),
            );
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            body: Column(
              children: [
                AppPageHeader(
                  onBackPressed: () => Navigator.pop(context),
                  bottomPadding: AppSpacing.xxxl,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.lg,
                      AppSpacing.xl,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CreateMosqueForm(
                          regionIdController: _regionIdController,
                          nameController: _nameController,
                          imamNameController: _imamNameController,
                          khatibNameController: _khatibNameController,
                          addressController: _addressController,
                          phoneNumberController: _phoneNumberController,
                          latitudeController: _latitudeController,
                          longitudeController: _longitudeController,
                          timezoneController: _timezoneController,
                          calculationMethodController:
                              _calculationMethodController,
                          madhabController: _madhabController,
                        ),
                        AppGap.v24,
                        AppButton(
                          label: state.isLoading
                              ? 'جاري الإضافة...'
                              : 'إضافة المسجد',
                          onPressed: state.isLoading
                              ? null
                              : () => _onCreatePressed(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
