import 'package:flutter/material.dart';
import 'app_colors.dart';

extension LumiFrameTheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  
  // Background colors
  Color get primaryBackground => isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
  Color get secondaryBackground => isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
  
  // Accent color
  Color get accentColor => isDark ? AppColors.darkAccent : AppColors.lightAccent;
  
  // Text colors based on theme
  Color get primaryTextColor => isDark ? Colors.white : Colors.black87;
  Color get secondaryTextColor => isDark ? Colors.white70 : Colors.black54;
  
  // Glass morphism colors - Enhanced for better visibility
  Color get glassBackground => isDark 
    ? AppColors.darkSecondary.withValues(alpha: 0.4)  // Increased from 0.3
    : AppColors.lightSecondary.withValues(alpha: 0.5);  // Increased from 0.3
    
  Color get glassBorder => isDark 
    ? AppColors.darkAccent.withValues(alpha: 0.5)  // Increased from 0.3
    : AppColors.lightAccent.withValues(alpha: 0.4);  // Increased from 0.3
    
  // Surface colors for containers
  Color get surfaceColor => isDark 
    ? AppColors.darkSecondary.withValues(alpha: 0.8)
    : AppColors.lightSecondary.withValues(alpha: 0.8);
    
  // Border colors
  Color get borderColor => isDark 
    ? AppColors.darkAccent.withValues(alpha: 0.4)
    : AppColors.lightAccent.withValues(alpha: 0.4);
    
  // Selected/Active states
  Color get selectedBackground => accentColor.withValues(alpha: 0.2);
  Color get selectedBorder => accentColor;
  Color get selectedText => accentColor;
  
  // Enhanced container decoration for consistent styling
  BoxDecoration get enhancedGlassContainer => BoxDecoration(
    color: glassBackground,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: glassBorder,
      width: 1.2,
    ),
    boxShadow: [
      BoxShadow(
        color: isDark 
          ? Colors.black.withOpacity(0.3)
          : Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );
  
  // Standard content padding for containers
  EdgeInsets get standardContainerPadding => const EdgeInsets.symmetric(vertical: 24, horizontal: 20);
  EdgeInsets get standardContainerMargin => const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
}
