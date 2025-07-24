import 'package:flutter/material.dart';
import 'components/onboarding_step.dart';
import 'components/onboarding_indicator.dart';
import 'time_adaptive_onboarding.dart';
import 'customize_experience_onboarding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
              const CustomizeExperienceOnboarding(),
              const TimeAdaptiveOnboarding(),
              const OnboardingStep(title: 'Get Started', description: 'Sign in or create an account.'),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: OnboardingIndicator(currentPage: _currentPage, pageCount: 4),
          ),
          if (_currentPage == 3)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Set onboarding_completed flag and let RootWidget handle auth flow
                      final box = GetStorage();
                      box.write('onboarding_completed', true);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.offAllNamed('/auth/login');
                      });
                    },
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Set onboarding_completed flag and let RootWidget handle auth flow
                      final box = GetStorage();
                      box.write('onboarding_completed', true);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.offAllNamed('/auth/login');
                      });
                    },
                    child: const Text('Skip to Login'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}