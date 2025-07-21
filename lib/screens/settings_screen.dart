import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings/appearance_settings_screen.dart';
import 'settings/media_sources_screen.dart';
import 'settings/advanced_settings_screen.dart';

import '../theme/glassmorphism_container.dart';
import 'settings/frame_settings_screen.dart';

import '../controllers/slideshow_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GlassmorphismContainer(
            borderRadius: BorderRadius.circular(20),
            child: ListTile(
              title: const Text('Appearance'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.to(() => AppearanceSettingsScreen()),
            ),
          ),
          const SizedBox(height: 16),
          GlassmorphismContainer(
            borderRadius: BorderRadius.circular(20),
            child: ListTile(
              title: const Text('Media Sources'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.to(() => MediaSourcesScreen()),
            ),
          ),
          const SizedBox(height: 16),
          GlassmorphismContainer(
            borderRadius: BorderRadius.circular(20),
            child: ListTile(
              title: const Text('Frame Configuration'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                if (!Get.isRegistered<SlideshowController>()) {
                  Get.put(SlideshowController());
                }
                Get.to(() => FrameSettingsScreen());
              },
            ),
          ),
          const SizedBox(height: 16),
          GlassmorphismContainer(
            borderRadius: BorderRadius.circular(20),
            child: ListTile(
              title: const Text('Advanced'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.to(() => AdvancedSettingsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
