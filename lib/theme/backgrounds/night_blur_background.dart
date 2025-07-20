import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'animations/starfield_overlay.dart';

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
              // Main multicolor gradient - Light Mode
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF8F9FB), // light gray-white
                      Color(0xFFE8F0F7), // very light blue
                      Color(0xFFEDF2F7), // light gray
                      Color(0xFFF0F5FA), // off-white blue
                    ],
                    stops: [0.0, 0.5, 0.75, 1.0],
                  ),
                ),
              ),

                            // Aurora-like flowing color layers - Dramatic and prominent for digital photo frame viewing
              _AuroraLayer(
                animationValue: wave1,
                colors: [
                  const Color(0xFF00C9FF).withOpacity(0.6), // Much more prominent cyan
                  const Color(0xFF92FE9D).withOpacity(0.5), // Stronger green
                  Colors.transparent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                frequency: 0.5, // More noticeable movement
                phase: 0.0,
              ),
              
              _AuroraLayer(
                animationValue: wave2,
                colors: [
                  Colors.transparent,
                  const Color(0xFF6A82FB).withOpacity(0.5), // Stronger blue
                  const Color(0xFF00C9FF).withOpacity(0.55), // Very prominent cyan
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                frequency: 0.75, // Fast, noticeable movement
                phase: 0.618,
              ),
              
              _AuroraLayer(
                animationValue: wave3,
                colors: [
                  const Color(0xFF667eea).withOpacity(0.6), // Deep blue very prominent
                  Colors.transparent,
                  const Color(0xFF00C9FF).withOpacity(0.45), // Strong cyan accent
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                frequency: 0.4, // Noticeable movement
                phase: 0.382,
              ),

              // Additional dramatic aurora layers for full screen coverage
              _AuroraLayer(
                animationValue: wave1,
                colors: [
                  Colors.transparent,
                  const Color(0xFF00C9FF).withOpacity(0.5), // Very strong cyan
                  const Color(0xFF92FE9D).withOpacity(0.4), // Strong green
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                frequency: 0.6, // Fast movement
                phase: 0.25,
              ),

              _AuroraLayer(
                animationValue: wave2,
                colors: [
                  const Color(0xFF6A82FB).withOpacity(0.45), // Strong blue
                  const Color(0xFF00C9FF).withOpacity(0.5), // Very prominent cyan center
                  const Color(0xFF667eea).withOpacity(0.5), // Strong deep blue
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                frequency: 0.45, // Noticeable horizontal sweep
                phase: 0.75,
              ),

              _AuroraLayer(
                animationValue: wave3,
                colors: [
                  const Color(0xFF667eea).withOpacity(0.5), // Strong deep blue
                  const Color(0xFF00C9FF).withOpacity(0.4), // Prominent main cyan
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                frequency: 0.3, // Noticeable vertical movement
                phase: 0.5,
              ),

              // Dramatic full screen diagonal sweep
              _AuroraLayer(
                animationValue: wave1,
                colors: [
                  Colors.transparent,
                  const Color(0xFF00C9FF).withOpacity(0.35), // Strong cyan
                  const Color(0xFF667eea).withOpacity(0.4), // Strong deep blue
                  const Color(0xFF6A82FB).withOpacity(0.3), // Noticeable blue
                  Colors.transparent,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                frequency: 0.2, // Slow but very visible diagonal sweep
                phase: 0.1,
              ),

              // Animated particles layer (light sky effect)
              Positioned.fill(
                child: IgnorePointer(
                  child: _LightParticlesLayer(),
                ),
              ),

              // Static blurry glowing blobs (no animation) - More Saturated Colors
              Positioned(
                left: -120,
                top: -120,
                child: _StaticBlurBlob(
                  diameter: 400, // Much larger
                  color: const Color(0xFF2BA8BA), // more saturated teal
                  opacity: 0.3, // increased opacity
                  blurSigma: 150, // Much more blur for smooth fade
                ),
              ),
              Positioned(
                right: -100,
                top: 40,
                child: _StaticBlurBlob(
                  diameter: 320, // Much larger
                  color: const Color(0xFF1E8FA1), // deeper teal
                  opacity: 0.25, // increased opacity
                  blurSigma: 120, // Much more blur for smooth fade
                ),
              ),
              Positioned(
                left: 60,
                bottom: -60,
                child: _BreathingBlurBlob(
                  diameter: 220,
                  color: const Color(0xFF8E6DB8), // more saturated purple
                  opacity: 0.6, // increased opacity
                  blurSigma: 80,
                  breathingValue: wave3,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: _BreathingBlurBlob(
                  diameter: 140,
                  color: const Color(0xFF1E8FA1), // deeper teal
                  opacity: 0.35, // increased opacity
                  blurSigma: 60,
                  breathingValue: wave1 * 0.7,
                ),
              ),

              // Frosted glass effect across the whole background - Light Mode
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Further reduced blur for better color visibility
                child: const SizedBox.expand(),
              ),

              // Optional: Additional subtle overlay for light mode
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                      Colors.white.withOpacity(0.2),
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
class _LightParticlesLayer extends StatelessWidget {
  const _LightParticlesLayer();

  @override
  Widget build(BuildContext context) {
    return StarfieldOverlay(isDarkMode: false);
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
    this.frequency = 1.0,
    this.phase = 0.0,
  });

  final double animationValue;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final double frequency;
  final double phase;

  @override
  Widget build(BuildContext context) {
    // Create seamless looping animation using continuous time-based functions
    final time = animationValue * frequency + phase;
    
    // Use multiple sine waves with different periods that all complete full cycles
    // This ensures seamless looping without any discontinuities
    final wave1 = sin(time * 2 * pi);           // Base wave
    final wave2 = sin(time * 3 * pi + pi/4);    // Faster wave with phase offset
    final wave3 = sin(time * 1.5 * pi + pi/2);  // Slower wave with different phase
    
    // Create gradient stops that flow smoothly and cover more screen area
    // Adjust the number of stops based on the number of colors provided
    List<double> stops;
    
    if (colors.length == 3) {
      // Standard 3-color gradient with dramatic movement for photo frame viewing
      final stop1 = 0.1 + wave1 * 0.2;             // Range: -0.1 to 0.3 (larger movement)
      final stop2 = 0.5 + wave2 * 0.25;            // Range: 0.25 to 0.75 (dramatic center movement)
      final stop3 = 0.9 + wave3 * 0.15;            // Range: 0.75 to 1.05 (wider end movement)
      stops = [stop1.clamp(0.0, 1.0), stop2.clamp(0.0, 1.0), stop3.clamp(0.0, 1.0)];
    } else if (colors.length == 5) {
      // Extended 5-color gradient with dramatic sweeping movement
      final stop1 = 0.0 + wave1 * 0.15;            // Range: -0.15 to 0.15 (dramatic start)
      final stop2 = 0.2 + wave2 * 0.2;             // Range: 0.0 to 0.4 (wide movement)
      final stop3 = 0.5 + wave3 * 0.3;             // Range: 0.2 to 0.8 (very dramatic center)
      final stop4 = 0.8 + wave1 * 0.2;             // Range: 0.6 to 1.0 (wide movement)
      final stop5 = 1.0 + wave2 * 0.15;            // Range: 0.85 to 1.15 (dramatic end)
      stops = [stop1, stop2, stop3, stop4, stop5].map((s) => s.clamp(0.0, 1.0)).toList();
    } else {
      // Fallback with dramatic movement
      final baseStop = 0.5 + wave1 * 0.35; // Much larger base movement
      stops = List.generate(colors.length, (i) => 
        (baseStop + (i / (colors.length - 1) - 0.5) * 1.2).clamp(0.0, 1.0) // Wider spread
      );
    }
    
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