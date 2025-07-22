import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings/appearance_settings_screen.dart';
import 'settings/media_sources_screen.dart';
import 'settings/advanced_settings_screen.dart';

import '../theme/glassmorphism_container.dart';
import '../widgets/nav_shell_background_wrapper.dart';
import 'settings/frame_settings_screen.dart';

import '../controllers/slideshow_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NavShellBackgroundWrapper(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: GlassmorphismContainer(
            borderRadius: BorderRadius.circular(24),
            blurSigma: 28,
            opacity: 0.32,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                      title: const Text('Advanced'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => Get.to(() => AdvancedSettingsScreen()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
