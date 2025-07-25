import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../theme/app_themes.dart';
import '../theme/base_theme.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;
  final storage = GetStorage();
  Timer? _timeThemeTimer;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
    _startTimeBasedSwitch();
    ever(themeMode, (_) => _updateAppTheme());
  }

  void _loadTheme() {
    final saved = storage.read('themeMode') ?? 'system';
    themeMode.value = saved == 'dark' ? ThemeMode.dark : saved == 'light' ? ThemeMode.light : ThemeMode.system;
    // Ensure GetX themeMode is set on startup
    Get.changeThemeMode(themeMode.value);
    _updateAppTheme();
  }

  void switchTheme(ThemeMode newMode) {
    themeMode.value = newMode;
    storage.write('themeMode', newMode.toString().split('.').last);
    Get.changeThemeMode(newMode); // This ensures GetMaterialApp updates immediately
    _updateAppTheme();
  }

  void _updateAppTheme() {
    ThemeData theme;
    if (themeMode.value == ThemeMode.dark) {
      theme = ThemeData(
        brightness: Brightness.dark,
        primaryColor: LumiFrameDarkTheme.primary,
        scaffoldBackgroundColor: LumiFrameDarkTheme.background,
        cardTheme: LumiFrameDarkTheme.cardTheme,
        snackBarTheme: LumiFrameDarkTheme.snackBarTheme,
        dividerTheme: LumiFrameDarkTheme.dividerTheme,
        inputDecorationTheme: LumiFrameDarkTheme.inputDecorationTheme,
        iconTheme: LumiFrameDarkTheme.iconTheme,
        switchTheme: LumiFrameDarkTheme.switchTheme,
        progressIndicatorTheme: LumiFrameDarkTheme.progressIndicatorTheme,
        // Add more as needed
      );
    } else if (themeMode.value == ThemeMode.light) {
      theme = AppThemes.lightTheme;
    } else {
      // Use platformBrightness for true system mode
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      theme = brightness == Brightness.dark
        ? ThemeData(
            brightness: Brightness.dark,
            primaryColor: LumiFrameDarkTheme.primary,
            scaffoldBackgroundColor: LumiFrameDarkTheme.background,
            cardTheme: LumiFrameDarkTheme.cardTheme,
            snackBarTheme: LumiFrameDarkTheme.snackBarTheme,
            dividerTheme: LumiFrameDarkTheme.dividerTheme,
            inputDecorationTheme: LumiFrameDarkTheme.inputDecorationTheme,
            iconTheme: LumiFrameDarkTheme.iconTheme,
            switchTheme: LumiFrameDarkTheme.switchTheme,
            progressIndicatorTheme: LumiFrameDarkTheme.progressIndicatorTheme,
          )
        : AppThemes.lightTheme;
    }
    theme = AppThemes.getTimeBasedTheme(theme); // Apply time variant
    Get.changeTheme(theme);
  }

  void _startTimeBasedSwitch() {
    _timeThemeTimer = Timer.periodic(const Duration(minutes: 30), (_) => _updateAppTheme());
  }

  @override
  void onClose() {
    _timeThemeTimer?.cancel();
    super.onClose();
  }
}