import 'package:flutter/material.dart';

class OnboardingStep extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingStep({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}