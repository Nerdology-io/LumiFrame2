import 'dart:ui';
import 'package:flutter/material.dart';
import 'animations/animated_particles.dart';

class NightDarkBlurBackground extends StatelessWidget {
  const NightDarkBlurBackground({super.key, this.child});
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
                  Color(0xFF09041B), // almost black
                  Color(0xFF241F4B), // deep purple
                  Color(0xFF163154), // night blue
                  Color(0xFF211E3C), // midnight
                ],
                stops: [0.0, 0.5, 0.75, 1.0],
              ),
            ),
          ),

          // Animated particles layer (night sky effect)
          Positioned.fill(
            child: IgnorePointer(
              child: _NightParticlesLayer(),
            ),
          ),

          // Blurry glowing blobs
          const Positioned(
            left: -80,
            top: -80,
            child: _BlurBlob(
              diameter: 260,
              color: Color(0xFF6547A6),
              opacity: 0.5,
              blurSigma: 80,
            ),
          ),
          const Positioned(
            right: -60,
            top: 80,
            child: _BlurBlob(
              diameter: 180,
              color: Color(0xFF1577D7),
              opacity: 0.4,
              blurSigma: 60,
            ),
          ),
          const Positioned(
            left: 60,
            bottom: -60,
            child: _BlurBlob(
              diameter: 220,
              color: Color(0xFF1A1041),
              opacity: 0.7,
              blurSigma: 80,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 140,
              color: Color(0xFF56B4D3),
              opacity: 0.25,
              blurSigma: 60,
            ),
          ),

          // Frosted glass effect across the whole background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: const SizedBox.expand(),
          ),

          // Optional: Additional subtle overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.0, 0.5, 1.0],
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

// Separate widget to avoid hot reload issues with const constructor
class _NightParticlesLayer extends StatelessWidget {
  const _NightParticlesLayer();

  @override
  Widget build(BuildContext context) {
    return AnimatedParticles(
      count: 130,
      minSize: 0.35,
      maxSize: 1.15,
      minOpacity: 0.35,
      maxOpacity: 0.80,
      minSpeed: 3.5,
      maxSpeed: 7.0,
      blurSigma: 2.3,
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