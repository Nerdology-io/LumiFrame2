import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'animations/starfield_overlay.dart';

class NightDarkBlurBackground extends StatefulWidget {
  const NightDarkBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  State<NightDarkBlurBackground> createState() => _NightDarkBlurBackgroundState();
}

class _NightDarkBlurBackgroundState extends State<NightDarkBlurBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      duration: const Duration(seconds: 8), // Slower, more aurora-like
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _breathingController,
      builder: (context, child) {
        final animationValue = _breathingController.value;
        final wave1 = sin(animationValue * 2 * pi) * 0.5 + 0.5;
        final wave2 = sin(animationValue * 2 * pi + pi / 3) * 0.5 + 0.5;
        final wave3 = sin(animationValue * 2 * pi + 2 * pi / 3) * 0.5 + 0.5;
        
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

              // Aurora-like flowing color layers
              _AuroraLayer(
                animationValue: wave1,
                colors: [
                  const Color(0xFF6547A6).withOpacity(0.3),
                  const Color(0xFF1577D7).withOpacity(0.2),
                  Colors.transparent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
              
              _AuroraLayer(
                animationValue: wave2,
                colors: [
                  Colors.transparent,
                  const Color(0xFF56B4D3).withOpacity(0.25),
                  const Color(0xFF1A1041).withOpacity(0.4),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              
              _AuroraLayer(
                animationValue: wave3,
                colors: [
                  const Color(0xFF163154).withOpacity(0.3),
                  Colors.transparent,
                  const Color(0xFF241F4B).withOpacity(0.2),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),

              // Animated particles layer (night sky effect)
              Positioned.fill(
                child: IgnorePointer(
                  child: _NightParticlesLayer(),
                ),
              ),

              // Static blurry glowing blobs (no animation)
              Positioned(
                left: -120,
                top: -120,
                child: _StaticBlurBlob(
                  diameter: 400, // Much larger
                  color: const Color(0xFF6547A6),
                  opacity: 0.15, // Very subtle
                  blurSigma: 150, // Much more blur for smooth fade
                ),
              ),
              Positioned(
                right: -100,
                top: 40,
                child: _StaticBlurBlob(
                  diameter: 320, // Much larger
                  color: const Color(0xFF56B4D3), // Same teal as aurora
                  opacity: 0.12, // Very subtle
                  blurSigma: 120, // Much more blur for smooth fade
                ),
              ),
              Positioned(
                left: 60,
                bottom: -60,
                child: _BreathingBlurBlob(
                  diameter: 220,
                  color: const Color(0xFF1A1041),
                  opacity: 0.4, // Reduced opacity
                  blurSigma: 80,
                  breathingValue: wave3,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: _BreathingBlurBlob(
                  diameter: 140,
                  color: const Color(0xFF56B4D3),
                  opacity: 0.15, // Reduced opacity
                  blurSigma: 60,
                  breathingValue: wave1 * 0.7,
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
              if (widget.child != null) widget.child!,
            ],
          ),
        );
      },
    );
  }
}

// Separate widget to avoid hot reload issues with const constructor
class _NightParticlesLayer extends StatelessWidget {
  const _NightParticlesLayer();

  @override
  Widget build(BuildContext context) {
    return StarfieldOverlay();
  }
}

// Breathing blurry blob widget
class _BreathingBlurBlob extends StatelessWidget {
  const _BreathingBlurBlob({
    required this.diameter,
    required this.color,
    required this.opacity,
    required this.breathingValue,
    this.blurSigma = 50,
  });

  final double diameter;
  final Color color;
  final double opacity;
  final double breathingValue;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    // Create very subtle breathing effect to avoid flickering
    final breathingOpacity = opacity * (0.95 + 0.05 * breathingValue); // Very subtle opacity change (95%-100%)
    final breathingSize = diameter * (0.98 + 0.02 * breathingValue); // Very subtle size change (98%-100%)
    final breathingBlur = blurSigma * (0.98 + 0.02 * breathingValue); // Very subtle blur change
    
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: breathingBlur, sigmaY: breathingBlur),
      child: Container(
        width: breathingSize,
        height: breathingSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(breathingOpacity),
              color.withOpacity(breathingOpacity * 0.7), // More gradual fade
              color.withOpacity(breathingOpacity * 0.3), // Smoother transition
              color.withOpacity(0.0), // Complete fade to transparent
            ],
            stops: const [0.1, 0.4, 0.7, 1.0], // More gradient stops for smoother fade
          ),
        ),
      ),
    );
  }
}

// Aurora-like flowing gradient layer
class _AuroraLayer extends StatelessWidget {
  const _AuroraLayer({
    required this.animationValue,
    required this.colors,
    required this.begin,
    required this.end,
  });

  final double animationValue;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    // Create flowing effect by shifting the gradient stops
    final shift = animationValue * 0.3; // How much to shift the gradient
    final stops = [
      (0.0 + shift).clamp(0.0, 1.0),
      (0.5 + shift).clamp(0.0, 1.0),
      (1.0 + shift).clamp(0.0, 1.0),
    ];
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
          stops: stops,
        ),
      ),
    );
  }
}

// Static blurry blob widget (no animation)
class _StaticBlurBlob extends StatelessWidget {
  const _StaticBlurBlob({
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
              color.withOpacity(opacity * 0.7), // More gradual fade
              color.withOpacity(opacity * 0.3), // Smoother transition
              color.withOpacity(0.0), // Complete fade to transparent
            ],
            stops: const [0.1, 0.4, 0.7, 1.0], // More gradient stops for smoother fade
          ),
        ),
      ),
    );
  }
}