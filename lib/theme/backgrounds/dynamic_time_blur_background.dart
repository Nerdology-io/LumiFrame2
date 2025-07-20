import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dynamic_time_controller.dart';
import 'earlymorning_blur_background.dart';
import 'morning_blur_background.dart';
import 'afternoon_blur_background.dart';
import 'evening_blur_background.dart';
import 'lateevening_blur_background.dart';
import 'night_blur_background.dart' as night_light;
import 'earlymorning_dark_blur_background.dart';
import 'morning_dark_blur_background.dart';
import 'afternoon_dark_blur_background.dart';
import 'evening_dark_blur_background.dart';
import 'lateevening_dark_blur_background.dart';
import 'night_dark_blur_background.dart' as night_dark;

/// A background widget that switches based on the current time of day.
class DynamicTimeBlurBackground extends StatelessWidget {
  const DynamicTimeBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final DynamicTimeController timeCtrl = Get.find<DynamicTimeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      switch (timeCtrl.currentPeriod.value) {
        case TimeOfDayPeriod.earlyMorning:
          return isDark
              ? EarlyMorningDarkBlurBackground(child: child)
              : EarlyMorningBlurBackground(child: child);
        case TimeOfDayPeriod.morning:
          return isDark
              ? MorningDarkBlurBackground(child: child)
              : MorningBlurBackground(child: child);
        case TimeOfDayPeriod.afternoon:
          return isDark
              ? AfternoonDarkBlurBackground(child: child)
              : AfternoonBlurBackground(child: child);
        case TimeOfDayPeriod.evening:
          return isDark
              ? EveningDarkBlurBackground(child: child)
              : EveningBlurBackground(child: child);
        case TimeOfDayPeriod.lateEvening:
          return isDark
              ? LateEveningDarkBlurBackground(child: child)
              : LateEveningBlurBackground(child: child);
        case TimeOfDayPeriod.night:
          return isDark
              ? night_dark.NightDarkBlurBackground(child: child)
              : night_light.LightGradientBlurBackground(child: child);
      }
    });
  }
}
