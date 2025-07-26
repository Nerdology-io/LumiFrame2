import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/media_sources_controller.dart';
import '../../theme/theme_extensions.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/backgrounds/dark_blur_background.dart';
import '../../theme/backgrounds/light_blur_background.dart';
import '../../theme/buttons/glassmorphism_auth_input.dart';

class MediaSourcesScreen extends StatelessWidget {
  const MediaSourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaSourcesController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Media Sources',
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
          // Universal background - same as all other screens
          isDark ? const DarkBlurBackground() : const LightBlurBackground(),
          
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
                          leading: Icon(Icons.photo_library, color: context.secondaryTextColor),
                          title: Text(
                            'Total Photos',
                            style: TextStyle(color: context.primaryTextColor),
                          ),
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
                          leading: Icon(Icons.sync, color: context.secondaryTextColor),
                          title: Text(
                            'Last Sync',
                            style: TextStyle(color: context.primaryTextColor),
                          ),
                          trailing: Text(
                            controller.lastSyncTimeFormatted,
                            style: TextStyle(
                              fontSize: 14,
                              color: context.secondaryTextColor,
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
                              color: context.secondaryTextColor,
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
                          title: Text(
                            'Enable Local Photos',
                            style: TextStyle(color: context.primaryTextColor),
                          ),
                          subtitle: Text(
                            'Access photos and videos from your device',
                            style: TextStyle(color: context.secondaryTextColor),
                          ),
                          value: controller.localStorageEnabled.value,
                          onChanged: controller.setLocalStorageEnabled,
                          secondary: Icon(Icons.phone_android, color: context.secondaryTextColor),
                        ),
                        if (controller.localStorageEnabled.value)
                          ListTile(
                            leading: Icon(Icons.info_outline, size: 20, color: context.secondaryTextColor),
                            title: Text(
                              '${controller.localPhotoCount.value} photos found',
                              style: TextStyle(fontSize: 14, color: context.primaryTextColor),
                            ),
                            subtitle: Text(
                              'Includes iCloud photos when available',
                              style: TextStyle(color: context.secondaryTextColor),
                            ),
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
                          title: Text(
                            'Enable Google Photos',
                            style: TextStyle(color: context.primaryTextColor),
                          ),
                          subtitle: Text(
                            controller.googlePhotosAuthenticated.value
                                ? 'Connected and syncing'
                                : 'Tap to connect your Google account',
                            style: TextStyle(color: context.secondaryTextColor),
                          ),
                          value: controller.googlePhotosEnabled.value,
                          onChanged: controller.setGooglePhotosEnabled,
                          secondary: Icon(
                            Icons.cloud_outlined,
                            color: controller.googlePhotosAuthenticated.value
                                ? Colors.green
                                : context.secondaryTextColor,
                          ),
                        ),
                        
                        if (controller.googlePhotosAuthenticated.value) ...[
                          ListTile(
                            leading: Icon(Icons.info_outline, size: 20, color: context.secondaryTextColor),
                            title: Text(
                              '${controller.googlePhotosCount.value} photos synced',
                              style: TextStyle(fontSize: 14, color: context.primaryTextColor),
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
                          title: Text(
                            'Enable Flickr',
                            style: TextStyle(color: context.primaryTextColor),
                          ),
                          subtitle: Text(
                            controller.flickrAuthenticated.value
                                ? 'Connected and syncing'
                                : 'Tap to connect your Flickr account',
                            style: TextStyle(color: context.secondaryTextColor),
                          ),
                          value: controller.flickrEnabled.value,
                          onChanged: controller.setFlickrEnabled,
                          secondary: Icon(
                            Icons.camera_alt_outlined,
                            color: controller.flickrAuthenticated.value
                                ? Colors.green
                                : context.secondaryTextColor,
                          ),
                        ),
                        
                        if (controller.flickrAuthenticated.value) ...[
                          ListTile(
                            leading: Icon(Icons.info_outline, size: 20, color: context.secondaryTextColor),
                            title: Text(
                              '${controller.flickrPhotoCount.value} photos synced',
                              style: TextStyle(fontSize: 14, color: context.primaryTextColor),
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
                          title: Text(
                            'Auto-Sync',
                            style: TextStyle(color: context.primaryTextColor),
                          ),
                          subtitle: Text(
                            'Automatically sync media from enabled sources',
                            style: TextStyle(color: context.secondaryTextColor),
                          ),
                          value: controller.autoSyncEnabled.value,
                          onChanged: controller.setAutoSyncEnabled,
                          secondary: Icon(Icons.sync, color: context.secondaryTextColor),
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
        title: Text(
          'Disconnect $serviceName',
          style: TextStyle(color: context.primaryTextColor),
        ),
        content: Text(
          'Are you sure you want to disconnect $serviceName? Your photos from this service will no longer be available in the slideshow.',
          style: TextStyle(color: context.secondaryTextColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.secondaryTextColor),
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