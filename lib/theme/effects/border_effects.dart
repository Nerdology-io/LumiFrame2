import 'package:flutter/material.dart';

/// Border effects for glassmorphism elements
class BorderEffects {
  /// Create glassmorphism border with gradient effect
  static BoxDecoration createGlassBorder({
    required BorderRadius borderRadius,
    required bool isDark,
    double opacity = 0.2,
    double width = 1.0,
    Color? customColor,
    bool hasGlow = false,
    Color? glowColor,
  }) {
    final borderColor = customColor ?? 
      (isDark ? Colors.white : Colors.black).withOpacity(opacity);

    List<BoxShadow> shadows = [];
    
    if (hasGlow && glowColor != null) {
      shadows.addAll([
        BoxShadow(
          color: glowColor.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 1,
          offset: Offset.zero,
        ),
        BoxShadow(
          color: glowColor.withOpacity(0.1),
          blurRadius: 16,
          spreadRadius: 2,
          offset: Offset.zero,
        ),
      ]);
    }

    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(
        color: borderColor,
        width: width,
      ),
      boxShadow: shadows,
    );
  }

  /// Create animated border for interactive states
  static BoxDecoration createAnimatedBorder({
    required BorderRadius borderRadius,
    required bool isDark,
    required double animationProgress,
    Color? baseColor,
    Color? targetColor,
    double baseWidth = 1.0,
    double targetWidth = 2.0,
  }) {
    final color = Color.lerp(
      baseColor ?? (isDark ? Colors.white : Colors.black).withOpacity(0.2),
      targetColor ?? (isDark ? Colors.white : Colors.black).withOpacity(0.4),
      animationProgress,
    )!;

    final width = baseWidth + (targetWidth - baseWidth) * animationProgress;

    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(
        color: color,
        width: width,
      ),
    );
  }

  /// Create gradient border effect
  static Widget createGradientBorder({
    required Widget child,
    required BorderRadius borderRadius,
    required Gradient gradient,
    double width = 1.0,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: gradient,
      ),
      child: Container(
        margin: EdgeInsets.all(width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius.topLeft.x - width),
          ),
          color: Colors.transparent,
        ),
        child: child,
      ),
    );
  }

  /// Create shimmer border effect
  static BoxDecoration createShimmerBorder({
    required BorderRadius borderRadius,
    required bool isDark,
    required double animationValue,
    double baseOpacity = 0.2,
    double shimmerOpacity = 0.6,
  }) {
    final shimmerProgress = (animationValue * 2) % 1.0;
    final opacity = baseOpacity + 
      (shimmerOpacity - baseOpacity) * 
      (0.5 + 0.5 * shimmerProgress);

    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(
        color: (isDark ? Colors.white : Colors.black).withOpacity(opacity),
        width: 1.0,
      ),
    );
  }

  /// Create focus border with glow
  static BoxDecoration createFocusBorder({
    required BorderRadius borderRadius,
    required Color focusColor,
    double width = 2.0,
    double glowRadius = 8.0,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(
        color: focusColor,
        width: width,
      ),
      boxShadow: [
        BoxShadow(
          color: focusColor.withOpacity(0.3),
          blurRadius: glowRadius,
          spreadRadius: 1,
          offset: Offset.zero,
        ),
      ],
    );
  }

  /// Create error border state
  static BoxDecoration createErrorBorder({
    required BorderRadius borderRadius,
    Color errorColor = Colors.red,
    double width = 1.5,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(
        color: errorColor,
        width: width,
      ),
      boxShadow: [
        BoxShadow(
          color: errorColor.withOpacity(0.2),
          blurRadius: 6,
          spreadRadius: 1,
          offset: Offset.zero,
        ),
      ],
    );
  }

  /// Create success border state
  static BoxDecoration createSuccessBorder({
    required BorderRadius borderRadius,
    Color successColor = Colors.green,
    double width = 1.5,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(
        color: successColor,
        width: width,
      ),
      boxShadow: [
        BoxShadow(
          color: successColor.withOpacity(0.2),
          blurRadius: 6,
          spreadRadius: 1,
          offset: Offset.zero,
        ),
      ],
    );
  }
}
