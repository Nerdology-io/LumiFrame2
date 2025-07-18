import 'dart:ui';
import 'package:flutter/material.dart';
import 'animations/godray_top_glow_overlay.dart';

class MorningDarkBlurBackground extends StatelessWidget {
  const MorningDarkBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Gradient (moody blue, soft gold highlight)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF191C26), // deep blue
                  Color(0xFF233D54), // blue steel
                  Color(0xFF2D446B), // blue highlight
                  Color(0xFFA58703), // subtle morning gold
                ],
                stops: [0.0, 0.44, 0.8, 1.0],
              ),
            ),
          ),

          // Godray top glow overlay
          Positioned.fill(child: GodRayTopGlowOverlay()),
          const Positioned(
            left: -65,
            top: -60,
            child: _BlurBlob(
              diameter: 200,
              color: Color(0xFF3B678A),
              opacity: 0.31,
              blurSigma: 74,
            ),
          ),
          const Positioned(
            right: 40,
            top: 100,
            child: _BlurBlob(
              diameter: 140,
              color: Color(0xFFECC050), // muted gold
              opacity: 0.38,
              blurSigma: 63,
            ),
          ),
          const Positioned(
            left: 80,
            bottom: -60,
            child: _BlurBlob(
              diameter: 160,
              color: Color(0xFF5C87A3), // subtle blue
              opacity: 0.21,
              blurSigma: 68,
            ),
          ),
          const Positioned(
            right: -55,
            bottom: 0,
            child: _BlurBlob(
              diameter: 110,
              color: Color(0xFF3A5071), // blue-grey
              opacity: 0.20,
              blurSigma: 54,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 17, sigmaY: 17),
            child: const SizedBox.expand(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.22),
                  Colors.transparent,
                  Colors.black.withOpacity(0.42),
                ],
                stops: const [0.0, 0.6, 1.0],
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