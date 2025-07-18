import 'dart:ui';
import 'package:flutter/material.dart';

class EarlyMorningBlurBackground extends StatelessWidget {
  const EarlyMorningBlurBackground({super.key, this.child});
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
                  Color(0xFFCEDDEE), // pale sky blue
                  Color(0xFF98B4D4), // early blue
                  Color(0xFFADB6E0), // soft violet
                  Color(0xFF7C90A0), // foggy gray-blue
                ],
                stops: [0.0, 0.45, 0.75, 1.0],
              ),
            ),
          ),

          // Blurry glowing blobs
          const Positioned(
            left: -80,
            top: -80,
            child: _BlurBlob(
              diameter: 240,
              color: Color(0xFF6EA4BF),
              opacity: 0.33,
              blurSigma: 80,
            ),
          ),
          const Positioned(
            right: -60,
            top: 120,
            child: _BlurBlob(
              diameter: 150,
              color: Color(0xFFBB9CC0),
              opacity: 0.40,
              blurSigma: 60,
            ),
          ),
          const Positioned(
            left: 80,
            bottom: -60,
            child: _BlurBlob(
              diameter: 200,
              color: Color(0xFFD8EFFF),
              opacity: 0.23,
              blurSigma: 80,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 120,
              color: Color(0xFFA7C7E7),
              opacity: 0.20,
              blurSigma: 60,
            ),
          ),

          // Frosted glass effect across the whole background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: const SizedBox.expand(),
          ),

          // Optional: Additional subtle overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.10),
                  Colors.transparent,
                  Colors.blueGrey.withOpacity(0.17),
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