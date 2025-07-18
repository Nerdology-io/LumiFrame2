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
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _StarTwinklePainter(_controller.value),
        ),
      ),
    );
  }
}

class _StarTwinklePainter extends CustomPainter {
  final double t;
  _StarTwinklePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(1919);
    for (int i = 0; i < 64; ++i) {
      final dx = rnd.nextDouble();
      final dy = rnd.nextDouble();
      final pathSpeed = 0.08 + 0.12 * rnd.nextDouble();
      final twinkleSpeed = 0.7 + 1.0 * rnd.nextDouble();
      final pathPhase = rnd.nextDouble() * pi * 2;
      final twinklePhase = rnd.nextDouble() * 2 * pi;
      final orbitAmp = 6 + rnd.nextDouble() * 11;
      final radius = 0.7 + 1.3 * rnd.nextDouble();
      final baseOpacity = 0.18 + 0.52 * rnd.nextDouble();

      final moveT = t * pathSpeed + pathPhase;
      final x = (size.width * dx + sin(moveT) * orbitAmp);
      final y = (size.height * dy + cos(moveT * 0.7) * orbitAmp);
      if (x < 0 || x > size.width || y < 0 || y > size.height) continue;

      final twinkle = 0.65 + 0.35 * sin(t * twinkleSpeed * 2 * pi + twinklePhase);

      final paint = Paint()
        ..color = Colors.white.withOpacity(baseOpacity * twinkle)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.1)
        ..blendMode = BlendMode.screen;

      canvas.drawCircle(Offset(x, y), radius * twinkle, paint);
    }
  }
  @override
  bool shouldRepaint(covariant _StarTwinklePainter oldDelegate) => true;
}