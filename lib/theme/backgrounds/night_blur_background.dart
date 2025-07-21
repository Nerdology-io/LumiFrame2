






import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

// Aurora gradient layer widget
class _AuroraLayer extends StatelessWidget {
  final double animationValue;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final double frequency;
  final double phase;

  const _AuroraLayer({
    required this.animationValue,
    required this.colors,
    required this.begin,
    required this.end,
    required this.frequency,
    required this.phase,
    // key parameter removed
  });

  @override
  Widget build(BuildContext context) {
    // For simplicity, just return a Container with a LinearGradient using the provided colors, begin, and end
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
        ),
      ),
    );
  }
}



class LightGradientBlurBackground extends StatefulWidget {
  const LightGradientBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  State<LightGradientBlurBackground> createState() => _LightGradientBlurBackgroundState();
}

class _LightGradientBlurBackgroundState extends State<LightGradientBlurBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      duration: const Duration(seconds: 20), // Even faster for more prominent movement
      vsync: this,
    )..repeat();
  }

  @override
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
            children: <Widget>[
              // Main multicolor gradient - Light Mode
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF8F9FB),
                      Color(0xFFE8F0F7),
                      Color(0xFFEDF2F7),
                      Color(0xFFF0F5FA),
                    ],
                    stops: [0.0, 0.5, 0.75, 1.0],
                  ),
                ),
              ),
              _AuroraLayer(
                animationValue: wave1,
                colors: [
                  const Color(0xFF00C9FF).withValues(alpha: 0.6 * 255),
                  const Color(0xFF92FE9D).withValues(alpha: 0.5 * 255),
                  Colors.transparent,
                  const Color(0xFF92FE9D).withValues(alpha: 0.4 * 255),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                frequency: 0.6,
                phase: 0.25,
              ),
              _AuroraLayer(
                animationValue: wave2,
                colors: [
                  Colors.transparent,
                  const Color(0xFF6A82FB).withValues(alpha: 0.5 * 255),
                  const Color(0xFF00C9FF).withValues(alpha: 0.55 * 255),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                frequency: 0.75,
                phase: 0.618,
              ),
              _AuroraLayer(
                animationValue: wave3,
                colors: [
                  const Color(0xFF667eea).withValues(alpha: 0.6 * 255),
                  Colors.transparent,
                  const Color(0xFF00C9FF).withValues(alpha: 0.45 * 255),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                frequency: 0.4,
                phase: 0.382,
              ),
              _AuroraLayer(
                animationValue: wave2,
                colors: [
                  const Color(0xFF6A82FB).withValues(alpha: 0.5 * 255),
                  const Color(0xFF00C9FF).withValues(alpha: 0.55 * 255),
                  const Color(0xFF667eea).withValues(alpha: 0.5 * 255),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                frequency: 0.45,
                phase: 0.75,
              ),
              _AuroraLayer(
                animationValue: wave3,
                colors: [
                  const Color(0xFF667eea).withValues(alpha: 0.5 * 255),
                  const Color(0xFF667eea).withValues(alpha: 0.6 * 255),
                  const Color(0xFF00C9FF).withValues(alpha: 0.45 * 255),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                frequency: 0.3,
                phase: 0.5,
              ),
              _AuroraLayer(
                animationValue: wave1,
                colors: [
                  const Color(0xFF00C9FF).withValues(alpha: 0.5 * 255),
                  const Color(0xFF92FE9D).withValues(alpha: 0.4 * 255),
                  const Color(0xFF667eea).withValues(alpha: 0.4 * 255),
                  const Color(0xFF6A82FB).withValues(alpha: 0.3 * 255),
                  Colors.transparent,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                frequency: 0.2,
                phase: 0.1,
              ),
              Positioned(
                left: -120,
                top: -120,
                child: _StaticBlurBlob(
                  diameter: 400,
                  color: const Color(0xFF667eea).withValues(alpha: 0.5 * 255),
                  opacity: 1.0,
                  blurSigma: 150,
                ),
              ),
              Positioned(
                right: -100,
                top: 40,
                child: _StaticBlurBlob(
                  diameter: 400,
                  color: const Color(0xFF667eea).withValues(alpha: 0.5 * 255),
                  opacity: 1.0,
                  blurSigma: 150,
                ),
              ),
              Positioned(
                left: 60,
                top: 200,
                child: _BreathingBlurBlob(
                  diameter: 220,
                  color: const Color(0xFF8E6DB8),
                  opacity: 0.6,
                  blurSigma: 80,
                  breathingValue: wave3,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: _BreathingBlurBlob(
                  diameter: 140,
                  color: const Color(0xFF1E8FA1),
                  opacity: 0.35,
                  blurSigma: 60,
                  breathingValue: wave1 * 0.7,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: const SizedBox.expand(),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.1 * 255),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.2 * 255),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
              if (widget.child != null) widget.child!,
            ],
          ),
        );
      },
    );
  }
}

// Separate widget to avoid hot reload issues with const constructor


// Breathing blurry blob widget
class _BreathingBlurBlob extends StatelessWidget {
  final double diameter;
  final Color color;
  final double opacity;
  final double breathingValue;
  final double blurSigma;

  const _BreathingBlurBlob({
    required this.diameter,
    required this.color,
    required this.opacity,
    required this.breathingValue,
    this.blurSigma = 50,
  });

  @override
  Widget build(BuildContext context) {
    final breathingOpacity = opacity * (0.95 + 0.05 * breathingValue);
    final breathingSize = diameter * (0.98 + 0.02 * breathingValue);
    final breathingBlur = blurSigma * (0.98 + 0.02 * breathingValue);
    return Center(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: breathingBlur, sigmaY: breathingBlur),
        child: Container(
          width: breathingSize,
          height: breathingSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: breathingOpacity * 255),
                color.withValues(alpha: breathingOpacity * 0.7 * 255),
                color.withValues(alpha: breathingOpacity * 0.3 * 255),
                color.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.5, 0.8, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}

// Static blurry blob widget (no animation)
class _StaticBlurBlob extends StatelessWidget {
  final double diameter;
  final Color color;
  final double opacity;
  final double blurSigma;

  const _StaticBlurBlob({
    required this.diameter,
    required this.color,
    required this.opacity,
    this.blurSigma = 50,
  });

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
              color.withValues(alpha: opacity * 255),
              color.withValues(alpha: opacity * 0.7 * 255), // More gradual fade
              color.withValues(alpha: opacity * 0.3 * 255), // Smoother transition
              color.withValues(alpha: 0.0), // Complete fade to transparent
            ],
            stops: const [0.1, 0.4, 0.7, 1.0], // More gradient stops for smoother fade
          ),
        ),
      ),
    );
  }
}