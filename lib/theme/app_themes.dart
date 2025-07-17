import 'package:flutter/material.dart';
import '../utils/constants.dart'; // Constants for colors; adjust if needed

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppConstants.primaryColor,
      secondary: AppConstants.accentColor,
      surface: Colors.white,
      // background is deprecated; use surface instead
      // background: Colors.white,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: _glassmorphicCard(Colors.white.withValues(alpha: 0.8)),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppConstants.primaryColor,
      secondary: AppConstants.accentColor,
      surface: Colors.black,
      // background is deprecated; use surface instead
      // background: Colors.black,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    cardTheme: _glassmorphicCard(Colors.black.withValues(alpha: 0.8)),
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