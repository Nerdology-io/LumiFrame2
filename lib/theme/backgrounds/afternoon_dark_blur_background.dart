import 'dart:ui';
import 'package:flutter/material.dart';

class AfternoonDarkBlurBackground extends StatelessWidget {
  const AfternoonDarkBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Gradient (muted warm orange, gold, deep brown/blue)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2E251B), // warm brown-black
                  Color(0xFF3D2C1A), // warm shadow
                  Color(0xFFC56B05), // burnt amber
                  Color(0xFF2A2522), // shadow
                ],
                stops: [0.0, 0.44, 0.80, 1.0],
              ),
            ),
          ),
          const Positioned(
            left: -50,
            top: -60,
            child: _BlurBlob(
              diameter: 170,
              color: Color(0xFFAD8925), // dark gold
              opacity: 0.23,
              blurSigma: 74,
            ),
          ),
          const Positioned(
            right: -40,
            top: 60,
            child: _BlurBlob(
              diameter: 150,
              color: Color.fromARGB(255, 185, 120, 45), // muted orange
              opacity: 0.18,
              blurSigma: 61,
            ),
          ),
          const Positioned(
            left: 70,
            bottom: -50,
            child: _BlurBlob(
              diameter: 160,
              color: Color.fromARGB(255, 172, 73, 2), // dark brown shadow
              opacity: 0.22,
              blurSigma: 68,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 120,
              color: Color.fromARGB(255, 197, 168, 87), // faded gold
              opacity: 0.16,
              blurSigma: 51,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: const SizedBox.expand(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.28),
                  Colors.transparent,
                  Colors.black.withOpacity(0.52),
                ],
                stops: const [0.0, 0.7, 1.0],
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