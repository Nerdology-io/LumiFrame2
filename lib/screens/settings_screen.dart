import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings/appearance_settings_screen.dart';
import 'settings/media_sources_screen.dart';
import 'settings/advanced_settings_screen.dart';
import 'settings/frame_settings_screen.dart';

import '../theme/theme_extensions.dart';
import '../theme/backgrounds/dark_blur_background.dart';
import '../theme/backgrounds/light_blur_background.dart';
import '../controllers/slideshow_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            color: context.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.primaryTextColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Background
          isDark ? const DarkBlurBackground() : const LightBlurBackground(),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.glassBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.glassBorder,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings_display, color: context.accentColor),
                      title: Text(
                        'Frame Configuration',
                        style: TextStyle(
                          color: context.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: context.secondaryTextColor, size: 16),
                      onTap: () {
                        if (!Get.isRegistered<SlideshowController>()) {
                          Get.put(SlideshowController());
                        }
                        Get.to(() => FrameSettingsScreen());
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: context.borderColor.withValues(alpha: 0.3),
                    ),
                    ListTile(
                      leading: Icon(Icons.palette, color: context.accentColor),
                      title: Text(
                        'Appearance',
                        style: TextStyle(
                          color: context.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: context.secondaryTextColor, size: 16),
                      onTap: () => Get.to(() => AppearanceSettingsScreen()),
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: context.borderColor.withValues(alpha: 0.3),
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_library, color: context.accentColor),
                      title: Text(
                        'Media Sources',
                        style: TextStyle(
                          color: context.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: context.secondaryTextColor, size: 16),
                      onTap: () => Get.to(() => MediaSourcesScreen()),
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: context.borderColor.withValues(alpha: 0.3),
                    ),
                    ListTile(
                      leading: Icon(Icons.tune, color: context.accentColor),
                      title: Text(
                        'Advanced',
                        style: TextStyle(
                          color: context.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: context.secondaryTextColor, size: 16),
                      onTap: () => Get.to(() => AdvancedSettingsScreen()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
