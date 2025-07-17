import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isDarkMode = (Get.isDarkMode).obs;

  // Handle selection (special case for full-screen slideshow)
  void onItemSelected(int index) {
    if (index == 2) {
      // Launch slideshow as full-screen route
      Get.toNamed('/slideshow');
    } else {
      selectedIndex.value = index;
    }
  }

  // Optional: Dynamic theming hook (future-proofing)
  @override
  void onInit() {
    super.onInit();
    // Example: Timer or stream to change theme based on time of day
    // ever(selectedIndex, (_) => _updateThemeBasedOnTime());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateThemeBasedOnTime(); // Initial check
    });
  }

  void _updateThemeBasedOnTime() {
    final hour = DateTime.now().hour;
    if (hour >= 18 || hour < 6) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    // Extend for more modes, e.g., based on user prefs or system
  }
}
