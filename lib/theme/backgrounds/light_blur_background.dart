import 'package:flutter/material.dart';
import 'dart:ui';
import '../app_colors.dart';

class LightBlurBackground extends StatelessWidget {
  const LightBlurBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 2.0,
              colors: [
                AppColors.lightPrimary,
                AppColors.lightSecondary,
                Color(0xFFE8E8E8), // Subtle depth
              ],
            ),
          ),
        ),
        
        // Subtle accent orb - top right
        Positioned(
          top: -80,
          right: -80,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.lightAccent.withOpacity(0.06),
                  AppColors.lightAccent.withOpacity(0.02),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        // Secondary accent orb - bottom left
        Positioned(
          bottom: -120,
          left: -120,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.lightAccent.withOpacity(0.04),
                  AppColors.lightAccent.withOpacity(0.01),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        // Subtle geometric accent - center left
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: MediaQuery.of(context).size.width * 0.1,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.lightAccent.withOpacity(0.03),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}
