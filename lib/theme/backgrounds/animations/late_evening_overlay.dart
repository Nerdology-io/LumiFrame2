import 'dart:math';
import 'package:flutter/material.dart';

class LateEveningOverlay extends StatefulWidget {
  const LateEveningOverlay({super.key});
  @override
  State<LateEveningOverlay> createState() => _LateEveningOverlayState();
}

class _LateEveningOverlayState extends State<LateEveningOverlay> with SingleTickerProviderStateMixin {
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
          painter: _LateEveningPainter(_controller.value),
        ),
      ),
    );
  }
}

class _LateEveningPainter extends CustomPainter {
  final double t;
  _LateEveningPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    // 3 soft blue wisps drifting horizontally
    for (int i = 0; i < 3; ++i) {
      final amp = 90 + i * 30.0;
      final baseY = size.height * (0.25 + 0.23 * i);
      final speed = 0.14 + 0.09 * i;
      final offset = size.width * (0.33 * i) + sin(t * 2 * pi * speed + i * 1.6) * 36;
      final wispWidth = size.width * (0.55 + 0.14 * i);
      final rect = Rect.fromLTWH(
        offset - wispWidth / 2,
        baseY - amp / 2,
        wispWidth,
        amp,
      );
      final paint = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 52 + i * 10)
        ..shader = LinearGradient(
          colors: [
            const Color(0xFF56B4D3).withOpacity(0.07 + 0.03 * i),
            Colors.transparent,
          ],
        ).createShader(rect);
      canvas.drawOval(rect, paint);
    }

    // Twinkling blue/white dots in upper third
    final rnd = Random(6868);
    for (int i = 0; i < 16; ++i) {
      final baseX = rnd.nextDouble();
      final baseY = 0.12 + rnd.nextDouble() * 0.20;
      final pathSpeed = 0.08 + 0.09 * rnd.nextDouble();
      final fadeSpeed = 0.6 + 1.0 * rnd.nextDouble();
      final pathPhase = rnd.nextDouble() * pi * 2;
      final fadePhase = rnd.nextDouble();
      final sz = 1.7 + 3.7 * rnd.nextDouble();
      final baseOp = 0.09 + 0.22 * rnd.nextDouble();
      final moveT = t * pathSpeed + pathPhase;
      final px = (baseX * size.width) + cos(moveT) * (sz * 4.0);
      final py = (baseY * size.height) + sin(moveT) * (sz * 1.2);
      final fadeT = ((t * fadeSpeed + fadePhase) % 1.0);
      double fade = fadeT < 0.5
          ? fadeT * 2
          : (1 - (fadeT - 0.5) * 2);
      fade = fade * fade * (3 - 2 * fade);
      final op = baseOp * fade;
      final paint = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.5)
        ..color = (i % 2 == 0
            ? const Color(0xFF6AC7E3)
            : Colors.white)
          .withOpacity(op);

      canvas.drawCircle(Offset(px, py), sz, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LateEveningPainter oldDelegate) => true;
}