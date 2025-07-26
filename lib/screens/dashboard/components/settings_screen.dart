import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../settings/advanced_settings_screen.dart';
import '../../settings/appearance_settings_screen.dart';
import '../../settings/media_sources_screen.dart';
import '../../settings/frame_settings_screen.dart';
import '../../profile/my_profile.dart';
import '../../../theme/theme_extensions.dart';
import '../../../theme/backgrounds/dark_blur_background.dart';
import '../../../theme/backgrounds/light_blur_background.dart';
import '../../../services/media_service.dart';
import '../../../controllers/auth_controller.dart';
import '../../../services/firebase_service.dart';
import '../../../controllers/slideshow_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background
          if (isDark)
            const DarkBlurBackground()
          else
            const LightBlurBackground(),
          
          SafeArea(
            child: Column(
              children: [
                // Profile section
                _buildProfileSection(context, theme, isDark),
                const SizedBox(height: 16),
                // Settings section
                _buildSettingsSection(context, theme, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, ThemeData theme, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: context.glassBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.glassBorder,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.to(() => MyProfile()),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Image
                Obx(() {
                  final authCtrl = Get.find<AuthController>();
                  final user = authCtrl.currentUser.value;
                  
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user?.photoURL != null 
                          ? NetworkImage(user!.photoURL!)
                          : null,
                        backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                        child: user?.photoURL == null
                          ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )
                          : null,
                      ),
                      // Small arrow indicator
                      Positioned(
                        right: 0,
                        bottom: 5,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: context.accentColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 12),
                Obx(() {
                  final authCtrl = Get.find<AuthController>();
                  final user = authCtrl.currentUser.value;
                  
                  return Column(
                    children: [
                      Text(
                        user?.displayName ?? 'User Name',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? 'user@example.com',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: context.secondaryTextColor,
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
    );
  }

  Widget _buildSettingsSection(BuildContext context, ThemeData theme, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: context.glassBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.glassBorder,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSettingsTile(
            title: 'Frame Configuration',
            onTap: () {
              if (!Get.isRegistered<SlideshowController>()) {
                Get.put(SlideshowController());
              }
              Get.to(() => FrameSettingsScreen());
            },
            theme: theme,
            context: context,
          ),
          _buildSettingsTile(
            title: 'Appearance',
            onTap: () => Get.to(() => const AppearanceSettingsScreen()),
            theme: theme,
            context: context,
          ),
          _buildSettingsTile(
            title: 'Media Sources',
            onTap: () {
              // Register required services before navigation
              if (!Get.isRegistered<MediaService>()) {
                Get.put(MediaService());
              }
              if (!Get.isRegistered<FirebaseService>()) {
                Get.put(FirebaseService());
              }
              Get.to(() => const MediaSourcesScreen());
            },
            theme: theme,
            context: context,
          ),
          _buildSettingsTile(
            title: 'Advanced',
            onTap: () => Get.to(() => const AdvancedSettingsScreen()),
            theme: theme,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required VoidCallback onTap,
    required ThemeData theme,
    required BuildContext context,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: context.secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
