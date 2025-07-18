import 'package:flutter/material.dart';
import '../../../theme/backgrounds/dynamic_time_blur_background.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const DynamicTimeBlurBackground(),
          SafeArea(
            child: Center(child: Text('Dashboard Screen')),
          ),
        ],
      ),
    );
  }
}
