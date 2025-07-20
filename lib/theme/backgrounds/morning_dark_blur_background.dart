import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'animations/godray_top_glow_overlay.dart';

class MorningDarkBlurBackground extends StatefulWidget {
  const MorningDarkBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  State<MorningDarkBlurBackground> createState() => _MorningDarkBlurBackgroundState();
}

class _MorningDarkBlurBackgroundState extends State<MorningDarkBlurBackground>
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
              // Dynamic sunrise gradient - dark bottom to light top
              _SunriseGradientLayer(breathingIntensity: breathingIntensity),
              
              // Floating warm light orbs that gently pulse
              _FloatingLightOrb(
                animationValue: animationValue,
                top: 120,
                left: 60,
                size: 180,
                color: const Color(0xFFFFD54F),
                opacity: 0.08, // Much more subtle for dark theme
                frequency: 0.8,
              ),
              
              _FloatingLightOrb(
                animationValue: animationValue,
                top: 250,
                right: 80,
                size: 220,
                color: const Color(0xFFFFA726),
                opacity: 0.06, // Much more subtle for dark theme
                frequency: 0.6,
              ),
              
              _FloatingLightOrb(
                animationValue: animationValue,
                bottom: 180,
                left: 40,
                size: 160,
                color: const Color(0xFFFFB347),
                opacity: 0.10, // Much more subtle for dark theme
                frequency: 1.2,
              ),

              // Horizontal light bands that simulate sunrise layers
              _SunriseLightBand(
                animationValue: animationValue,
                top: 0.2,
                height: 120,
                color: const Color(0xFFFFE082),
                opacity: 0.08, // Much more subtle for dark theme
                frequency: 0.5,
              ),
              
              _SunriseLightBand(
                animationValue: animationValue,
                top: 0.4,
                height: 80,
                color: const Color(0xFFFFA726),
                opacity: 0.06, // Much more subtle for dark theme
                frequency: 0.7,
              ),

              // Godray top glow overlay
              Positioned.fill(child: GodRayTopGlowOverlay()),

              // Frosted glass effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
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

// Dynamic sunrise gradient that breathes from dark to light
class _SunriseGradientLayer extends StatelessWidget {
  const _SunriseGradientLayer({required this.breathingIntensity});
  
  final double breathingIntensity;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            // Much darker bottom - deep pre-dawn darkness
            Color(0xFF050813), // Almost black with hint of blue
            Color(0xFF0A0F1A), // Deep dark blue-black
            Color(0xFF141B26), // Dark blue-grey
            Color(0xFF1E2832), // Slightly lighter dark blue
            // Subtle breathing sunrise colors - more muted for dark theme
            Color.lerp(
              const Color(0xFF2A3441), // Dark blue-grey base
              const Color(0xFF4A3329), // Darker warm brown
              breathingIntensity * 0.4,
            )!,
            Color.lerp(
              const Color(0xFF3A4B5C), // Muted blue-grey
              const Color(0xFF5D4A2F), // Darker golden brown
              breathingIntensity * 0.5,
            )!,
            // Darker top - subtle warm glow
            Color.lerp(
              const Color(0xFF4A5B6C), // Dark blue-grey
              const Color(0xFF6B5A3F), // Muted warm brown
              breathingIntensity * 0.3,
            )!,
          ],
          stops: [
            0.0,
            0.15,
            0.35,
            0.55,
            0.7 + breathingIntensity * 0.1, // Subtle breathing
            0.85 + breathingIntensity * 0.08, // Subtle breathing
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