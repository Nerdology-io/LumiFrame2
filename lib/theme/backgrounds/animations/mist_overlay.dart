import 'dart:math';
import 'package:flutter/material.dart';

class MistOverlay extends StatefulWidget {
  const MistOverlay({super.key});
  @override
  State<MistOverlay> createState() => _MistOverlayState();
}
class _MistOverlayState extends State<MistOverlay> with SingleTickerProviderStateMixin {
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
          painter: _MistPainter(_controller.value),
        ),
      ),
    );
  }
}

class _MistPainter extends CustomPainter {
  final double t;
  _MistPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final bands = 4;
    for (int i = 0; i < bands; ++i) {
      final baseY = 0.70 + i * 0.06;
      final amp = 25 + i * 12;
      final freq = 0.012 + i * 0.004;
      final speed = 0.3 + 0.14 * i;
      final phase = t * 2 * pi * speed + i * pi / 3;

      final paint = Paint()
        ..color = Colors.white.withOpacity(0.09 - 0.018 * i)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 55 + i * 18)
        ..blendMode = BlendMode.screen;

      final path = Path();
      for (double x = 0; x <= size.width; x += 3) {
        double yy = size.height * baseY
          + sin(x * freq + phase) * amp
          + cos(x * (freq * 0.7) + phase * 1.3) * (amp * 0.4)
          + sin((x + size.width * 0.12) * freq * 1.23 + phase * 1.6) * (amp * 0.15);
        if (x == 0) {
          path.moveTo(x, yy);
        } else {
          path.lineTo(x, yy);
        }
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }
  @override
  bool shouldRepaint(covariant _MistPainter oldDelegate) => true;
}