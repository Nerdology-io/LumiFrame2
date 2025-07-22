import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/advanced_settings_controller.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_action_button.dart';
import '../../theme/buttons/glassmorphism_dropdown.dart';

class AdvancedSettingsScreen extends StatelessWidget {
  const AdvancedSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final advancedController = Get.put(AdvancedSettingsController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Performance Section
              GlassmorphismSettingsWrapper(
                title: "Performance",
                horizontalPadding: 16.0,
                blurSigma: 10.0,
                opacity: 0.1,
                child: Column(
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
                    Obx(() => SwitchListTile(
                      title: const Text('Preload Next Slide'),
                      subtitle: const Text('Improves slideshow performance'),
                      value: advancedController.preloadNextSlide.value,
                      onChanged: advancedController.setPreloadNextSlide,
                    )),
                    // Hardware Acceleration
                    Obx(() => SwitchListTile(
                      title: const Text('Hardware Acceleration'),
                      subtitle: const Text('Use GPU for better performance'),
                      value: advancedController.hardwareAcceleration.value,
                      onChanged: advancedController.setHardwareAcceleration,
                    )),
                    // Use Image Cache
                    Obx(() => SwitchListTile(
                      title: const Text('Use Image Cache'),
                      subtitle: const Text('Cache images for faster loading'),
                      value: advancedController.useImageCache.value,
                      onChanged: advancedController.setUseImageCache,
                    )),
                    // Use Video Thumbnail
                    Obx(() => SwitchListTile(
                      title: const Text('Use Video Thumbnail'),
                      subtitle: const Text('Generate thumbnails for videos'),
                      value: advancedController.useVideoThumbnail.value,
                      onChanged: advancedController.setUseVideoThumbnail,
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Developer Section
              GlassmorphismSettingsWrapper(
                title: "Developer",
                horizontalPadding: 16.0,
                blurSigma: 10.0,
                opacity: 0.1,
                child: Column(
                  children: [
                    // About LumiFrame
                    Obx(() => ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About LumiFrame'),
                      subtitle: Text('Version ${advancedController.formattedVersion}'),
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
              ),
              const SizedBox(height: 16), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
