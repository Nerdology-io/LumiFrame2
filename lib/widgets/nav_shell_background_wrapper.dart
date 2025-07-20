import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Theme and background imports
import '../theme/backgrounds/earlymorning_blur_background.dart';
import '../theme/backgrounds/earlymorning_dark_blur_background.dart';
import '../theme/backgrounds/morning_blur_background.dart';
import '../theme/backgrounds/morning_dark_blur_background.dart';
import '../theme/backgrounds/afternoon_blur_background.dart';
import '../theme/backgrounds/afternoon_dark_blur_background.dart';
import '../theme/backgrounds/evening_blur_background.dart';
import '../theme/backgrounds/evening_dark_blur_background.dart';
import '../theme/backgrounds/lateevening_blur_background.dart';
import '../theme/backgrounds/lateevening_dark_blur_background.dart';
import '../theme/backgrounds/night_blur_background.dart';
import '../theme/backgrounds/night_dark_blur_background.dart';
import '../theme/backgrounds/animations/mist_overlay.dart';
import '../theme/backgrounds/animations/godray_top_glow_overlay.dart';
import '../theme/backgrounds/animations/flare_dust_overlay.dart';
import '../theme/backgrounds/animations/evening_overlay.dart';
import '../theme/backgrounds/animations/late_evening_overlay.dart';
import '../theme/backgrounds/animations/starfield_overlay.dart';

// Controllers
import '../controllers/dynamic_time_controller.dart';

/// Wrapper widget that provides nav shell's dynamic backgrounds to any child screen
class NavShellBackgroundWrapper extends StatelessWidget {
  const NavShellBackgroundWrapper({super.key, required this.child});
  
  final Widget child;

  // Dynamic background and overlay builder (same as ResponsiveNavShell)
  Widget buildDynamicBackgroundAndOverlay(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final period = Get.find<DynamicTimeController>().currentPeriod.value;
    switch (period) {
      case TimeOfDayPeriod.earlyMorning:
        return Stack(
          children: [
            isDark ? EarlyMorningDarkBlurBackground() : EarlyMorningBlurBackground(),
            MistOverlay(),
          ],
        );
      case TimeOfDayPeriod.morning:
        return Stack(
          children: [
            isDark ? MorningDarkBlurBackground() : MorningBlurBackground(),
            GodRayTopGlowOverlay(),
          ],
        );
      case TimeOfDayPeriod.afternoon:
        return Stack(
          children: [
            isDark ? const AfternoonDarkBlurBackground() : const AfternoonBlurBackground(),
            const FlareDustOverlay(),
          ],
        );
      case TimeOfDayPeriod.evening:
        return Stack(
          children: [
            isDark ? EveningDarkBlurBackground() : EveningBlurBackground(),
            EveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.lateEvening:
        return Stack(
          children: [
            isDark ? LateEveningDarkBlurBackground() : LateEveningBlurBackground(),
            LateEveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.night:
        return Stack(
          children: [
            isDark ? NightDarkBlurBackground() : LightGradientBlurBackground(),
            StarfieldOverlay(),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''), // Can be customized by child if needed
      ),
      body: Stack(
        children: [
          buildDynamicBackgroundAndOverlay(context),
          child,
        ],
      ),
    );
  }
}
