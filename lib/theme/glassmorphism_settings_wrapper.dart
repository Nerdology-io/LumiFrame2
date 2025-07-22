import 'package:flutter/material.dart';
import 'glassmorphism_container.dart';

class GlassmorphismSettingsWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final double horizontalPadding;
  final double blurSigma;
  final double opacity;

  const GlassmorphismSettingsWrapper({
    super.key,
    required this.child,
    this.title,
    this.horizontalPadding = 16.0, // Padding from screen edges
    this.blurSigma = 16.0,
    this.opacity = 0.18, // Default opacity for frosted glass effect
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: GlassmorphismContainer(
        borderRadius: BorderRadius.circular(20),  // Match nav shell
        blurSigma: blurSigma,
        opacity: opacity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
