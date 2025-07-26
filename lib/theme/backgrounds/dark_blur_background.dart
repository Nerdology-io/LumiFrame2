import 'package:flutter/material.dart';
import 'dart:ui';
import '../app_colors.dart';

class DarkBlurBackground extends StatelessWidget {
  const DarkBlurBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 2.0,
              colors: [
                AppColors.darkPrimary.withOpacity(0.9),
                AppColors.darkSecondary,
                Color(0xFF0A0A0D), // Even darker depth
              ],
            ),
          ),
        ),
        
        // Subtle accent orb - top left
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.darkAccent.withOpacity(0.08),
                  AppColors.darkAccent.withOpacity(0.03),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        // Secondary accent orb - bottom right
        Positioned(
          bottom: -150,
          right: -150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.darkAccent.withOpacity(0.05),
                  AppColors.darkAccent.withOpacity(0.02),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        // Subtle geometric accent - center
        Positioned(
          top: MediaQuery.of(context).size.height * 0.3,
          right: MediaQuery.of(context).size.width * 0.2,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.darkAccent.withOpacity(0.04),
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
              color: Colors.black.withOpacity(0.10),
            ),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}
