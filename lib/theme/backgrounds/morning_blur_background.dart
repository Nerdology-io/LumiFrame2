import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'animations/godray_top_glow_overlay.dart';

class MorningBlurBackground extends StatefulWidget {
  const MorningBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  State<MorningBlurBackground> createState() => _MorningBlurBackgroundState();
}

class _MorningBlurBackgroundState extends State<MorningBlurBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _sunriseController;

  @override
  void initState() {
    super.initState();
    _sunriseController = AnimationController(
      duration: const Duration(seconds: 30), // Slow, gentle sunrise breathing
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _sunriseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sunriseController,
      builder: (context, child) {
        final animationValue = _sunriseController.value;
        final breathingIntensity = sin(animationValue * 2 * pi) * 0.5 + 0.5;
        
        return SizedBox.expand(
          child: Stack(
            children: [
              // Dynamic sunrise gradient - bright light mode version
              _LightSunriseGradientLayer(breathingIntensity: breathingIntensity),
              
              // Floating warm light orbs that gently pulse - brighter for light mode
              _FloatingLightOrb(
                animationValue: animationValue,
                top: 120,
                left: 60,
                size: 180,
                color: const Color(0xFFFFB347), // Warm peach
                opacity: 0.25, // More visible for light mode
                frequency: 0.8,
              ),
              
              _FloatingLightOrb(
                animationValue: animationValue,
                top: 250,
                right: 80,
                size: 220,
                color: const Color(0xFFFFA726), // Golden orange
                opacity: 0.20, // More visible for light mode
                frequency: 0.6,
              ),
              
              _FloatingLightOrb(
                animationValue: animationValue,
                bottom: 180,
                left: 40,
                size: 160,
                color: const Color(0xFFFF8A65), // Coral
                opacity: 0.30, // More visible for light mode
                frequency: 1.2,
              ),

              // Horizontal light bands that simulate sunrise layers - brighter
              _SunriseLightBand(
                animationValue: animationValue,
                top: 0.2,
                height: 120,
                color: const Color(0xFFFFD54F), // Bright golden
                opacity: 0.25, // More visible for light mode
                frequency: 0.5,
              ),
              
              _SunriseLightBand(
                animationValue: animationValue,
                top: 0.4,
                height: 80,
                color: const Color(0xFFFFB347), // Warm peach
                opacity: 0.20, // More visible for light mode
                frequency: 0.7,
              ),

              // Godray top glow overlay
              Positioned.fill(child: GodRayTopGlowOverlay()),

              // Frosted glass effect - lighter for light mode
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: const SizedBox.expand(),
              ),

              // Your content
              if (widget.child != null) widget.child!,
            ],
          ),
        );
      },
    );
  }
}

// Light mode sunrise gradient - bright and airy
class _LightSunriseGradientLayer extends StatelessWidget {
  const _LightSunriseGradientLayer({required this.breathingIntensity});
  
  final double breathingIntensity;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            // Bright bottom - like dawn horizon
            Color(0xFFFFE0B2), // Light peach
            Color(0xFFFFF3E0), // Cream
            Color(0xFFF3E5F5), // Very light lavender
            // Breathing sunrise colors - bright for light mode
            Color.lerp(
              const Color(0xFFE1F5FE), // Very light blue
              const Color(0xFFFFE082), // Light golden
              breathingIntensity * 0.7,
            )!,
            Color.lerp(
              const Color(0xFFF1F8E9), // Very light green
              const Color(0xFFFFD54F), // Bright golden yellow
              breathingIntensity * 0.8,
            )!,
            // Bright top - like clear morning sky
            Color.lerp(
              const Color(0xFFE3F2FD), // Very light blue
              const Color(0xFFFFF59D), // Light yellow
              breathingIntensity * 0.5,
            )!,
          ],
          stops: [
            0.0,
            0.25,
            0.45,
            0.7 + breathingIntensity * 0.15, // Breathing stop position
            0.85 + breathingIntensity * 0.1, // Breathing stop position
            1.0,
          ],
        ),
      ),
    );
  }
}

// Floating warm light orbs that pulse gently
class _FloatingLightOrb extends StatelessWidget {
  const _FloatingLightOrb({
    required this.animationValue,
    required this.size,
    required this.color,
    required this.opacity,
    required this.frequency,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });
  
  final double animationValue;
  final double size;
  final Color color;
  final double opacity;
  final double frequency;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  
  @override
  Widget build(BuildContext context) {
    final pulse = sin(animationValue * frequency * 2 * pi) * 0.3 + 0.7;
    final drift = sin(animationValue * frequency * 0.5 * 2 * pi) * 20;
    
    return Positioned(
      top: top,
      bottom: bottom,
      left: left != null ? left! + drift : null,
      right: right != null ? right! + drift : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(opacity * pulse),
              color.withOpacity(opacity * pulse * 0.7),
              color.withOpacity(opacity * pulse * 0.3),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.6, 1.0],
          ),
        ),
      ),
    );
  }
}

// Horizontal light bands that simulate sunrise horizon layers
class _SunriseLightBand extends StatelessWidget {
  const _SunriseLightBand({
    required this.animationValue,
    required this.top,
    required this.height,
    required this.color,
    required this.opacity,
    required this.frequency,
  });
  
  final double animationValue;
  final double top; // 0.0 to 1.0 (percentage of screen)
  final double height;
  final Color color;
  final double opacity;
  final double frequency;
  
  @override
  Widget build(BuildContext context) {
    final intensity = sin(animationValue * frequency * 2 * pi) * 0.4 + 0.6;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Positioned(
      top: screenHeight * top,
      left: 0,
      right: 0,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              color.withOpacity(opacity * intensity),
              color.withOpacity(opacity * intensity * 1.2),
              color.withOpacity(opacity * intensity),
              Colors.transparent,
            ],
            stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
          ),
        ),
      ),
    );
  }
}