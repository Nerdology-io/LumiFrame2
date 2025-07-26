import 'package:flutter/material.dart';
import 'dart:ui';

/// Configuration class for glassmorphism effects with multiple intensity levels
class GlassmorphismConfig {
  final double blurSigma;
  final double opacity;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final BorderRadius borderRadius;
  final double borderOpacity;
  final List<BoxShadow> shadows;
  final Color? borderColor;
  final double borderWidth;
  final bool hasInnerShadow;
  final Color? glowColor;
  final double glowBlur;

  const GlassmorphismConfig({
    required this.blurSigma,
    required this.opacity,
    required this.gradientColors,
    this.gradientStops = const [0.0, 1.0],
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.borderOpacity = 0.2,
    this.shadows = const [],
    this.borderColor,
    this.borderWidth = 1.0,
    this.hasInnerShadow = false,
    this.glowColor,
    this.glowBlur = 0.0,
  });

  /// Deep glassmorphism for main containers and dialogs
  static const deep = GlassmorphismConfig(
    blurSigma: 35.0,
    opacity: 0.12,
    gradientColors: [
      Color.fromRGBO(255, 255, 255, 0.15),
      Color.fromRGBO(255, 255, 255, 0.05),
      Color.fromRGBO(255, 255, 255, 0.02),
    ],
    gradientStops: [0.0, 0.5, 1.0],
    borderRadius: BorderRadius.all(Radius.circular(24)),
    borderOpacity: 0.3,
    borderWidth: 1.5,
    hasInnerShadow: true,
    shadows: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        blurRadius: 30,
        spreadRadius: 0,
        offset: Offset(0, 15),
      ),
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.05),
        blurRadius: 60,
        spreadRadius: 0,
        offset: Offset(0, 25),
      ),
    ],
  );

  /// Medium glassmorphism for cards and secondary containers
  static const medium = GlassmorphismConfig(
    blurSigma: 25.0,
    opacity: 0.08,
    gradientColors: [
      Color.fromRGBO(255, 255, 255, 0.12),
      Color.fromRGBO(255, 255, 255, 0.04),
    ],
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderOpacity: 0.25,
    borderWidth: 1.0,
    shadows: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.08),
        blurRadius: 20,
        spreadRadius: 0,
        offset: Offset(0, 10),
      ),
    ],
  );

  /// Light glassmorphism for buttons and small elements
  static const light = GlassmorphismConfig(
    blurSigma: 15.0,
    opacity: 0.06,
    gradientColors: [
      Color.fromRGBO(255, 255, 255, 0.1),
      Color.fromRGBO(255, 255, 255, 0.03),
    ],
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderOpacity: 0.2,
    borderWidth: 1.0,
    shadows: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.06),
        blurRadius: 15,
        spreadRadius: 0,
        offset: Offset(0, 8),
      ),
    ],
  );

  /// Subtle glassmorphism for nested elements
  static const subtle = GlassmorphismConfig(
    blurSigma: 10.0,
    opacity: 0.04,
    gradientColors: [
      Color.fromRGBO(255, 255, 255, 0.08),
      Color.fromRGBO(255, 255, 255, 0.02),
    ],
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderOpacity: 0.15,
    borderWidth: 0.5,
    shadows: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.04),
        blurRadius: 10,
        spreadRadius: 0,
        offset: Offset(0, 5),
      ),
    ],
  );

  /// Intense glassmorphism for modals and overlays
  static const intense = GlassmorphismConfig(
    blurSigma: 45.0,
    opacity: 0.16,
    gradientColors: [
      Color.fromRGBO(255, 255, 255, 0.2),
      Color.fromRGBO(255, 255, 255, 0.08),
      Color.fromRGBO(255, 255, 255, 0.03),
    ],
    gradientStops: [0.0, 0.6, 1.0],
    borderRadius: BorderRadius.all(Radius.circular(28)),
    borderOpacity: 0.4,
    borderWidth: 2.0,
    hasInnerShadow: true,
    shadows: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.15),
        blurRadius: 40,
        spreadRadius: 0,
        offset: Offset(0, 20),
      ),
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.08),
        blurRadius: 80,
        spreadRadius: 0,
        offset: Offset(0, 35),
      ),
    ],
  );

  /// Create a dark mode variant of this configuration
  GlassmorphismConfig darkMode() {
    return GlassmorphismConfig(
      blurSigma: blurSigma,
      opacity: opacity * 0.8, // Slightly less opacity for dark mode
      gradientColors: gradientColors.map((color) {
        // Convert white-based gradients to black-based for dark mode
        if (color.red > 200 && color.green > 200 && color.blue > 200) {
          return Color.fromRGBO(0, 0, 0, color.opacity * 1.2);
        }
        return color;
      }).toList(),
      gradientStops: gradientStops,
      borderRadius: borderRadius,
      borderOpacity: borderOpacity * 0.9,
      shadows: shadows.map((shadow) => BoxShadow(
        color: shadow.color.withOpacity(shadow.color.opacity * 1.5),
        blurRadius: shadow.blurRadius,
        spreadRadius: shadow.spreadRadius,
        offset: shadow.offset,
      )).toList(),
      borderColor: borderColor,
      borderWidth: borderWidth,
      hasInnerShadow: hasInnerShadow,
      glowColor: glowColor,
      glowBlur: glowBlur,
    );
  }

  /// Create a tinted variant with a specific color
  GlassmorphismConfig withTint(Color tintColor, double tintStrength) {
    return GlassmorphismConfig(
      blurSigma: blurSigma,
      opacity: opacity,
      gradientColors: gradientColors.map((color) {
        return Color.lerp(color, tintColor.withOpacity(color.opacity), tintStrength) ?? color;
      }).toList(),
      gradientStops: gradientStops,
      borderRadius: borderRadius,
      borderOpacity: borderOpacity,
      shadows: shadows,
      borderColor: borderColor ?? tintColor.withOpacity(borderOpacity),
      borderWidth: borderWidth,
      hasInnerShadow: hasInnerShadow,
      glowColor: glowColor ?? tintColor.withOpacity(0.3),
      glowBlur: glowBlur > 0 ? glowBlur : 8.0,
    );
  }

  /// Create a variant with custom border radius
  GlassmorphismConfig withBorderRadius(BorderRadius radius) {
    return GlassmorphismConfig(
      blurSigma: blurSigma,
      opacity: opacity,
      gradientColors: gradientColors,
      gradientStops: gradientStops,
      borderRadius: radius,
      borderOpacity: borderOpacity,
      shadows: shadows,
      borderColor: borderColor,
      borderWidth: borderWidth,
      hasInnerShadow: hasInnerShadow,
      glowColor: glowColor,
      glowBlur: glowBlur,
    );
  }

  /// Create a variant with enhanced glow effect
  GlassmorphismConfig withGlow(Color glowColor, double glowBlur) {
    final enhancedShadows = List<BoxShadow>.from(shadows);
    enhancedShadows.insert(0, BoxShadow(
      color: glowColor.withOpacity(0.3),
      blurRadius: glowBlur,
      spreadRadius: 2,
      offset: Offset.zero,
    ));

    return GlassmorphismConfig(
      blurSigma: blurSigma,
      opacity: opacity,
      gradientColors: gradientColors,
      gradientStops: gradientStops,
      borderRadius: borderRadius,
      borderOpacity: borderOpacity,
      shadows: enhancedShadows,
      borderColor: borderColor ?? glowColor.withOpacity(borderOpacity * 1.5),
      borderWidth: borderWidth,
      hasInnerShadow: hasInnerShadow,
      glowColor: glowColor,
      glowBlur: glowBlur,
    );
  }
}

/// Glassmorphism style presets for different UI components
class GlassmorphismStyle {
  static const dialog = GlassmorphismConfig.intense;
  static const card = GlassmorphismConfig.medium;
  static const button = GlassmorphismConfig.light;
  static const input = GlassmorphismConfig.light;
  static const container = GlassmorphismConfig.medium;
  static const navigation = GlassmorphismConfig.deep;
  static const overlay = GlassmorphismConfig.intense;
  static const panel = GlassmorphismConfig.deep;
  static const modal = GlassmorphismConfig.intense;
  static const floating = GlassmorphismConfig.medium;
}
