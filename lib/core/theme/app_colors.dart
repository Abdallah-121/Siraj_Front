import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF0B4D2B);
  static const Color primaryDark = Color(0xFF083A20);
  static const Color primaryLight = Color(0xFF2F6E4C);

  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF0D67A);

  // Neutrals
  static const Color background = Color(0xFFF7F7F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF3F4F1);

  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF5F5F5F);
  static const Color textHint = Color(0xFFB7B7B7);

  static const Color border = Color(0xFFDADDD6);
  static const Color divider = Color(0xFFE7E9E4);

  // Feedback
  static const Color success = Color(0xFF1F7A45);
  static const Color error = Color(0xFFC0392B);
  static const Color warning = Color(0xFFD38A10);
  static const Color info = Color(0xFF2563EB);

  // Icon colors
  static const Color iconPrimary = primary;
  static const Color iconMuted = Color(0xFF6E8577);

  // Extra utility
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
}
