import 'package:flutter/material.dart';
import 'dart:ui'; // For ImageFilter

/// Reusable glassmorphism container widget.
/// Applies a semi-transparent, blurred, floating effect that adapts to light/dark themes.
/// Use for menus, cards, or overlays to allow underlying content visibility.
class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final double opacity; // Background opacity (0.0-1.0)
  final double blurSigma; // Blur strength (higher = more blur)
  final BorderRadius borderRadius; // Corner rounding
  final double? width; // Optional fixed width (e.g., for drawers)
  final double elevation; // Subtle shadow for floating feel (0 = none)
  final EdgeInsets padding; // Internal padding
  final bool hasBorder; // Add subtle theme-based border
  final bool hasGradient; // Add faint gradient overlay for depth

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.opacity = 0.3,
    this.blurSigma = 10.0,
    this.borderRadius = const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
    this.width,
    this.elevation = 0,
    this.padding = EdgeInsets.zero,
    this.hasBorder = true, // Enabled for glow in your image
    this.hasGradient = true, // Enabled for fade effect
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Material(
            elevation: elevation,
            color: Colors.transparent,
            shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.2),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: opacity),
                gradient: hasGradient
                    ? LinearGradient(
                        colors: [
                          theme.colorScheme.surface.withValues(alpha: opacity),
                          theme.colorScheme.onSurface.withValues(alpha: opacity * 0.5),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                border: hasBorder
                    ? Border.all(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                        width: 1,
                      )
                    : null,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}