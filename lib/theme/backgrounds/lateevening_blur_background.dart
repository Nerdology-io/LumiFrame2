import 'dart:ui';
import 'package:flutter/material.dart';

class LateEveningBlurBackground extends StatelessWidget {
  const LateEveningBlurBackground({super.key, this.child});
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
                  Color(0xFF211A33), // deep blue-violet
                  Color(0xFF37275B), // muted purple
                  Color(0xFF495480), // twilight blue
                  Color(0xFF2F2A47), // near-midnight
                ],
                stops: [0.0, 0.38, 0.74, 1.0],
              ),
            ),
          ),

          // Blurry glowing blobs
          const Positioned(
            left: -80,
            top: -60,
            child: _BlurBlob(
              diameter: 220,
              color: Color(0xFF8673A1), // desaturated purple
              opacity: 0.35,
              blurSigma: 75,
            ),
          ),
          const Positioned(
            right: -50,
            top: 100,
            child: _BlurBlob(
              diameter: 150,
              color: Color(0xFF425184), // cool twilight blue
              opacity: 0.28,
              blurSigma: 55,
            ),
          ),
          const Positioned(
            left: 60,
            bottom: -70,
            child: _BlurBlob(
              diameter: 190,
              color: Color(0xFF5B4D70), // muted purple-pink
              opacity: 0.22,
              blurSigma: 70,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 120,
              color: Color(0xFFAB9EDC), // dusk lavender highlight
              opacity: 0.17,
              blurSigma: 50,
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
                  Colors.black.withOpacity(0.18),
                  Colors.transparent,
                  Colors.indigo.withOpacity(0.22),
                ],
                stops: const [0.0, 0.6, 1.0],
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