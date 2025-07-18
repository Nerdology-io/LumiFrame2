import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dynamic_time_controller.dart';
import 'earlymorning_blur_background.dart';
import 'morning_blur_background.dart';
import 'afternoon_blur_background.dart';
import 'evening_blur_background.dart';
import 'lateevening_blur_background.dart';
import 'night_blur_background.dart';

/// A background widget that switches based on the current time of day.
class DynamicTimeBlurBackground extends StatelessWidget {
  const DynamicTimeBlurBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final DynamicTimeController timeCtrl = Get.find<DynamicTimeController>();
    return Obx(() {
      switch (timeCtrl.currentPeriod.value) {
        case TimeOfDayPeriod.earlyMorning:
          return EarlyMorningBlurBackground(child: child);
        case TimeOfDayPeriod.morning:
          return MorningBlurBackground(child: child);
        case TimeOfDayPeriod.afternoon:
          return AfternoonBlurBackground(child: child);
        case TimeOfDayPeriod.evening:
          return EveningBlurBackground(child: child);
        case TimeOfDayPeriod.lateEvening:
          return LateEveningBlurBackground(child: child);
        case TimeOfDayPeriod.night:
        return NightGradientBlurBackground(child: child);
      }
    });
  }
}
