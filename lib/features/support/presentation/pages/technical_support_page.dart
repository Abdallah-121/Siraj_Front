import 'package:flutter/material.dart';

import '../../../../app/widgets/app_page_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/support_result_dialog.dart';
import '../widgets/technical_support_form.dart';

class TechnicalSupportPage extends StatefulWidget {
  const TechnicalSupportPage({super.key});

  @override
  State<TechnicalSupportPage> createState() => _TechnicalSupportPageState();
}

class _TechnicalSupportPageState extends State<TechnicalSupportPage> {
  late final TextEditingController _messageController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  Future<void> _onSubmit() async {
    final String message = _messageController.text.trim();

    if (message.isEmpty) {
      _showFailureDialog();
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    _showSuccessDialog();
  }

  Future<void> _showSuccessDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return SupportResultDialog(
          isSuccess: true,
          title: context.l10n.problemSentSuccessfully,
          onClose: () => Navigator.pop(context),
        );
      },
    );
  }

  Future<void> _showFailureDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return SupportResultDialog(
          isSuccess: false,
          title: context.l10n.problemSendFailed,
          message: context.l10n.problemSendFailedMessage,
          onClose: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: true,
      resizeToAvoidBottomInset: true,
      bodyPadding: EdgeInsets.zero,
      body: Column(
        children: [
          AppPageHeader(
            onBackPressed: _onBackPressed,
            bottomPadding: AppSpacing.xl,
          ),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.technicalSupportWelcomeTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    AppGap.v32,
                    Text(
                      context.l10n.technicalSupportDescription,
                      textAlign: TextAlign.end,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.black54),
                    ),
                    AppGap.v16,
                    TechnicalSupportForm(
                      messageController: _messageController,
                      onSubmit: _onSubmit,
                      hintText: context.l10n.yourProblem,
                      buttonLabel: context.l10n.sendProblem,
                      isSubmitting: _isSubmitting,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
