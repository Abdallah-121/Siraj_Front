import 'package:flutter/material.dart';

import '../../../../core/widgets/app_gap.dart';
import 'home_section_header.dart';

class HomeHorizontalSection extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final VoidCallback? onPressed;
  final bool showAction;

  const HomeHorizontalSection({
    super.key,
    required this.title,
    required this.child,
    required this.height,
    this.onPressed,
    this.showAction = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeader(
          title: title,
          onPressed: onPressed,
          showAction: showAction,
        ),
        AppGap.v12,
        SizedBox(height: height, child: child),
      ],
    );
  }
}
