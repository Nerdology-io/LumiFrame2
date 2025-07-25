import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/media_sources_controller.dart';
import '../../controllers/dynamic_time_controller.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_auth_input.dart';
import '../../theme/backgrounds/earlymorning_blur_background.dart';
import '../../theme/backgrounds/earlymorning_dark_blur_background.dart';
import '../../theme/backgrounds/morning_blur_background.dart';
import '../../theme/backgrounds/morning_dark_blur_background.dart';
import '../../theme/backgrounds/afternoon_blur_background.dart';
import '../../theme/backgrounds/afternoon_dark_blur_background.dart';
import '../../theme/backgrounds/evening_blur_background.dart';
import '../../theme/backgrounds/evening_dark_blur_background.dart';
import '../../theme/backgrounds/lateevening_blur_background.dart';
import '../../theme/backgrounds/lateevening_dark_blur_background.dart';
import '../../theme/backgrounds/night_blur_background.dart';
import '../../theme/backgrounds/night_dark_blur_background.dart';
import '../../theme/backgrounds/animations/mist_overlay.dart';
import '../../theme/backgrounds/animations/godray_top_glow_overlay.dart';
import '../../theme/backgrounds/animations/flare_dust_overlay.dart';
import '../../theme/backgrounds/animations/evening_overlay.dart';
import '../../theme/backgrounds/animations/late_evening_overlay.dart';
import '../../theme/backgrounds/animations/starfield_overlay.dart';

class MediaSourcesScreen extends StatelessWidget {
  const MediaSourcesScreen({super.key});

  Widget _buildDynamicBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final period = Get.find<DynamicTimeController>().currentPeriod.value;
    
