import 'package:flutter/material.dart';
import 'dart:ui';

class DarkBlurBackground extends StatelessWidget {
  const DarkBlurBackground({super.key, this.child});

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
                Color(0xFF181A20), // deep dark
                Color(0xFF23272F), // slightly lighter
                Color(0xFF2C2F36), // accent
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              color: Colors.black.withOpacity(0.15),
            ),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}
