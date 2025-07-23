import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../settings/advanced_settings_screen.dart';
import '../../settings/appearance_settings_screen.dart';
import '../../settings/media_sources_screen.dart';
import '../../settings/frame_settings_screen.dart';
import '../../profile/my_profile.dart';
import '../../../widgets/nav_shell_background_wrapper.dart';
import '../../../theme/glassmorphism_settings_wrapper.dart';
import '../../../services/media_service.dart';
import '../../../controllers/auth_controller.dart';
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
        child: Column(
          children: [
            // Profile section in its own glassmorphism container
            GlassmorphismSettingsWrapper(
              horizontalPadding: 16.0, // Padding from screen edges
              blurSigma: 10.0,  // Match nav shell default
              opacity: 0.1,     // Match nav shell default
              child: GestureDetector(
                onTap: () => Get.to(() => const MyProfile()),
                child: SizedBox(
                  width: double.infinity, // Force full width
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage('https://www.caseyscaptures.com/wp-content/uploads/IMG_0225-3000@70.jpg'),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                splashColor: Colors.white24,
                                highlightColor: Colors.white10,
                                onTap: () => Get.to(() => const MyProfile()),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 6, right: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha((255 * 0.5).round()),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final authCtrl = Get.find<AuthController>();
                        final user = authCtrl.currentUser.value;
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        
                        return Column(
                          children: [
                            Text(
                              user?.displayName ?? 'User Name',
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.w500, 
                                color: isDark ? Colors.white : Colors.black87
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? 'user@example.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Spacing between containers
            // Settings section in its own glassmorphism container
            GlassmorphismSettingsWrapper(
              horizontalPadding: 16.0, // Padding from screen edges
              blurSigma: 10.0,  // Match nav shell default
              opacity: 0.1,     // Match nav shell default
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
                      Get.to(() => NavShellBackgroundWrapper(
                        title: 'Frame Configuration',
                        child: FrameSettingsScreen(),
                      ));
                    },
                  ),
                  ListTile(
                    title: const Text('Appearance'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Get.to(() => const NavShellBackgroundWrapper(
                      title: 'Appearance Settings',
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
                        title: 'Media Sources',
                        child: MediaSourcesScreen(),
                      ));
                    },
                  ),
                  ListTile(
                    title: const Text('Advanced'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Get.to(() => const NavShellBackgroundWrapper(
                      title: 'Advanced Settings',
                      child: AdvancedSettingsScreen(),
                    )),
                  ),
                  // Add more settings options like notifications, account
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}