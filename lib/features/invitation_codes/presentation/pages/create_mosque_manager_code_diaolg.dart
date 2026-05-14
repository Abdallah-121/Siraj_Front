import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/core/widgets/app_button.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/create_invitation_code_cubit.dart';
import '../cubit/create_invitation_code_state.dart';

class CreateMosqueManagerCodeDialog extends StatelessWidget {
  const CreateMosqueManagerCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CreateInvitationCodeCubit>(),
      child: const _CreateMosqueManagerCodeDialogBody(),
    );
  }
}

class _CreateMosqueManagerCodeDialogBody extends StatefulWidget {
  const _CreateMosqueManagerCodeDialogBody();

  @override
  State<_CreateMosqueManagerCodeDialogBody> createState() =>
      _CreateMosqueManagerCodeDialogBodyState();
}

class _CreateMosqueManagerCodeDialogBodyState
    extends State<_CreateMosqueManagerCodeDialogBody> {
  late final TextEditingController _mosqueIdController;
  late final TextEditingController _expiresInDaysController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _mosqueIdController = TextEditingController();
    _expiresInDaysController = TextEditingController(text: '7');
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _mosqueIdController.dispose();
    _expiresInDaysController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onCreatePressed() {
    final int? mosqueId = int.tryParse(_mosqueIdController.text.trim());
    final int? expiresInDays = int.tryParse(
      _expiresInDaysController.text.trim(),
    );
    final String notes = _notesController.text.trim();

    if (mosqueId == null || expiresInDays == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة القيم بشكل صحيح')),
      );
      return;
    }

    context.read<CreateInvitationCodeCubit>().createCode(
      mosqueId: mosqueId,
      expiresInDays: expiresInDays,
      notes: notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: BlocConsumer<CreateInvitationCodeCubit, CreateInvitationCodeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final result = state.result;

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                      ),
                      const Spacer(),
                      const Text(
                        'توليد كود مدير مسجد',
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _mosqueIdController,
                    hintText: 'رقم المسجد',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _expiresInDaysController,
                    hintText: 'عدد أيام انتهاء الكود',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _notesController,
                    hintText: 'ملاحظات',
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: state.isLoading ? 'جاري الإنشاء...' : 'إنشاء الكود',
                    onPressed: state.isLoading ? null : _onCreatePressed,
                  ),
                  if (result != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('الكود الناتج', textAlign: TextAlign.end),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            result.code,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'ينتهي في: ${result.expiresAt}',
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          TextButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: result.code),
                              );
                            },
                            child: const Text('نسخ الكود'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
