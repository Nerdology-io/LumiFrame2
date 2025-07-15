import 'package:flutter/material.dart';
import '../utils/constants.dart'; // Constants for colors; adjust if needed

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppConstants.primaryColor,
      secondary: AppConstants.accentColor,
      surface: Colors.white,
      onSurface: Colors.black87,
    ),
    cardTheme: _glassmorphicCard(Colors.white.withValues(alpha: 0.8)),
    useMaterial3: true, // Enable Material 3 for modern look
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppConstants.primaryColor,
      secondary: AppConstants.accentColor,
      surface: Colors.black87,
      onSurface: Colors.white,
    ),
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
    final hour = DateTime.now().hour;
    Color overlayColor;
    if (hour >= 6 && hour < 12) {
      overlayColor = Colors.amber[100]!; // Morning warm
    } else if (hour >= 12 && hour < 18) {
      overlayColor = Colors.blue[100]!; // Afternoon cool
    } else if (hour >= 18 && hour < 22) {
      overlayColor = Colors.orange[200]!; // Evening sunset
    } else {
      overlayColor = Colors.indigo[900]!; // Night deep
    }
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(surface: base.colorScheme.surface.mix(overlayColor, 0.1)),
    );
  }
}

extension ColorMix on Color {
  Color mix(Color other, double amount) {
    return Color.lerp(this, other, amount)!;
  }
}