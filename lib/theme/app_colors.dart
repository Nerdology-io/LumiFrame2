import 'package:flutter/material.dart';

class AppColors {
  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFF0C0C0F);     // #0C0C0F
  static const Color darkSecondary = Color(0xFF18181A);   // #18181A
  static const Color darkAccent = Color(0xFF5B8383);      // #5B8383
  
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFFF6F6F6);    // #F6F6F6
  static const Color lightSecondary = Color(0xFFFFFFFF);  // #FFFFFF
  static const Color lightAccent = Color(0xFF357F7F);     // #357F7F
  
  // Static utility colors (work in both themes)
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  
  // Legacy colors for backward compatibility (will be context-aware via extensions)
  static const Color accent = Color(0xFF5B8383);  // Default to dark accent
  static const Color surface = Color(0xFF18181A); // Default to dark secondary
  static const Color surfaceLight = Color(0xFF2A2A2A); // Slightly lighter surface
  static const Color textSecondary = Color(0xFF9E9E9E); // Gray text
}
