import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool useSafeArea;
  final EdgeInsetsGeometry? bodyPadding;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.useSafeArea = true,
    this.bodyPadding,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = bodyPadding == null
        ? body
        : Padding(padding: bodyPadding!, child: body);

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: useSafeArea ? SafeArea(child: content) : content,
    );
  }

  static EdgeInsetsGeometry defaultHorizontalPadding() {
    return const EdgeInsets.symmetric(horizontal: AppSpacing.xl);
  }

  static EdgeInsetsGeometry defaultScreenPadding() {
    return const EdgeInsets.symmetric(
      horizontal: AppSpacing.xl,
      vertical: AppSpacing.lg,
    );
  }
}
