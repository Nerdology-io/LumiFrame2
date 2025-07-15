import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'onboarding_carousel.dart';

class OnboardingStart extends StatelessWidget {
  const OnboardingStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to LumiFrame', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.to(const OnboardingCarousel()),
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}