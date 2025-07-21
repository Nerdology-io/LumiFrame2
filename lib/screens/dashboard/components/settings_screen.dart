import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../settings/advanced_settings_screen.dart';
import '../../settings/appearance_settings_screen.dart';
import '../../settings/media_sources_screen.dart';
import '../../settings/frame_settings_screen.dart';
import '../../../widgets/nav_shell_background_wrapper.dart';
import '../../../services/media_service.dart';
import '../../../services/firebase_service.dart';
import '../../../controllers/slideshow_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Frame Configuration'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                if (!Get.isRegistered<SlideshowController>()) {
                  Get.put(SlideshowController());
                }
                Get.to(() => NavShellBackgroundWrapper(
                  child: FrameSettingsScreen(),
                ));
              },
            ),
            ListTile(
              title: const Text('Appearance'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.to(() => const NavShellBackgroundWrapper(
                child: AppearanceSettingsScreen(),
              )),
            ),
            ListTile(
              title: const Text('Media Sources'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Register required services before navigation
                if (!Get.isRegistered<MediaService>()) {
                  Get.put(MediaService());
                }
                if (!Get.isRegistered<FirebaseService>()) {
                  Get.put(FirebaseService());
                }
                Get.to(() => const NavShellBackgroundWrapper(
                  child: MediaSourcesScreen(),
                ));
              },
            ),
            ListTile(
              title: const Text('Advanced'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.to(() => const NavShellBackgroundWrapper(
                child: AdvancedSettingsScreen(),
              )),
            ),
            // Add more settings options like notifications, account
          ],
        ),
      ),
    );
  }
}