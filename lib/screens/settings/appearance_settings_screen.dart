import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../controllers/theme_controller.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Appearance Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Theme Mode', style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: themeCtrl.themeMode.value,
            onChanged: (val) => themeCtrl.switchTheme(val!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: themeCtrl.themeMode.value,
            onChanged: (val) => themeCtrl.switchTheme(val!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: themeCtrl.themeMode.value,
            onChanged: (val) => themeCtrl.switchTheme(val!),
          ),
          // Add sliders for font size, color accents, etc.
        ],
      ),
    );
  }
}