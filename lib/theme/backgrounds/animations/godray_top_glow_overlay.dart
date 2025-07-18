import 'dart:math';
import 'package:flutter/material.dart';

class GodRayTopGlowOverlay extends StatefulWidget {
  const GodRayTopGlowOverlay({super.key});
  @override
  State<GodRayTopGlowOverlay> createState() => _GodRayTopGlowOverlayState();
}

class _GodRayTopGlowOverlayState extends State<GodRayTopGlowOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: const Duration(seconds: 52))..repeat();
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _GlowPulseAndDustPainter(_controller.value),
        ),
      ),
    );
  }
}

class _GlowPulseAndDustPainter extends CustomPainter {
  final double t;
  _GlowPulseAndDustPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    // --- 1. The original animated vertical glow pulse ---
    final anim = 0.6 + 0.4 * sin(t * 2 * pi);
    final centerY = _lerpDouble(-size.height * 0.28, size.height * 0.38, anim);
    final glowHeight = size.height * 0.45;
    final rect = Rect.fromLTRB(
      -size.width * 0.1, centerY,
      size.width * 1.1, centerY + glowHeight,
    );

    final paint = Paint()
      ..blendMode = BlendMode.screen
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120)
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.10),
          Colors.white.withOpacity(0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 1.0],
      ).createShader(rect);

    canvas.drawRRect(
      RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(200), topRight: const Radius.circular(200)),
      paint,
    );

    // --- 2. Large radial "blob" in the upper right, even more blurred, fades out further ---
    final sunCenter = Offset(size.width * 0.92, size.height * 0.07);
    final sunRadius = size.shortestSide * 0.44; // larger and more faded
    final sunPaint = Paint()
      ..blendMode = BlendMode.screen
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, sunRadius * 1.65); // more gaussian blur!
    final sunGradient = RadialGradient(
      center: Alignment.center,
      radius: 1.23, // fade further!
      colors: [
        Colors.white.withOpacity(0.12),
        Colors.white.withOpacity(0.035),
        Colors.transparent,
      ],
      stops: const [0.0, 0.47, 1.0],
    );
    final sunRect = Rect.fromCircle(center: sunCenter, radius: sunRadius * 1.14);
    sunPaint.shader = sunGradient.createShader(sunRect);
    canvas.drawCircle(sunCenter, sunRadius, sunPaint);

    // --- 3. Small, fast-moving sun dust particles, dense and dreamy ---
    final rnd = Random(4442);
    for (int i = 0; i < 440; ++i) {
      final dx = rnd.nextDouble();
      final dy = rnd.nextDouble();
      final pathSpeed = 0.55 + 0.85 * rnd.nextDouble(); // faster
      final pathPhase = rnd.nextDouble() * pi * 2;
      final dir = rnd.nextDouble() * 2 * pi;
      final sz = 0.15 + 0.31 * pow(rnd.nextDouble(), 1.6); // very small
      final op = 0.09 + 0.18 * rnd.nextDouble();

      final moveT = t * pathSpeed + pathPhase;
      final px = (dx * size.width) + cos(moveT + dir) * (sz * 13.0);
      final py = (dy * size.height) + sin(moveT + dir) * (sz * 7.4);

      final p = Paint()
        ..blendMode = BlendMode.screen
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.6 + sz * 0.32)
        ..color = Colors.white.withOpacity(op);

      canvas.drawCircle(Offset(px, py), sz, p);
    }
  }

  @override
  bool shouldRepaint(covariant _GlowPulseAndDustPainter oldDelegate) => true;
}

double _lerpDouble(num a, num b, double t) => a + (b - a) * t;