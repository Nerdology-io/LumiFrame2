import 'package:flutter/material.dart';

/// Shadow effects for glassmorphism depth and glow
class ShadowEffects {
  /// Deep shadow for modals and floating elements
  static const deepShadow = [
    BoxShadow(
      color: Color(0x20000000), // 12.5% black
      blurRadius: 40,
      spreadRadius: 0,
      offset: Offset(0, 20),
    ),
    BoxShadow(
      color: Color(0x15000000), // 8% black
      blurRadius: 80,
      spreadRadius: 0,
      offset: Offset(0, 35),
    ),
  ];

  /// Medium shadow for cards and containers
  static const mediumShadow = [
    BoxShadow(
      color: Color(0x15000000), // 8% black
      blurRadius: 25,
      spreadRadius: 0,
      offset: Offset(0, 12),
    ),
    BoxShadow(
      color: Color(0x0A000000), // 4% black
      blurRadius: 50,
      spreadRadius: 0,
      offset: Offset(0, 20),
    ),
  ];

  /// Light shadow for buttons and inputs
  static const lightShadow = [
    BoxShadow(
      color: Color(0x10000000), // 6% black
      blurRadius: 15,
      spreadRadius: 0,
      offset: Offset(0, 8),
    ),
  ];

  /// Subtle shadow for nested elements
  static const subtleShadow = [
    BoxShadow(
      color: Color(0x08000000), // 3% black
      blurRadius: 10,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  /// Glow effect for interactive elements
  static List<BoxShadow> createGlow(Color color, double intensity) {
    return [
      BoxShadow(
        color: color.withOpacity(0.3 * intensity),
        blurRadius: 20 * intensity,
        spreadRadius: 2 * intensity,
        offset: Offset.zero,
      ),
      BoxShadow(
        color: color.withOpacity(0.1 * intensity),
        blurRadius: 40 * intensity,
        spreadRadius: 4 * intensity,
        offset: Offset.zero,
      ),
    ];
  }

  /// Inner shadow effect for depth
  static BoxDecoration createInnerShadow({
    required BorderRadius borderRadius,
    Color color = Colors.black,
    double opacity = 0.1,
    double blurRadius = 10,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius,
      gradient: RadialGradient(
        center: Alignment.topLeft,
        radius: 1.5,
        colors: [
          Colors.transparent,
          color.withOpacity(opacity * 0.5),
          color.withOpacity(opacity),
        ],
        stops: const [0.0, 0.7, 1.0],
      ),
    );
  }

  /// Create animated shadow for hover/press states
  static List<BoxShadow> createAnimatedShadow(
    List<BoxShadow> baseShadow,
    double progress,
  ) {
    return baseShadow.map((shadow) {
      return BoxShadow(
        color: shadow.color,
        blurRadius: shadow.blurRadius * (1 + progress * 0.5),
        spreadRadius: shadow.spreadRadius * (1 + progress * 0.3),
        offset: shadow.offset * (1 + progress * 0.2),
      );
    }).toList();
  }

  /// Create pulsing glow animation
  static List<BoxShadow> createPulsingGlow(
    Color color,
    double animationValue,
    double maxIntensity,
  ) {
    final intensity = (1 + animationValue) * maxIntensity;
    return createGlow(color, intensity);
  }

  /// Elevation-based shadow system
  static List<BoxShadow> getElevationShadow(int elevation) {
    switch (elevation) {
      case 1:
        return subtleShadow;
      case 2:
        return lightShadow;
      case 3:
        return mediumShadow;
      case 4:
      case 5:
        return deepShadow;
      default:
        return [];
    }
  }
}
