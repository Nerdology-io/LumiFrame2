import 'dart:math';
import 'package:flutter/material.dart';

class StarfieldOverlay extends StatefulWidget {
  const StarfieldOverlay({super.key, this.isDarkMode = true});
  final bool isDarkMode;
  
  @override
  State<StarfieldOverlay> createState() => _StarfieldOverlayState();
}
class _StarfieldOverlayState extends State<StarfieldOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 80))..repeat();
  
  // Generate a random seed once when the widget is created
  final int _randomSeed = Random().nextInt(1000000);
  
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _StarTwinklePainter(_controller.value, _randomSeed, widget.isDarkMode),
        ),
      ),
    );
  }
}

class _StarTwinklePainter extends CustomPainter {
  final double t;
  final int seed;
  final bool isDarkMode;
  _StarTwinklePainter(this.t, this.seed, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(seed);
    for (int i = 0; i < 96; ++i) {
      final dx = rnd.nextDouble();
      final dy = rnd.nextDouble();
      final pathSpeed = 0.12 + 0.18 * rnd.nextDouble();
      final twinkleSpeed = 0.8 + 1.2 * rnd.nextDouble();
      final pathPhase = rnd.nextDouble() * pi * 2;
      final twinklePhase = rnd.nextDouble() * 2 * pi;
      final orbitAmp = 3 + rnd.nextDouble() * 6;
      final radius = 0.7 + 1.3 * rnd.nextDouble();
      final baseOpacity = 0.18 + 0.52 * rnd.nextDouble();
      
      // Random drift direction and speed for each star
      final driftAngle = rnd.nextDouble() * 2 * pi; // Random direction
      final driftSpeed = 0.30 + 0.70 * rnd.nextDouble(); // Random speed (doubled)
      final driftSpeedX = cos(driftAngle) * driftSpeed;
      final driftSpeedY = sin(driftAngle) * driftSpeed;

      final moveT = t * pathSpeed + pathPhase;
      final driftX = t * driftSpeedX; // Consistent horizontal drift
      final driftY = t * driftSpeedY; // Consistent vertical drift
      final x = (size.width * dx + sin(moveT) * orbitAmp + driftX * size.width) % (size.width + 20) - 10;
      final y = (size.height * dy + cos(moveT * 0.7) * orbitAmp + driftY * size.height) % (size.height + 20) - 10;

      final twinkle = 0.6 + 0.4 * sin(t * twinkleSpeed * 2 * pi + twinklePhase);
      
      // Mystical glow effects - MUCH more dramatic and visible
      final colorShift = sin(t * 3.0 + i * 1.618) * 0.5 + 0.5; // Much faster color shifting
      final glowPulse = sin(t * 4.0 + i * 0.7) * 0.8 + 0.2; // Extreme pulsing (0.2 to 1.0)
      final blurRadius = 0.5 + sin(t * 3.5 + i * 0.9) * 1.5; // Dramatic size change (0.5 to 2.0)
      
      // Color based on theme mode
      double red, green, blue;
      if (isDarkMode) {
        // Light colors for dark background
        red = 1.0;
        green = 0.7 + colorShift * 0.3; // More dramatic color variation
        blue = 0.5 + colorShift * 0.5; // Very noticeable blue/purple variation
      } else {
        // Dark colors for light background
        red = 0.1 + colorShift * 0.2; // Dark with subtle variation
        green = 0.2 + colorShift * 0.3; // Slightly lighter
        blue = 0.4 + colorShift * 0.4; // More blue/purple tint
      }
      final mysticalOpacity = (baseOpacity * twinkle * glowPulse).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = Color.fromRGBO((red * 255).round(), (green * 255).round(), (blue * 255).round(), mysticalOpacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius)
        ..blendMode = BlendMode.screen;

      canvas.drawCircle(Offset(x, y), radius * twinkle, paint);
    }
  }
  @override
  bool shouldRepaint(covariant _StarTwinklePainter oldDelegate) => 
      oldDelegate.t != t;
}