    switch (period) {
      case TimeOfDayPeriod.earlyMorning:
        return Stack(
          children: [
            isDark ? const EarlyMorningDarkBlurBackground() : const EarlyMorningBlurBackground(),
            const MistOverlay(),
            const GodRayTopGlowOverlay(),
          ],
        );
      case TimeOfDayPeriod.morning:
        return Stack(
          children: [
            isDark ? const MorningDarkBlurBackground() : const MorningBlurBackground(),
            const FlareDustOverlay(),
          ],
        );
      case TimeOfDayPeriod.afternoon:
        return Stack(
          children: [
            isDark ? const AfternoonDarkBlurBackground() : const AfternoonBlurBackground(),
            const FlareDustOverlay(),
          ],
        );
      case TimeOfDayPeriod.evening:
        return Stack(
          children: [
            isDark ? const EveningDarkBlurBackground() : const EveningBlurBackground(),
            const EveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.lateEvening:
        return Stack(
          children: [
            isDark ? const LateEveningDarkBlurBackground() : const LateEveningBlurBackground(),
            const LateEveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.night:
        return Stack(
          children: [
            isDark ? const NightDarkBlurBackground() : const LightGradientBlurBackground(),
            const StarfieldOverlay(),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaSourcesController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Dynamic background - same as other screens
          _buildDynamicBackground(context),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  // Sync Status Section
                  Obx(() => GlassmorphismSettingsWrapper(
                    title: 'Sync Status',
                    horizontalPadding: 16.0,
                    blurSigma: 10.0,
                    opacity: 0.1,
                    child: Column(
                      children: [
                        // Total Photos Count
                        ListTile(
                          leading: Icon(Icons.photo_library, color: isDark ? Colors.white70 : Colors.black54),
                          title: const Text('Total Photos'),
                          trailing: Text(
                            '${controller.totalPhotoCount}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        
                        // Last Sync Time
                        ListTile(
                          leading: Icon(Icons.sync, color: isDark ? Colors.white70 : Colors.black54),
                          title: const Text('Last Sync'),
                          trailing: Text(
                            controller.lastSyncTimeFormatted,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),
                        
                        // Sync Progress (when syncing)
                        if (controller.isSyncing.value) ...[
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: controller.syncProgress.value,
                            backgroundColor: Colors.grey.withValues(alpha: 0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.syncStatus.value,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white60 : Colors.black45,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 16),
                  
                  // Local Storage Section
                  Obx(() => GlassmorphismSettingsWrapper(
                    title: 'Local Storage',
                    horizontalPadding: 16.0,
                    blurSigma: 10.0,
                    opacity: 0.1,
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Enable Local Photos'),
                          subtitle: const Text('Access photos and videos from your device'),
                          value: controller.localStorageEnabled.value,
                          onChanged: controller.setLocalStorageEnabled,
                          secondary: const Icon(Icons.phone_android),
                        ),
                        if (controller.localStorageEnabled.value)
                          ListTile(
                            leading: const Icon(Icons.info_outline, size: 20),
                            title: Text(
                              '${controller.localPhotoCount.value} photos found',
                              style: const TextStyle(fontSize: 14),
                            ),
                            subtitle: const Text('Includes iCloud photos when available'),
                          ),
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 16),
                  
                  // Google Photos Section
                  Obx(() => GlassmorphismSettingsWrapper(
                    title: 'Google Photos',
                    horizontalPadding: 16.0,
                    blurSigma: 10.0,
                    opacity: 0.1,
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Enable Google Photos'),
                          subtitle: Text(
                            controller.googlePhotosAuthenticated.value
                                ? 'Connected and syncing'
                                : 'Tap to connect your Google account',
                          ),
                          value: controller.googlePhotosEnabled.value,
                          onChanged: controller.setGooglePhotosEnabled,
                          secondary: Icon(
                            Icons.cloud_outlined,
                            color: controller.googlePhotosAuthenticated.value
                                ? Colors.green
                                : null,
                          ),
                        ),
                        
                        if (controller.googlePhotosAuthenticated.value) ...[
                          ListTile(
                            leading: const Icon(Icons.info_outline, size: 20),
                            title: Text(
                              '${controller.googlePhotosCount.value} photos synced',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout, color: Colors.red, size: 20),
                            title: const Text(
                              'Disconnect Google Photos',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () => _showDisconnectDialog(
                              context,
                              'Google Photos',
                              controller.disconnectGooglePhotos,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 16),
                  
                  // Flickr Section
                  Obx(() => GlassmorphismSettingsWrapper(
                    title: 'Flickr',
                    horizontalPadding: 16.0,
                    blurSigma: 10.0,
                    opacity: 0.1,
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Enable Flickr'),
                          subtitle: Text(
                            controller.flickrAuthenticated.value
                                ? 'Connected and syncing'
                                : 'Tap to connect your Flickr account',
                          ),
                          value: controller.flickrEnabled.value,
                          onChanged: controller.setFlickrEnabled,
                          secondary: Icon(
                            Icons.camera_alt_outlined,
                            color: controller.flickrAuthenticated.value
                                ? Colors.green
                                : null,
                          ),
                        ),
                        
                        if (controller.flickrAuthenticated.value) ...[
                          ListTile(
                            leading: const Icon(Icons.info_outline, size: 20),
                            title: Text(
                              '${controller.flickrPhotoCount.value} photos synced',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout, color: Colors.red, size: 20),
                            title: const Text(
                              'Disconnect Flickr',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () => _showDisconnectDialog(
                              context,
                              'Flickr',
                              controller.disconnectFlickr,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 16),
                  
                  // Sync Settings Section
                  Obx(() => GlassmorphismSettingsWrapper(
                    title: 'Sync Settings',
                    horizontalPadding: 16.0,
                    blurSigma: 10.0,
                    opacity: 0.1,
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Auto-Sync'),
                          subtitle: const Text('Automatically sync media from enabled sources'),
                          value: controller.autoSyncEnabled.value,
                          onChanged: controller.setAutoSyncEnabled,
                          secondary: const Icon(Icons.sync),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Sync Now Button
                        SizedBox(
                          width: double.infinity,
                          child: GlassmorphismAuthButton(
                            text: controller.isSyncing.value ? 'Syncing...' : 'Sync Now',
                            isLoading: controller.isSyncing.value,
                            onPressed: controller.isSyncing.value ? null : controller.syncAllSources,
                          ),
                        ),
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDisconnectDialog(BuildContext context, String serviceName, VoidCallback onDisconnect) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        title: Text('Disconnect $serviceName'),
        content: Text(
          'Are you sure you want to disconnect $serviceName? Your photos from this service will no longer be available in the slideshow.',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onDisconnect();
            },
            child: const Text('Disconnect', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}