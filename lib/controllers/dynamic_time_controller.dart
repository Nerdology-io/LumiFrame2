import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Enum for the different times of day
enum TimeOfDayPeriod {
  earlyMorning, // 5AM - 8AM
  morning,      // 8AM - 12PM
  afternoon,    // 12PM - 4PM
  evening,      // 5PM - 8PM
  lateEvening,  // 8PM - 11PM
  night,        // 11PM - 5AM
}

/// Controller to determine the current time period and notify listeners
class DynamicTimeController extends GetxController {
  final Rx<TimeOfDayPeriod> currentPeriod = Rx<TimeOfDayPeriod>(_getPeriodForNow());

  /// Call this to update the period (e.g. on timer or app resume)
  void updatePeriod() {
    currentPeriod.value = _getPeriodForNow();
  }

  /// Returns the current period based on system time
  static TimeOfDayPeriod _getPeriodForNow() {
    final now = DateTime.now();
    final hour = now.hour;
    if (hour >= 5 && hour < 8) {
      return TimeOfDayPeriod.earlyMorning;
    } else if (hour >= 8 && hour < 12) {
      return TimeOfDayPeriod.morning;
    } else if (hour >= 12 && hour < 16) {
      return TimeOfDayPeriod.afternoon;
    } else if (hour >= 17 && hour < 20) {
      return TimeOfDayPeriod.evening;
    } else if (hour >= 20 && hour < 23) {
      return TimeOfDayPeriod.lateEvening;
    } else {
      // 11PM - 5AM
      return TimeOfDayPeriod.night;
    }
  }

  /// Optionally, get a string label for the current period
  String get periodLabel {
    switch (currentPeriod.value) {
      case TimeOfDayPeriod.earlyMorning:
        return 'Early Morning';
      case TimeOfDayPeriod.morning:
        return 'Morning';
      case TimeOfDayPeriod.afternoon:
        return 'Afternoon';
      case TimeOfDayPeriod.evening:
        return 'Evening';
      case TimeOfDayPeriod.lateEvening:
        return 'Late Evening';
      case TimeOfDayPeriod.night:
        return 'Night';
    }
  }
}
