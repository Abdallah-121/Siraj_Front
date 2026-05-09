import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/categories/domain/entities/category_entity.dart';
import 'package:seraj/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:seraj/features/categories/presentation/cubit/categories_state.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/lessons/presentation/cubit/create_lesson_cubit.dart';
import 'package:seraj/features/lessons/presentation/widgets/create_lesson_switch_tile.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';

class CreateLessonForm extends StatefulWidget {
  final MosqueEntity mosque;
  final bool isLoading;

  const CreateLessonForm({
    super.key,
    required this.mosque,
    required this.isLoading,
  });

  @override
  State<CreateLessonForm> createState() => _CreateLessonFormState();
}

class _CreateLessonFormState extends State<CreateLessonForm> {
  late final TextEditingController _teacherIdController;
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;

  CategoryEntity? _selectedCategory;
  bool _isCompleteCourse = true;
  bool _liveStreamingCapability = true;

  @override
  void initState() {
    super.initState();
    _teacherIdController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _teacherIdController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final int? teacherId = int.tryParse(_teacherIdController.text.trim());

    if (_selectedCategory == null ||
        teacherId == null ||
        _nameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _notesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(context.l10n.pleaseFillRequiredFields)),
        );
      return;
    }

    await context.read<CreateLessonCubit>().createLesson(
      categoryId: _selectedCategory!.id,
      mosqueId: widget.mosque.id,
      teacherId: teacherId,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      notes: _notesController.text.trim(),
      isItACompleteCourse: _isCompleteCourse,
      liveStreamingCapability: _liveStreamingCapability,
    );
  }

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
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return AppDropdown<CategoryEntity>(
                  label: context.l10n.categoryName,
                  hintText: context.l10n.loading,
                  value: null,
                  items: const [],
                  enabled: false,
                  itemLabelBuilder: (category) => category.name,
                  onChanged: (_) {},
                );
              }

              if (state.errorMessage != null && state.categories.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppDropdown<CategoryEntity>(
                      label: context.l10n.categoryName,
                      hintText: context.l10n.noCategoriesFound,
                      value: null,
                      items: const [],
                      enabled: false,
                      itemLabelBuilder: (category) => category.name,
                      onChanged: (_) {},
                    ),
                    AppGap.v8,
                    TextButton(
                      onPressed: () {
                        context.read<CategoriesCubit>().loadCategories();
                      },
                      child: Text(context.l10n.retry),
                    ),
                  ],
                );
              }

              return AppDropdown<CategoryEntity>(
                label: context.l10n.categoryName,
                hintText: context.l10n.selectCategory,
                value: _selectedCategory,
                items: state.categories,
                prefixIcon: Icons.category_outlined,
                itemLabelBuilder: (category) => category.name,
                onChanged: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              );
            },
          ),
          AppGap.v16,
          AppTextField(
            label: context.l10n.teacherIdLabel,
            hintText: context.l10n.teacherIdLabel,
            controller: _teacherIdController,
            keyboardType: TextInputType.number,
          ),
          AppGap.v16,
          AppTextField(
            label: context.l10n.lessonNameLabel,
            hintText: context.l10n.lessonNameLabel,
            controller: _nameController,
          ),
          AppGap.v16,
          AppTextField(
            label: context.l10n.descriptionLabel,
            hintText: context.l10n.descriptionLabel,
            controller: _descriptionController,
            maxLines: 4,
          ),
          AppGap.v16,
          AppTextField(
            label: context.l10n.notes,
            hintText: context.l10n.notes,
            controller: _notesController,
            maxLines: 3,
          ),
          AppGap.v20,
          CreateLessonSwitchTile(
            title: context.l10n.completeCourse,
            value: _isCompleteCourse,
            onChanged: (value) {
              setState(() {
                _isCompleteCourse = value;
              });
            },
          ),
          AppGap.v12,
          CreateLessonSwitchTile(
            title: context.l10n.liveStreamingCapabilityLabel,
            value: _liveStreamingCapability,
            onChanged: (value) {
              setState(() {
                _liveStreamingCapability = value;
              });
            },
          ),
          AppGap.v24,
          AppButton(
            label: context.l10n.addLesson,
            onPressed: widget.isLoading ? null : _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
