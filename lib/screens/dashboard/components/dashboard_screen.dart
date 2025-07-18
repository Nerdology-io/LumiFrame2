import 'package:flutter/material.dart';
import '../../../theme/backgrounds/night_blur_background.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const NightGradientBlurBackground(),
          SafeArea(
            child: Center(child: Text('Dashboard Screen')),
          ),
        ],
      ),
    );
  }
}
