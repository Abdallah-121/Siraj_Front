import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppScaffold extends StatelessWidget {
  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool useSafeArea;
  final EdgeInsetsGeometry? bodyPadding;

  const AppScaffold({
    super.key,
    this.scaffoldKey,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
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
      key: scaffoldKey,
      appBar: appBar,
      drawer: drawer,
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
