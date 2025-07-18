import 'dart:ui';
import 'package:flutter/material.dart';
import 'animations/mist_overlay.dart';
import 'animations/flare_dust_overlay.dart';

class EarlyMorningDarkBlurBackground extends StatelessWidget {
  const EarlyMorningDarkBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Main multicolor gradient (deep teal-blues and indigos)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0C1624), // dark navy
                  Color(0xFF152944), // deep indigo-blue
                  Color(0xFF233554), // muted blue
                  Color(0xFF1A2237), // deep teal/indigo
                ],
                stops: [0.0, 0.48, 0.78, 1.0],
              ),
            ),
          ),

          // Flare dust overlay
          Positioned.fill(child: FlareDustOverlay()),

          // Mist overlay
          Positioned.fill(child: MistOverlay()),
          // Blurry blobs
          const Positioned(
            left: -80,
            top: -80,
            child: _BlurBlob(
              diameter: 220,
              color: Color(0xFF31597B), // teal blue
              opacity: 0.27,
              blurSigma: 75,
            ),
          ),
          const Positioned(
            right: -60,
            top: 100,
            child: _BlurBlob(
              diameter: 160,
              color: Color(0xFF364467), // dusty indigo
              opacity: 0.25,
              blurSigma: 58,
            ),
          ),
          const Positioned(
            left: 70,
            bottom: -70,
            child: _BlurBlob(
              diameter: 180,
              color: Color(0xFF18334B), // blue/teal shadow
              opacity: 0.20,
              blurSigma: 67,
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _BlurBlob(
              diameter: 120,
              color: Color(0xFF6497C4), // hint of dawn
              opacity: 0.16,
              blurSigma: 53,
            ),
          ),
          // Frosted glass
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: const SizedBox.expand(),
          ),
          // Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.transparent,
                  Colors.black.withOpacity(0.47),
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

// _BlurBlob class stays exactly the same as your existing implementation
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