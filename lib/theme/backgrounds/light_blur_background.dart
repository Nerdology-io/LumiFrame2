import 'package:flutter/material.dart';
import 'dart:ui';

class LightBlurBackground extends StatelessWidget {
  const LightBlurBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF7F8FA), // elegant white
                Color(0xFFE3E6EC), // soft gray
                Color(0xFFDDE2EA), // accent
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              color: Colors.white.withOpacity(0.12),
            ),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}
