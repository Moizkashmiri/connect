import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF003399);
  static const Color primaryLight = Color(0xFF1A4CAD);
  static const Color primaryDark = Color(0xFF002266);

  // Secondary Colors
  static const Color secondary = Color(0xFF1867DD);
  static const Color secondaryLight = Color(0xFF4685E5);
  static const Color secondaryDark = Color(0xFF1254B8);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF000000);

  // Heading Colors
  static const Color headingPrimary = Color(0xFF003399);
  static const Color headingSecondary = Color(0xFF1867DD);
  static const Color headingLight = Color(0xFFFFFFFF);
  static const Color headingDark = Color(0xFF000000);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFFF5F5F5);
  static const Color backgroundLight = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFFBDBDBD);

  // Disabled State
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color disabledLight = Color(0xFFEEEEEE);

  // Overlay Colors
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color lightOverlay = Color(0x33000000); // 20% black

  // Gradient Colors
  static const List<Color> primaryGradient = [
    primary,
    Color(0xFF1867DD),
  ];

  static const List<Color> secondaryGradient = [
    secondary,
    Color(0xFF4685E5),
  ];
}

// Theme Extension
extension ColorSchemeExtension on ColorScheme {
  Color get customPrimary => AppColors.primary;
  Color get customSecondary => AppColors.secondary;
  Color get textPrimary => AppColors.textPrimary;
  Color get textSecondary => AppColors.textSecondary;
}