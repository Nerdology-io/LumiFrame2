import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_radio_input.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            GlassmorphismSettingsWrapper(
              horizontalPadding: 16.0,
              blurSigma: 10.0,
              opacity: 0.1,
              child: Column(
                children: [
                  Obx(() => GlassmorphismRadioInput<ThemeMode>(
                    labelText: 'Theme Mode',
                    value: themeCtrl.themeMode.value,
                    options: const [ThemeMode.light, ThemeMode.dark, ThemeMode.system],
                    onChanged: (val) {
                      if (val != null) themeCtrl.switchTheme(val);
                    },
                    padding: EdgeInsets.zero, // Remove default padding for alignment
                    optionDisplayText: (mode) {
                      switch (mode) {
                        case ThemeMode.light:
                          return 'Light';
                        case ThemeMode.dark:
                          return 'Dark';
                        case ThemeMode.system:
                          return 'System';
                      }
                    },
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}