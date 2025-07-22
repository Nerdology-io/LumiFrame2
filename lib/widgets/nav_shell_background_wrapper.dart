import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  const NavShellBackgroundWrapper({
    super.key, 
    required this.child,
    this.title,
  });
  
  final Widget child;
  final String? title;

  // Dynamic background and overlay builder (same as ResponsiveNavShell)
  Widget buildDynamicBackgroundAndOverlay(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final period = Get.find<DynamicTimeController>().currentPeriod.value;
    switch (period) {
      case TimeOfDayPeriod.earlyMorning:
        return Stack(
          children: [
            isDark ? const EarlyMorningDarkBlurBackground() : const EarlyMorningBlurBackground(),
            const MistOverlay(),
          ],
        );
      case TimeOfDayPeriod.morning:
        return Stack(
          children: [
            isDark ? const MorningDarkBlurBackground() : const MorningBlurBackground(),
            const GodRayTopGlowOverlay(),
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
            isDark ? const EveningDarkBlurBackground() : const EveningBlurBackground(),
            const EveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.lateEvening:
        return Stack(
          children: [
            isDark ? const LateEveningDarkBlurBackground() : const LateEveningBlurBackground(),
            const LateEveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.night:
        return Stack(
          children: [
            isDark ? const NightDarkBlurBackground() : const LightGradientBlurBackground(),
            const StarfieldOverlay(),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Update system UI overlay style based on theme
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          ),
          title: title != null 
            ? Text(
                title!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              )
            : const Text(''),
        ),
        body: Stack(
          children: [
            buildDynamicBackgroundAndOverlay(context),
            child,
          ],
        ),
      ),
    );
  }
}
