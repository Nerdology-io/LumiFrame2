import 'package:flutter/material.dart';
import 'dart:ui';

/// Blur effects configurations for glassmorphism
class BlurEffects {
  /// Background blur for screen overlays
  static const backgroundBlur = 45.0;
  
  /// Modal dialog blur
  static const modalBlur = 40.0;
  
  /// Container blur for cards and panels
  static const containerBlur = 25.0;
  
  /// Button and input blur
  static const elementBlur = 15.0;
  
  /// Subtle blur for nested elements
  static const subtleBlur = 8.0;

  /// Create backdrop filter with specified sigma
  static ImageFilter createBlur(double sigma) {
    return ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
  }

  /// Create layered blur effect with multiple levels
  static List<ImageFilter> createLayeredBlur(List<double> sigmas) {
    return sigmas.map((sigma) => createBlur(sigma)).toList();
  }

  /// Create animated blur for transitions
  static ImageFilter createAnimatedBlur(double progress, double maxSigma) {
    return createBlur(progress * maxSigma);
  }
}

/// Gradient effects for glassmorphism backgrounds
class GradientEffects {
  /// Aurora-inspired gradient
  static const aurora = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4C1D95), // Deep purple
      Color(0xFF7C3AED), // Purple
      Color(0xFF06B6D4), // Cyan
      Color(0xFF10B981), // Emerald
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  /// Sunset gradient
  static const sunset = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFDC2626), // Red
      Color(0xFFEA580C), // Orange
      Color(0xFFF59E0B), // Amber
      Color(0xFFEAB308), // Yellow
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  /// Ocean gradient
  static const ocean = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E40AF), // Blue
      Color(0xFF0EA5E9), // Sky
      Color(0xFF06B6D4), // Cyan
      Color(0xFF14B8A6), // Teal
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  /// Cosmic gradient
  static const cosmic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF581C87), // Purple
      Color(0xFF7C2D92), // Violet
      Color(0xFFDB2777), // Pink
      Color(0xFFDC2626), // Red
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  /// Create glass overlay gradient
  static LinearGradient createGlassGradient(Color baseColor, bool isDark) {
    if (isDark) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor.withOpacity(0.15),
          baseColor.withOpacity(0.08),
          baseColor.withOpacity(0.03),
        ],
        stops: const [0.0, 0.5, 1.0],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ],
        stops: const [0.0, 0.5, 1.0],
      );
    }
  }

  /// Create animated gradient that shifts over time
  static LinearGradient createAnimatedGradient(
    List<Color> colors,
    double animationProgress,
  ) {
    final shiftedStops = colors.asMap().entries.map((entry) {
      final index = entry.key;
      final baseStop = index / (colors.length - 1);
      final shift = (animationProgress * 0.2) % 1.0;
      return (baseStop + shift) % 1.0;
    }).toList();

    shiftedStops.sort();

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
      stops: shiftedStops,
    );
  }

  /// Create shimmer effect gradient
  static LinearGradient createShimmerGradient(double progress) {
    return LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      colors: [
        Colors.transparent,
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.2),
        Colors.white.withOpacity(0.1),
        Colors.transparent,
      ],
      stops: [
        0.0,
        progress - 0.1,
        progress,
        progress + 0.1,
        1.0,
      ],
    );
  }
}
