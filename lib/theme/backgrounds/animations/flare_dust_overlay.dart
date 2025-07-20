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
    // 1. Larger, ultra-blurred orb in the upper right
    final flareCenter = Offset(size.width * 0.85, size.height * 0.13);
    final baseRadius = size.width * 0.31; // much larger

    for (int i = 0; i < 4; ++i) {
      final phaseShift = t * 2 * pi * (1.14 + i * 0.11);
      final flareRadius = baseRadius * (1.16 + i * 0.57 + sin(phaseShift) * 0.23);
      final paint = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 90 + i * 22) // much blurrier!
        ..shader = RadialGradient(
          colors: [
            Colors.white.withOpacity(0.09 / (i + 1)),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: flareCenter, radius: flareRadius));
      canvas.drawCircle(flareCenter, flareRadius, paint);
    }

    // 2. Finer, faster, denser sun dust particles
    final rnd = Random(7777);
    for (int i = 0; i < 350; ++i) {
      final baseX = rnd.nextDouble();
      final baseY = rnd.nextDouble();
      final pathSpeed = 1.1 + 2.5 * rnd.nextDouble(); // faster
      final fadeSpeed = 1.2 + 2.5 * rnd.nextDouble();
      final dir = rnd.nextDouble() * 2 * pi;
      final pathPhase = rnd.nextDouble() * pi * 2;
      final fadePhase = rnd.nextDouble();
      final sz = 0.14 + 0.24 * pow(rnd.nextDouble(), 2.3); // very fine
      final baseOp = 0.10 + 0.17 * rnd.nextDouble();

      final moveT = t * pathSpeed + pathPhase;
      final px = (baseX * size.width) + cos(moveT + dir) * (sz * 13.4);
      final py = (baseY * size.height) + sin(moveT + dir) * (sz * 7.7);

      final fadeT = ((t * fadeSpeed + fadePhase) % 1.0);
      double fade = fadeT < 0.5
          ? fadeT * 2
          : (1 - (fadeT - 0.5) * 2);
      fade = fade * fade * (3 - 2 * fade); // Smoothstep
      final op = baseOp * fade;

      final paint = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1.2)
        ..color = Colors.white.withOpacity(op);

      canvas.drawCircle(Offset(px, py), sz, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FlareDustPainter oldDelegate) => true;
}