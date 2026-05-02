import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/explore/presentation/mosques/domain/entites/mosque_entity.dart';
import 'package:seraj/features/lessons/presentation/cubit/create_lesson_cubit.dart';
import 'package:seraj/features/lessons/presentation/widgets/create_lesson_switch_tile.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
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
  late final TextEditingController _categoryIdController;
  late final TextEditingController _teacherIdController;
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;

  bool _isCompleteCourse = true;
  bool _liveStreamingCapability = true;

  @override
  void initState() {
    super.initState();
    _categoryIdController = TextEditingController();
    _teacherIdController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _categoryIdController.dispose();
    _teacherIdController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final int? categoryId = int.tryParse(_categoryIdController.text.trim());
    final int? teacherId = int.tryParse(_teacherIdController.text.trim());

    if (categoryId == null ||
        teacherId == null ||
        _nameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _notesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.pleaseFillRequiredFields)),
      );
      return;
    }

    await context.read<CreateLessonCubit>().createLesson(
      categoryId: categoryId,
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
          AppTextField(
            label: context.l10n.categoryIdLabel,
            hintText: context.l10n.categoryIdLabel,
            controller: _categoryIdController,
            keyboardType: TextInputType.number,
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
            onPressed: _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
