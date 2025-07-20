import 'dart:ui';
import 'package:flutter/material.dart';

class AfternoonBlurBackground extends StatelessWidget {
  const AfternoonBlurBackground({super.key, this.child});
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
                  Color(0xFFFFF1C7), // very pale yellow
                  Color(0xFFFFE67E), // golden
                  Color(0xFFFFB347), // orange highlight
                  Color(0xFFFFCC80), // soft apricot
                ],
                stops: [0.0, 0.35, 0.7, 1.0],
              ),
            ),
          ),
          // Blurry glowing blobs
          const Positioned(
            left: -60,
            top: -70,
            child: _BlurBlob(
              diameter: 180,
              color: Color(0xFFFFE084),
              opacity: 0.47,
              blurSigma: 85,
            ),
          ),
          const Positioned(
            right: -50,
            top: 80,
            child: _BlurBlob(
              diameter: 160,
              color: Color(0xFFFFBE76),
              opacity: 0.38,
              blurSigma: 70,
            ),
          ),
          const Positioned(
            left: 80,
            bottom: -70,
            child: _BlurBlob(
              diameter: 180,
              color: Color(0xFFFFF5E4),
              opacity: 0.25,
              blurSigma: 65,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 120,
              color: Color(0xFFFFD36E),
              opacity: 0.21,
              blurSigma: 55,
            ),
          ),
          // Frosted glass effect across the whole background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: const SizedBox.expand(),
          ),
          // Optional: Additional subtle overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.13),
                  Colors.transparent,
                  Colors.amberAccent.withOpacity(0.17),
                ],
                stops: const [0.0, 0.75, 1.0],
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
