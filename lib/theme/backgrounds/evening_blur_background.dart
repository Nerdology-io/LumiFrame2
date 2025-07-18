import 'dart:ui';
import 'package:flutter/material.dart';

class EveningBlurBackground extends StatelessWidget {
  const EveningBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Main multicolor gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE6E6), // pale pink
                  Color(0xFFFFB580), // warm orange
                  Color(0xFFFA709A), // sunset pink
                  Color(0xFF7F7FD5), // evening blue-purple
                ],
                stops: [0.0, 0.28, 0.68, 1.0],
              ),
            ),
          ),

          // Blurry glowing blobs
          const Positioned(
            left: -70,
            top: -90,
            child: _BlurBlob(
              diameter: 210,
              color: Color(0xFFFFA69E),
              opacity: 0.45,
              blurSigma: 88,
            ),
          ),
          const Positioned(
            right: 0,
            top: 110,
            child: _BlurBlob(
              diameter: 160,
              color: Color(0xFFFFCC80),
              opacity: 0.39,
              blurSigma: 66,
            ),
          ),
          const Positioned(
            left: 80,
            bottom: -70,
            child: _BlurBlob(
              diameter: 180,
              color: Color(0xFFD3A4F7),
              opacity: 0.30,
              blurSigma: 70,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 130,
              color: Color(0xFFBA68C8),
              opacity: 0.25,
              blurSigma: 56,
            ),
          ),

          // Frosted glass effect across the whole background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: const SizedBox.expand(),
          ),

          // Optional: Additional subtle overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.09),
                  Colors.transparent,
                  Colors.deepOrange.withOpacity(0.18),
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),

          // Your content (if any)
          if (child != null) child!,
        ],
      ),
    );
  }
}

// Reusable blurry blob widget
class _BlurBlob extends StatelessWidget {
  const _BlurBlob({
    required this.diameter,
    required this.color,
    required this.opacity,
    this.blurSigma = 50,
  });

  final double diameter;
  final Color color;
  final double opacity;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(opacity),
              color.withOpacity(0.05),
            ],
            stops: const [0.3, 1.0],
          ),
        ),
      ),
    );
  }
}