import 'dart:math';
import 'package:flutter/material.dart';

class StarfieldOverlay extends StatefulWidget {
  const StarfieldOverlay({super.key});
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
          painter: _StarTwinklePainter(_controller.value, _randomSeed),
        ),
      ),
    );
  }
}

class _StarTwinklePainter extends CustomPainter {
  final double t;
  final int seed;
  _StarTwinklePainter(this.t, this.seed);

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
      final driftSpeed = 0.15 + 0.35 * rnd.nextDouble(); // Random speed
      final driftSpeedX = cos(driftAngle) * driftSpeed;
      final driftSpeedY = sin(driftAngle) * driftSpeed;

      final moveT = t * pathSpeed + pathPhase;
      final driftX = t * driftSpeedX; // Consistent horizontal drift
      final driftY = t * driftSpeedY; // Consistent vertical drift
      final x = (size.width * dx + sin(moveT) * orbitAmp + driftX * size.width) % (size.width + 20) - 10;
      final y = (size.height * dy + cos(moveT * 0.7) * orbitAmp + driftY * size.height) % (size.height + 20) - 10;

      final twinkle = 0.6 + 0.4 * sin(t * twinkleSpeed * 2 * pi + twinklePhase);

      final paint = Paint()
        ..color = Colors.white.withOpacity(baseOpacity * twinkle)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.1)
        ..blendMode = BlendMode.screen;

      canvas.drawCircle(Offset(x, y), radius * twinkle, paint);
    }
  }
  @override
  bool shouldRepaint(covariant _StarTwinklePainter oldDelegate) => 
      oldDelegate.t != t;
}