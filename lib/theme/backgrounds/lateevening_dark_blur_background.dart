import 'dart:ui';
import 'package:flutter/material.dart';

class LateEveningDarkBlurBackground extends StatelessWidget {
  const LateEveningDarkBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Main gradient: deep blue/purple, midnight, magenta accent
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF181734), // deep indigo
                  Color(0xFF2A2141), // shadowy violet
                  Color(0xFF373163), // muted blue-violet
                  Color(0xFF412A3C), // midnight magenta
                ],
                stops: [0.0, 0.35, 0.72, 1.0],
              ),
            ),
          ),
          // Blurry blobs
          const Positioned(
            left: -80,
            top: -60,
            child: _BlurBlob(
              diameter: 210,
              color: Color(0xFF6B59A4), // muted purple
              opacity: 0.27,
              blurSigma: 76,
            ),
          ),
          const Positioned(
            right: -45,
            top: 90,
            child: _BlurBlob(
              diameter: 150,
              color: Color(0xFF544C99), // twilight blue
              opacity: 0.22,
              blurSigma: 61,
            ),
          ),
          const Positioned(
            left: 70,
            bottom: -70,
            child: _BlurBlob(
              diameter: 160,
              color: Color(0xFFB26BA7), // muted magenta
              opacity: 0.15,
              blurSigma: 67,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 120,
              color: Color(0xFF364A6B), // dusk blue
              opacity: 0.18,
              blurSigma: 53,
            ),
          ),
          // Frosted glass
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: const SizedBox.expand(),
          ),
          // Subtle overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.22),
                  Colors.transparent,
                  Colors.black.withOpacity(0.44),
                ],
                stops: const [0.0, 0.65, 1.0],
              ),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

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