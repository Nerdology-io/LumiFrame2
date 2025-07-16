import 'package:flutter/material.dart';
import 'components/onboarding_step.dart';
import 'components/onboarding_indicator.dart';
import 'package:get/Get.dart';
// import '../auth/email_address_screen.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              const OnboardingStep(title: 'Welcome to LumiFrame', description: 'Your digital photo frame app.'),
              const OnboardingStep(title: 'Customize Your Experience', description: 'Choose themes, media, and more.'),
              const OnboardingStep(title: 'Get Started', description: 'Sign in or create an account.'),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: OnboardingIndicator(currentPage: _currentPage, pageCount: 3),
          ),
          if (_currentPage == 2)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/auth/login'),
                  child: const Text('Next'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}