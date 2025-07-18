import 'dart:ui';
import 'package:flutter/material.dart';

class MorningBlurBackground extends StatelessWidget {
  const MorningBlurBackground({super.key, this.child});
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
                  Color(0xFFF7F6E7), // soft white
                  Color(0xFFE3EBFF), // clear blue
                  Color(0xFF90C1E0), // bright sky
                  Color(0xFFFFED8D), // morning yellow
                ],
                stops: [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),

          // Blurry glowing blobs
          const Positioned(
            left: -60,
            top: -60,
            child: _BlurBlob(
              diameter: 200,
              color: Color(0xFFFFF3B0),
              opacity: 0.48,
              blurSigma: 80,
            ),
          ),
          const Positioned(
            right: 50,
            top: 120,
            child: _BlurBlob(
              diameter: 140,
              color: Color(0xFF90DDF0),
              opacity: 0.36,
              blurSigma: 60,
            ),
          ),
          const Positioned(
            left: 90,
            bottom: -80,
            child: _BlurBlob(
              diameter: 170,
              color: Color(0xFFF5D98B),
              opacity: 0.28,
              blurSigma: 70,
            ),
          ),
          const Positioned(
            right: -50,
            bottom: 0,
            child: _BlurBlob(
              diameter: 120,
              color: Color(0xFFE8EEF1),
              opacity: 0.22,
              blurSigma: 60,
            ),
          ),

          // Frosted glass effect across the whole background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: const SizedBox.expand(),
          ),

          // Optional: Additional subtle overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.17),
                  Colors.transparent,
                  Colors.amber.withOpacity(0.10),
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