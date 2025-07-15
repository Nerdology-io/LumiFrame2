import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

class LuminousRadialBackground extends StatelessWidget {
  final bool isLightMode;

  const LuminousRadialBackground({super.key, this.isLightMode = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _LuminousRadialPainter(isLightMode: isLightMode),
    );
  }
}

class _LuminousRadialPainter extends CustomPainter {
  final bool isLightMode;

  _LuminousRadialPainter({required this.isLightMode});

  @override
  void paint(Canvas canvas, Size size) {
    // Background color based on mode
    final bgColor = isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF0C0C0F);
    final bgPaint = Paint()..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Radial gradient for luminous effect
    final center = Offset(size.width / 2, size.height / 2);
    final gradient = RadialGradient(
      center: Alignment.center,
      radius: 1.2,
      colors: isLightMode
          ? [Colors.white.withValues(alpha: 0.1), Colors.transparent]
          : [Colors.blue.withValues(alpha: 0.2), Colors.transparent],
      stops: [0.0, 1.0],
    );

    final gradientPaint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: size.width / 2));

    canvas.drawCircle(center, size.width / 1.5, gradientPaint);

    // Subtle glow layers
    final glowLayers = [
      {'radius': size.width * 0.3, 'opacity': 0.1},
      {'radius': size.width * 0.5, 'opacity': 0.05},
    ];

    for (final layer in glowLayers) {
      final glowPaint = Paint()
        ..color = Colors.blue.withValues(alpha: layer['opacity'] as double)
        ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.outer, 20.0);

      canvas.drawCircle(center, layer['radius'] as double, glowPaint);
    }

    // Optional noise for texture
    final random = Random(123); // Fixed seed for consistency
    final noisePaint = Paint()..color = Colors.white.withValues(alpha: 0.01);
    for (int i = 0; i < 200; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 1.0, noisePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}