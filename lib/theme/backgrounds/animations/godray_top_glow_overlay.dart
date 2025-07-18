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
          painter: _GlowPulsePainter(_controller.value),
        ),
      ),
    );
  }
}

class _GlowPulsePainter extends CustomPainter {
  final double t;
  _GlowPulsePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final anim = 0.6 + 0.4 * sin(t * 2 * pi); // 0.2 to 1.0
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
  }

  @override
  bool shouldRepaint(covariant _GlowPulsePainter oldDelegate) => true;
}

double _lerpDouble(num a, num b, double t) => a + (b - a) * t;