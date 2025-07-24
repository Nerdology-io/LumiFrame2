import 'package:flutter/material.dart';
import 'time_adaptive_onboarding.dart';

class OnboardingStart extends StatelessWidget {
  const OnboardingStart({super.key});

  @override
  Widget build(BuildContext context) {
    // Directly show the time adaptive onboarding as the start screen
    return const TimeAdaptiveOnboarding();
  }
}