import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../app/di/service_locator.dart';
import '../../../../../../app/widgets/app_page_header.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/app_gap.dart';
import '../../../../../../core/widgets/app_scaffold.dart';
import '../../../../../categories/domain/entities/category_entity.dart';
import '../../../../../categories/presentation/cubit/categories_cubit.dart';
import '../../../../../categories/presentation/cubit/categories_state.dart';
import '../../domain/entites/academy_entity.dart';
import '../cubit/manage_academy_cubit.dart';
import '../cubit/manage_academy_state.dart';
import '../widgets/academy_form_card.dart';

class CreateEditAcademyPage extends StatefulWidget {
  const CreateEditAcademyPage({super.key});

  @override
  State<CreateEditAcademyPage> createState() => _CreateEditAcademyPageState();
}

class _CreateEditAcademyPageState extends State<CreateEditAcademyPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _platformUrlController;
  late final TextEditingController _regionIdController;
  late final TextEditingController _specializationController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _phoneController;

  AcademyEntity? _academy;
  File? _pickedImage;
  final Set<int> _selectedCategoryIds = {};

  bool _didReadArgs = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _platformUrlController = TextEditingController();
    _regionIdController = TextEditingController();
    _specializationController = TextEditingController();
    _descriptionController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didReadArgs) return;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is AcademyEntity) {
      _academy = args;

      _nameController.text = args.name;
      _platformUrlController.text = args.platformName;
      _regionIdController.text = args.regionId.toString();
      _specializationController.text = args.specialization;
      _descriptionController.text = args.description;
      _phoneController.text = args.phoneNumber;

      _selectedCategoryIds
        ..clear()
        ..addAll(args.categories.map((category) => category.categoryId));
    }

    _didReadArgs = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _platformUrlController.dispose();
    _regionIdController.dispose();
    _specializationController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 82,
    );

    if (picked == null) return;

    setState(() {
      _pickedImage = File(picked.path);
    });
  }

  void _toggleCategory(int id) {
    setState(() {
      if (_selectedCategoryIds.contains(id)) {
        _selectedCategoryIds.remove(id);
      } else {
        _selectedCategoryIds.add(id);
      }
    });
  }

  void _submit(BuildContext providerContext) {
    final name = _nameController.text.trim();
    final platformUrl = _platformUrlController.text.trim();
    final regionId = int.tryParse(_regionIdController.text.trim());
    final specialization = _specializationController.text.trim();
    final description = _descriptionController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty ||
        regionId == null ||
        specialization.isEmpty ||
        description.isEmpty ||
        phone.isEmpty ||
        _selectedCategoryIds.isEmpty) {
      ScaffoldMessenger.of(providerContext)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(providerContext.l10n.pleaseFillRequiredFields),
          ),
        );
      return;
    }

    final cubit = providerContext.read<ManageAcademyCubit>();
    final academy = _academy;

    final categoryIds = _selectedCategoryIds.toList(growable: false);

    if (academy == null) {
      cubit.createAcademy(
        platformUrl: platformUrl,
        regionId: regionId,
        name: name,
        specialization: specialization,
        description: description,
        phoneNumber: phone,
        categoryIds: categoryIds,
        image: _pickedImage,
      );
    } else {
      cubit.updateAcademy(
        academyId: academy.id,
        platformUrl: platformUrl,
        regionId: regionId,
        name: name,
        specialization: specialization,
        description: description,
        phoneNumber: phone,
        categoryIds: categoryIds,
        image: _pickedImage,
      );
    }
  }

  String _successMessage(BuildContext context, ManageAcademyActionType type) {
    switch (type) {
      case ManageAcademyActionType.created:
        return context.l10n.academyCreatedSuccessfully;
      case ManageAcademyActionType.updated:
        return context.l10n.academyUpdatedSuccessfully;
      case ManageAcademyActionType.deleted:
        return context.l10n.academyDeletedSuccessfully;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _academy != null;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageAcademyCubit>(
          create: (_) => sl<ManageAcademyCubit>(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (_) => sl<CategoriesCubit>()..loadCategories(),
        ),
      ],
      child: BlocConsumer<ManageAcademyCubit, ManageAcademyState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));

            context.read<ManageAcademyCubit>().clearMessages();
            return;
          }

          final success = state.successAction;
          if (success == null) return;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(_successMessage(context, success))),
            );

          final updatedAcademy = state.academy;

          context.read<ManageAcademyCubit>().clearMessages();

          Navigator.pop(context, updatedAcademy ?? true);
        },
        builder: (context, manageState) {
          return AppScaffold(
            useSafeArea: true,
            bodyPadding: EdgeInsets.zero,
            body: Column(
              children: [
                AppPageHeader(
                  onBackPressed: () => Navigator.pop(context),
                  bottomPadding: AppSpacing.xxl,
                ),
                Expanded(
                  child: BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, categoriesState) {
                      final List<CategoryEntity> categories =
                          categoriesState.categories;

                      return SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.lg,
                          AppSpacing.lg,
                          AppSpacing.xl,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              isEdit
                                  ? context.l10n.academyDetails
                                  : context.l10n.addAcademy,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            AppGap.v20,
                            AcademyFormCard(
                              academy: _academy,
                              pickedImage: _pickedImage,
                              categories: categories,
                              selectedCategoryIds: _selectedCategoryIds,
                              nameController: _nameController,
                              platformUrlController: _platformUrlController,
                              regionIdController: _regionIdController,
                              specializationController:
                                  _specializationController,
                              descriptionController: _descriptionController,
                              phoneController: _phoneController,
                              onPickImage: _pickImage,
                              onToggleCategory: _toggleCategory,
                              onSubmit: () => _submit(context),
                              isSubmitting: manageState.isSubmitting,
                            ),
                          ],
                        ),
                      );
                    },
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
