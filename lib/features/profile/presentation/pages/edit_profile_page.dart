import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../app/widgets/app_page_header.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/cubit/auth_session_cubit.dart';
import '../../../location/domain/entities/city_entity.dart';
import '../../../location/presentation/cubit/cities_cubit.dart';
import '../../../location/presentation/cubit/cities_state.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/profile_avatar_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final EditProfileCubit _editProfileCubit;
  late final CitiesCubit _citiesCubit;

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _cityController;
  late final TextEditingController _descriptionController;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedProfileImageFile;

  DateTime? _selectedBirthDate;
  CityEntity? _selectedCity;
  String _profileImage = '';
  bool _didFillInitialData = false;

  @override
  void initState() {
    super.initState();

    _editProfileCubit = sl<EditProfileCubit>();
    _citiesCubit = sl<CitiesCubit>()..loadCities();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _birthDateController = TextEditingController();
    _cityController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didFillInitialData) return;

    final session = context.read<AuthSessionCubit>().state.session;

    if (session != null) {
      final nameParts = session.fullName.trim().split(RegExp(r'\s+'));

      _firstNameController.text = session.firstName.trim().isNotEmpty
          ? session.firstName
          : nameParts.isNotEmpty
          ? nameParts.first
          : '';

      _lastNameController.text = session.lastName.trim().isNotEmpty
          ? session.lastName
          : nameParts.length > 1
          ? nameParts.skip(1).join(' ')
          : '';

      _emailController.text = session.email;
      _phoneController.text = session.phone;
      _descriptionController.text = session.description;
      _profileImage = session.profileImage;
      _selectedBirthDate = session.birthDate;

      if (_selectedBirthDate != null) {
        _birthDateController.text = _formatDate(_selectedBirthDate!);
      }
    }

    _didFillInitialData = true;
  }

  @override
  void dispose() {
    _editProfileCubit.close();
    _citiesCubit.close();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  Future<void> _onBirthDatePressed() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(now.year - 18),
      firstDate: DateTime(1920),
      lastDate: now,
    );

    if (picked == null) return;

    setState(() {
      _selectedBirthDate = picked;
      _birthDateController.text = _formatDate(picked);
    });
  }

  Future<void> _onCityPressed() async {
    final city = await showModalBottomSheet<CityEntity>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: _citiesCubit,
          child: const _CityPickerSheet(),
        );
      },
    );

    if (city == null) return;

    setState(() {
      _selectedCity = city;
      _cityController.text = city.name;
    });
  }

  Future<void> _onPickImagePressed() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 82,
      maxWidth: 1200,
      maxHeight: 1200,
    );

    if (pickedImage == null) return;

    setState(() {
      _selectedProfileImageFile = File(pickedImage.path);
    });
  }

  void _onSavePressed() {
    final session = context.read<AuthSessionCubit>().state.session;
    if (session == null) return;

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final description = _descriptionController.text.trim();

    final int? cityId = _selectedCity?.id ?? session.cityId;
    final DateTime? birthDate = _selectedBirthDate ?? session.birthDate;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        cityId == null ||
        birthDate == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(context.l10n.pleaseFillRequiredFields)),
        );
      return;
    }

    _editProfileCubit.updateProfile(
      session: session,
      cityId: cityId,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      profileImage: _profileImage,
      description: description,
      birthDate: birthDate,
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditProfileCubit>.value(value: _editProfileCubit),
        BlocProvider<CitiesCubit>.value(value: _citiesCubit),
      ],
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) async {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.isSuccess && state.updatedSession != null) {
            await context.read<AuthSessionCubit>().setSession(
              state.updatedSession!,
            );

            if (!context.mounted) return;

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(context.l10n.profileUpdatedSuccessfully),
                ),
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
                  onBackPressed: _onBackPressed,
                  trailing: IconButton(
                    onPressed: state.isSubmitting ? null : _onSavePressed,
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  bottomPadding: AppSpacing.xxxl,
                ),
                Transform.translate(
                  offset: const Offset(0, -34),
                  child: ProfileAvatarPicker(
                    size: 130,
                    imageUrl: _profileImage,
                    imageFile: _selectedProfileImageFile,
                    onPickImage: _onPickImagePressed,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      0,
                      AppSpacing.xl,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        EditProfileForm(
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                          birthDateController: _birthDateController,
                          cityController: _cityController,
                          descriptionController: _descriptionController,
                          onBirthDatePressed: _onBirthDatePressed,
                          onCityPressed: _onCityPressed,
                        ),
                        AppGap.v32,
                        AppButton(
                          label: state.isSubmitting
                              ? context.l10n.loading
                              : context.l10n.saveProfileChanges,
                          onPressed: state.isSubmitting ? null : _onSavePressed,
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

class _CityPickerSheet extends StatelessWidget {
  const _CityPickerSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.72,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.l10n.searchGovernorate,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
                onChanged: context.read<CitiesCubit>().searchCities,
              ),
            ),
            Expanded(
              child: BlocBuilder<CitiesCubit, CitiesState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  }

                  if (state.cities.isEmpty) {
                    return Center(child: Text(context.l10n.noCitiesFound));
                  }

                  return ListView.separated(
                    itemCount: state.cities.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final city = state.cities[index];

                      return ListTile(
                        title: Text(city.name),
                        onTap: () => Navigator.pop(context, city),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
