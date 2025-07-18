import 'dart:ui'; // For ImageFilter.blur
import 'package:flutter/material.dart';

class GlassmorphismContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final bool hasBorder;
  final Widget child;
  final double blurSigma; // Customizable blur strength
  final double opacity; // Customizable opacity for frosted effect (low for semi-transparency)

  const GlassmorphismContainer({
    super.key,
    this.width,
    this.height,
    required this.borderRadius,
    this.hasBorder = false,
    required this.child,
    this.blurSigma = 10.0,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glassColor = isDark ? Colors.black.withOpacity(opacity) : Colors.white.withOpacity(opacity);

    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: Clip.hardEdge, // Clips only the blur/child, not parent shadows
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: width,
          height: height,
          color: glassColor, // Semi-transparent; no opaque background to mask effects
          child: child,
        ),
      ),
    );
  }
}