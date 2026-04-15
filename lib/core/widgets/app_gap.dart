import 'package:flutter/widgets.dart';

import '../theme/app_spacing.dart';

abstract final class AppGap {
  static const Widget h4 = SizedBox(width: AppSpacing.xs);
  static const Widget h8 = SizedBox(width: AppSpacing.sm);
  static const Widget h12 = SizedBox(width: AppSpacing.md);
  static const Widget h16 = SizedBox(width: AppSpacing.lg);
  static const Widget h20 = SizedBox(width: AppSpacing.xl);
  static const Widget h24 = SizedBox(width: AppSpacing.xxl);
  static const Widget h32 = SizedBox(width: AppSpacing.xxxl);

  static const Widget v4 = SizedBox(height: AppSpacing.xs);
  static const Widget v8 = SizedBox(height: AppSpacing.sm);
  static const Widget v12 = SizedBox(height: AppSpacing.md);
  static const Widget v16 = SizedBox(height: AppSpacing.lg);
  static const Widget v20 = SizedBox(height: AppSpacing.xl);
  static const Widget v24 = SizedBox(height: AppSpacing.xxl);
  static const Widget v32 = SizedBox(height: AppSpacing.xxxl);
  static const Widget v40 = SizedBox(height: AppSpacing.xxxxl);
  static const Widget v48 = SizedBox(height: AppSpacing.section);
}
