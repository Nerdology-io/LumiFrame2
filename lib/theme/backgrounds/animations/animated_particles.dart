import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedParticles extends StatefulWidget {
  const AnimatedParticles({
    super.key,
    this.count = 130,
    this.minSize = 0.35,
    this.maxSize = 1.15,
    this.minOpacity = 0.35,
    this.maxOpacity = 0.70,
    this.minSpeed = 3.5,
    this.maxSpeed = 7.0,
    this.blurSigma = 2.3,
  });

  final int count;
  final double minSize, maxSize;
  final double minOpacity, maxOpacity;
  final double minSpeed, maxSpeed;
  final double blurSigma;

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with SingleTickerProviderStateMixin {
  late final List<_Particle> particles;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 110),
    )..repeat();
    particles = List.generate(widget.count, (i) => _Particle(widget));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final Size size = MediaQuery.sizeOf(context);
        final double t = controller.value;
        return IgnorePointer(
          child: CustomPaint(
            size: size,
            painter: _ParticlePainter(particles, t, widget.blurSigma),
          ),
        );
      },
    );
  }
}

class _Particle {
  late double x0, y0, size, opacity, speed, direction, driftAmp, phase, wobbleAmp, wobbleFreq;
  late Color color;

  _Particle(AnimatedParticles spec) {
    final rnd = Random();
    x0 = rnd.nextDouble();
    y0 = rnd.nextDouble();
    size = lerpDouble(spec.minSize, spec.maxSize, rnd.nextDouble())!;
    opacity = lerpDouble(spec.minOpacity, spec.maxOpacity, rnd.nextDouble())!;
    speed = lerpDouble(spec.minSpeed, spec.maxSpeed, rnd.nextDouble())!; // px/sec
    direction = rnd.nextDouble() * pi * 2; // radians
    driftAmp = rnd.nextDouble() * 8 + 3; // px (wobble radius)
    phase = rnd.nextDouble() * pi * 2;
    wobbleAmp = rnd.nextDouble() * 7 + 2;
    wobbleFreq = lerpDouble(0.2, 0.6, rnd.nextDouble())!;
    final possibleColors = [
      Colors.white,
      const Color(0xFFE5E6F6),
      const Color(0xFFB6BDE5),
      const Color(0xFF8B8DC7),
      const Color(0xFF3E4C77),
      const Color(0xFF89A4E0),
      Colors.lightBlueAccent,
      Colors.cyanAccent,
    ];
    color = possibleColors[rnd.nextInt(possibleColors.length)];
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double t;
  final double blurSigma;
  _ParticlePainter(this.particles, this.t, this.blurSigma);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      // Time-based displacement
      double dt = t * 100.0; // larger = slower overall system drift
      double x = p.x0 * size.width +
          cos(p.direction) * p.speed * dt +
          cos((dt + p.phase) * p.wobbleFreq) * p.driftAmp;
      double y = p.y0 * size.height +
          sin(p.direction) * p.speed * dt +
          sin((dt + p.phase) * p.wobbleFreq) * p.wobbleAmp;

      // Wrap around edges for infinite space
      x = (x + size.width) % size.width;
      y = (y + size.height) % size.height;

      final paint = Paint()
        ..color = p.color.withOpacity(p.opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
      canvas.drawCircle(Offset(x, y), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}