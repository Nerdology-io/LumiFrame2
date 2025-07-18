import 'dart:math';
import 'package:flutter/material.dart';

class FlareDustOverlay extends StatefulWidget {
  const FlareDustOverlay({super.key});
  @override
  State<FlareDustOverlay> createState() => _FlareDustOverlayState();
}

class _FlareDustOverlayState extends State<FlareDustOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 60))..repeat();
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _FlareDustPainter(_controller.value),
        ),
      ),
    );
  }
}

class _FlareDustPainter extends CustomPainter {
  final double t;
  _FlareDustPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final flareCenter = Offset(size.width * 0.78, size.height * 0.19);
    final baseRadius = size.width * 0.18;
    for (int i = 0; i < 4; ++i) {
      final phaseShift = t * 2 * pi * (1.2 + i * 0.13);
      final flareRadius = baseRadius * (1.25 + i * 0.53 + sin(phaseShift) * 0.19);
      final paint = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60)
        ..shader = RadialGradient(
          colors: [
            Colors.white.withOpacity(0.11 / (i + 1)),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: flareCenter, radius: flareRadius));
      canvas.drawCircle(flareCenter, flareRadius, paint);
    }

    final rnd = Random(7777);
    for (int i = 0; i < 130; ++i) {
      final baseX = rnd.nextDouble();
      final baseY = rnd.nextDouble();
      final pathSpeed = 0.8 + 2.2 * rnd.nextDouble();
      final fadeSpeed = 0.7 + 2.1 * rnd.nextDouble();
      final dir = rnd.nextDouble() * 2 * pi;
      final pathPhase = rnd.nextDouble() * pi * 2;
      final fadePhase = rnd.nextDouble();
      final sz = 0.6 + 1.7 * rnd.nextDouble();
      final baseOp = 0.13 + 0.32 * rnd.nextDouble();

      final moveT = t * pathSpeed + pathPhase;
      final px = (baseX * size.width) + cos(moveT + dir) * (sz * 6.4);
      final py = (baseY * size.height) + sin(moveT + dir) * (sz * 4.6);

      final fadeT = ((t * fadeSpeed + fadePhase) % 1.0);
      double fade = fadeT < 0.5
          ? fadeT * 2
          : (1 - (fadeT - 0.5) * 2);
      fade = fade * fade * (3 - 2 * fade); // Smoothstep
      final op = baseOp * fade;

      final paint = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.7)
        ..color = Colors.white.withOpacity(op);

      canvas.drawCircle(Offset(px, py), sz, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FlareDustPainter oldDelegate) => true;
}