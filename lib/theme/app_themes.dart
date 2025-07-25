import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightAccent,
      secondary: AppColors.lightAccent,
      surface: AppColors.lightSecondary,
      onSurface: Colors.black87,
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightPrimary,
    cardTheme: _glassmorphicCard(AppColors.lightSecondary.withValues(alpha: 0.8)),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkAccent,
      secondary: AppColors.darkAccent,
      surface: AppColors.darkSecondary,
      onSurface: Colors.white,
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.darkPrimary,
    cardTheme: _glassmorphicCard(AppColors.darkSecondary.withValues(alpha: 0.8)),
    useMaterial3: true,
  );

  static CardThemeData _glassmorphicCard(Color color) => CardThemeData(
        color: color,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: Colors.transparent, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
      );

  static ThemeData getTimeBasedTheme(ThemeData base) {
    // No overlay: always return base for true black/white backgrounds
    return base;
  }
}

extension ColorMix on Color {
  Color mix(Color other, double amount) {
    return Color.lerp(this, other, amount)!;
  }
}