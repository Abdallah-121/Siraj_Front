import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_constraints.dart';
import '../../../../core/responsive/responsive_wrapper.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_scaffold.dart';
import 'auth_logo_panel.dart';
import 'auth_title_text.dart';

class AuthPageLayout extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? footer;
  final String appName;
  final String? headerSubtitle;
  final double maxWidth;
  final Widget? headerLogo;
  final EdgeInsetsGeometry? headerPadding;
  final double? headerLogoMaxWidth;
  final double? headerBottomRadius;

  const AuthPageLayout({
    super.key,
    required this.title,
    required this.content,
    required this.appName,
    this.footer,
    this.headerSubtitle,
    this.maxWidth = ResponsiveConstraints.formMaxWidth,
    this.headerLogo,
    this.headerPadding,
    this.headerLogoMaxWidth,
    this.headerBottomRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      useSafeArea: false,
      body: Column(
        children: [
          AuthLogoPanel(
            appName: appName,
            subtitle: headerSubtitle,
            logo: headerLogo,
            padding: headerPadding,
            maxLogoWidth: headerLogoMaxWidth,
            bottomRadius: headerBottomRadius,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: ResponsiveWrapper(
                maxWidth: maxWidth,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.xxl,
                  AppSpacing.xl,
                  AppSpacing.xxxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthTitleText(title: title, textAlign: TextAlign.center),
                    AppGap.v32,
                    content,
                    if (footer != null) ...[AppGap.v24, footer!],
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
