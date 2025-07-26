import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/advanced_settings_controller.dart';
import '../../theme/theme_extensions.dart';
import '../../theme/backgrounds/dark_blur_background.dart';
import '../../theme/backgrounds/light_blur_background.dart';
import '../../theme/buttons/glassmorphism_action_button.dart';
import '../../theme/buttons/glassmorphism_dropdown.dart';

class AdvancedSettingsScreen extends StatelessWidget {
  const AdvancedSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final advancedController = Get.put(AdvancedSettingsController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Advanced Settings',
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
          if (isDark)
            const DarkBlurBackground()
          else
            const LightBlurBackground(),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  // Performance Section
                  _buildSettingsSection(
                    context: context,
                    title: "Performance",
                    children: [
                      // Slideshow Frame Rate
                      Obx(() => GlassmorphismDropdown<String>(
                        labelText: 'Slideshow Frame Rate',
                        value: advancedController.slideshowFrameRate.value,
                        items: const ['24 FPS', '30 FPS', '60 FPS', 'Unlimited'],
                        onChanged: (val) {
                          if (val != null) advancedController.setSlideshowFrameRate(val);
                        },
                        padding: EdgeInsets.zero,
                      )),
                      // Media Quality
                      Obx(() => GlassmorphismDropdown<String>(
                        labelText: 'Media Quality',
                        value: advancedController.mediaQuality.value,
                        items: const ['Auto', 'High', 'Medium', 'Low'],
                        onChanged: (val) {
                          if (val != null) advancedController.setMediaQuality(val);
                        },
                        padding: EdgeInsets.zero,
                      )),
                      // Preload Next Slide
                      Obx(() => _buildSwitchTile(
                        context: context,
                        title: 'Preload Next Slide',
                        subtitle: 'Improves slideshow performance',
                        value: advancedController.preloadNextSlide.value,
                        onChanged: advancedController.setPreloadNextSlide,
                      )),
                      // Hardware Acceleration
                      Obx(() => _buildSwitchTile(
                        context: context,
                        title: 'Hardware Acceleration',
                        subtitle: 'Use GPU for better performance',
                        value: advancedController.hardwareAcceleration.value,
                        onChanged: advancedController.setHardwareAcceleration,
                      )),
                      // Use Image Cache
                      Obx(() => _buildSwitchTile(
                        context: context,
                        title: 'Use Image Cache',
                        subtitle: 'Cache images for faster loading',
                        value: advancedController.useImageCache.value,
                        onChanged: advancedController.setUseImageCache,
                      )),
                      // Use Video Thumbnail
                      Obx(() => _buildSwitchTile(
                        context: context,
                        title: 'Use Video Thumbnail',
                        subtitle: 'Generate thumbnails for videos',
                        value: advancedController.useVideoThumbnail.value,
                        onChanged: advancedController.setUseVideoThumbnail,
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Developer Section
                  _buildSettingsSection(
                    context: context,
                    title: "Developer",
                    children: [
                      // About LumiFrame
                      Obx(() => ListTile(
                        leading: Icon(Icons.info_outline, color: context.accentColor),
                        title: Text(
                          'About LumiFrame',
                          style: TextStyle(color: context.primaryTextColor),
                        ),
                        subtitle: Text(
                          'Version ${advancedController.formattedVersion}',
                          style: TextStyle(color: context.secondaryTextColor),
                        ),
                        onTap: () {
                          // Could show detailed version info or changelog
                        },
                      )),
                      // Send Diagnostic Logs
                      GlassmorphismActionButton(
                        labelText: 'Send Diagnostic Logs',
                        subtitle: 'Help us improve the app',
                        icon: Icons.bug_report_outlined,
                        onPressed: advancedController.sendDiagnosticLogs,
                        padding: EdgeInsets.zero,
                      ),
                      // Contact Support
                      GlassmorphismActionButton(
                        labelText: 'Contact Support',
                        subtitle: 'Get help with the app',
                        icon: Icons.support_agent_outlined,
                        onPressed: advancedController.contactSupport,
                        padding: EdgeInsets.zero,
                      ),
                      // Clear Cache (moved from old location)
                      GlassmorphismActionButton(
                        labelText: 'Clear Cache',
                        subtitle: 'Free up storage space',
                        icon: Icons.delete_outline,
                        requiresConfirmation: true,
                        confirmationTitle: 'Clear Cache',
                        confirmationMessage: 'This will clear all cached data and may slow down the app temporarily.',
                        confirmButtonText: 'Clear',
                        isDestructive: true,
                        onPressed: advancedController.clearCache,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({
    required BuildContext context,
    required String title,
    required List<Widget> children,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.primaryTextColor,
                ),
              ),
            ),
          ],
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(color: context.primaryTextColor),
      ),
      subtitle: subtitle != null 
        ? Text(
            subtitle,
            style: TextStyle(color: context.secondaryTextColor),
          )
        : null,
      value: value,
      onChanged: onChanged,
      activeColor: context.accentColor,
    );
  }
}
