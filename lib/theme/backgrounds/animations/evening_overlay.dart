import 'dart:math';
import 'package:flutter/material.dart';

class EveningOverlay extends StatefulWidget {
  const EveningOverlay({super.key});
  @override
  State<EveningOverlay> createState() => _EveningOverlayState();
}

class _EveningOverlayState extends State<EveningOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 50))..repeat();
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _EveningGlowPainter(_controller.value),
        ),
      ),
    );
  }
}

class _EveningGlowPainter extends CustomPainter {
  final double t;
  _EveningGlowPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    // Sunset glow, softly pulsing up
    final anim = 0.7 + 0.2 * sin(t * 2 * pi);
    final bottomGlowHeight = size.height * (0.27 + anim * 0.08);

    final rect = Rect.fromLTRB(
      -size.width * 0.05,
      size.height - bottomGlowHeight,
      size.width * 1.05,
      size.height * 1.05,
    );
    final glowPaint = Paint()
      ..blendMode = BlendMode.screen
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 85)
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          const Color(0xFFFFBB56).withOpacity(0.17),
          const Color(0xFFF35544).withOpacity(0.11),
          Colors.transparent,
        ],
        stops: const [0.0, 0.2, 1.0],
      ).createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndCorners(rect, bottomLeft: const Radius.circular(220), bottomRight: const Radius.circular(220)),
      glowPaint,
    );

    // Flickering "evening fireflies" near the bottom, warm orange
    final rnd = Random(5555);
    for (int i = 0; i < 18; ++i) {
      final baseX = rnd.nextDouble();
      final baseY = 0.82 + rnd.nextDouble() * 0.18;
      final pathSpeed = 0.5 + 1.1 * rnd.nextDouble();
      final fadeSpeed = 1.0 + 1.7 * rnd.nextDouble();
      final pathPhase = rnd.nextDouble() * pi * 2;
      final fadePhase = rnd.nextDouble();
      final sz = 2.2 + 5.5 * rnd.nextDouble();
      final baseOp = 0.16 + 0.35 * rnd.nextDouble();
      final moveT = t * pathSpeed + pathPhase;
      final px = (baseX * size.width) + sin(moveT) * (sz * 3.4);
      final py = (baseY * size.height) + cos(moveT) * (sz * 1.2);
      final fadeT = ((t * fadeSpeed + fadePhase) % 1.0);
      double fade = fadeT < 0.5
          ? fadeT * 2
          : (1 - (fadeT - 0.5) * 2);
      fade = fade * fade * (3 - 2 * fade);
      final op = baseOp * fade;
      final paint = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 9.5)
        ..color = const Color(0xFFF9AE63).withOpacity(op);

      canvas.drawCircle(Offset(px, py), sz, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _EveningGlowPainter oldDelegate) => true;
}