
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' show ImageFilter;
import '../../controllers/slideshow_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_dropdown.dart';
import '../../theme/buttons/glassmorphism_duration_input.dart';
import '../../theme/buttons/glassmorphism_inline_slider.dart';
import '../../utils/constants.dart';

class FrameSettingsScreen extends StatelessWidget {
  final slideshowController = Get.find<SlideshowController>();

  FrameSettingsScreen({super.key});

  void _showSubscriptionDialog(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (isDark ? Colors.black : Colors.white).withOpacity(0.9),
                (isDark ? Colors.black : Colors.white).withOpacity(0.8),
              ],
            ),
            border: Border.all(
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor.withOpacity(0.3),
                            AppConstants.accentColor.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.video_library,
                        size: 40,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Subscription Required',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Video support requires a premium subscription. Upgrade to unlock this feature and enjoy your video memories!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: (isDark ? Colors.white : Colors.black87).withOpacity(0.8),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              border: Border.all(
                                color: (isDark ? Colors.white : Colors.black).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: (isDark ? Colors.white : Colors.black87).withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppConstants.primaryColor,
                                  AppConstants.accentColor,
                                ],
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  // Navigate to subscription screen
                                  // Get.toNamed('/subscription');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Upgrade',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Frame Configuration Section
              GlassmorphismSettingsWrapper(
                horizontalPadding: 16.0,
                blurSigma: 10.0,
                opacity: 0.1,
                child: Column(
                  children: [
                    // Shuffle
                    Obx(() => SwitchListTile(
                      title: const Text('Shuffle'),
                      value: slideshowController.shuffle.value,
                      onChanged: slideshowController.setShuffle,
                    )),
                    // Slide Duration
                    Obx(() => GlassmorphismDurationInput(
                      labelText: 'Slide Duration',
                      value: slideshowController.slideDuration.value,
                      onChanged: (value) => slideshowController.setSlideDuration(value),
                      minValue: 1,
                      padding: EdgeInsets.zero, // Remove default padding for alignment
                    )),
                    // Transition Speed
                    Obx(() => GlassmorphismDropdown<String>(
                      labelText: 'Transition Speed',
                      value: slideshowController.transitionSpeed.value,
                      items: const ['slow', 'medium', 'fast'],
                      onChanged: (val) {
                        if (val != null) slideshowController.setTransitionSpeed(val);
                      },
                      padding: EdgeInsets.zero, // Remove default padding for alignment
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Photo Configuration Section
              GlassmorphismSettingsWrapper(
                title: "Photo Configuration",
                horizontalPadding: 16.0,
                blurSigma: 10.0,
                opacity: 0.1,
                child: Column(
                  children: [
                    // Enable Photos
                    Obx(() => SwitchListTile(
                      title: const Text('Enable Photos'),
                      value: slideshowController.enablePhotos.value,
                      onChanged: slideshowController.setEnablePhotos,
                    )),
                    // Background Effect
                    Obx(() => GlassmorphismDropdown<String>(
                      labelText: 'Background Effect',
                      value: slideshowController.backgroundEffect.value,
                      items: const ['blur', 'black', 'white', 'custom'],
                      onChanged: (val) {
                        if (val != null) slideshowController.setBackgroundEffect(val);
                      },
                      padding: EdgeInsets.zero, // Remove default padding for alignment
                    )),
                    // Content Mode
                    Obx(() => GlassmorphismDropdown<String>(
                      labelText: 'Content Mode',
                      value: slideshowController.contentMode.value,
                      items: const ['fill', 'stretch', 'fit'],
                      onChanged: (val) {
                        if (val != null) slideshowController.setContentMode(val);
                      },
                      padding: EdgeInsets.zero, // Remove default padding for alignment
                    )),
                    // Photo Animation
                    Obx(() => GlassmorphismDropdown<String>(
                      labelText: 'Photo Animation',
                      value: slideshowController.photoAnimation.value,
                      items: const ['none', 'zoom_in', 'zoom_out', 'pan_left', 'pan_right'],
                      onChanged: (val) {
                        if (val != null) slideshowController.setPhotoAnimation(val);
                      },
                      padding: EdgeInsets.zero, // Remove default padding for alignment
                    )),
                    // Transition Type
                    Obx(() => GlassmorphismDropdown<String>(
                      labelText: 'Transition Type',
                      value: slideshowController.transitionType.value,
                      items: const ['slide_left', 'slide_right', 'slide_up', 'slide_down', 'flip', 'fade'],
                      onChanged: (val) {
                        if (val != null) slideshowController.setTransitionType(val);
                      },
                      padding: EdgeInsets.zero, // Remove default padding for alignment
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Video Configuration Section
              GlassmorphismSettingsWrapper(
                title: "Video Configuration",
                horizontalPadding: 16.0,
                blurSigma: 10.0,
                opacity: 0.1,
                child: Column(
                  children: [
                    // Enable Videos
                    Obx(() => SwitchListTile(
                      title: const Text('Enable Videos'),
                      subtitle: const Text('Requires premium subscription'),
                      value: false, // Always show as disabled
                      onChanged: (val) => _showSubscriptionDialog(context),
                    )),
                    // AutoPlay Videos
                    Obx(() => SwitchListTile(
                      title: const Text('AutoPlay'),
                      subtitle: const Text('Automatically play videos when displayed'),
                      value: slideshowController.autoPlay.value,
                      onChanged: slideshowController.setAutoPlay,
                    )),
                    // Mute Audio
                    Obx(() => SwitchListTile(
                      title: const Text('Mute Audio'),
                      value: slideshowController.muteAudio.value,
                      onChanged: slideshowController.setMuteAudio,
                    )),
                    // Default Volume
                    Obx(() => GlassmorphismInlineSlider(
                      labelText: 'Default Volume',
                      value: slideshowController.defaultVolume.value,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      onChanged: slideshowController.setDefaultVolume,
                      formatValue: (value) => '${(value * 100).round()}%',
                      padding: EdgeInsets.zero, // Remove default padding for alignment
                    )),
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
