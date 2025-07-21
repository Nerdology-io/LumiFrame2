import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings/appearance_settings_screen.dart';
import 'settings/media_sources_screen.dart';
import 'settings/advanced_settings_screen.dart';
import 'settings/frame_settings_screen.dart';

import '../controllers/slideshow_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Appearance'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.to(() => AppearanceSettingsScreen()),
          ),
          ListTile(
            title: const Text('Media Sources'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.to(() => MediaSourcesScreen()),
          ),
          ListTile(
            title: const Text('Frame Configuration'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (!Get.isRegistered<SlideshowController>()) {
                Get.put(SlideshowController());
              }
              Get.to(() => FrameSettingsScreen());
            },
          ),
          ListTile(
            title: const Text('Advanced'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.to(() => AdvancedSettingsScreen()),
          ),
        ],
      ),
    );
  }
}
