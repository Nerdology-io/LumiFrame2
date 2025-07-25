
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
    
    // Aurora borealis-inspired color palette
    final auroraColors = [
      const Color(0xFF0B1426), // Deep space blue
      const Color(0xFF1B2951), // Midnight blue
      const Color(0xFF2D5D87), // Arctic blue
      const Color(0xFF4ECDC4), // Ethereal teal
      const Color(0xFF45B7D1), // Ice blue
      const Color(0xFF96CEB4), // Aurora green
      const Color(0xFFB8E6B8), // Soft mint
      const Color(0xFFE8F8F5), // Polar white
    ];
    
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: auroraColors[0].withOpacity(0.4),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.5,
              colors: [
                auroraColors[7].withOpacity(isDark ? 0.15 : 0.95),
                auroraColors[6].withOpacity(isDark ? 0.12 : 0.85),
                auroraColors[4].withOpacity(isDark ? 0.08 : 0.75),
                auroraColors[2].withOpacity(isDark ? 0.05 : 0.65),
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
            border: Border.all(
              color: auroraColors[3].withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: auroraColors[3].withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 0,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: auroraColors[4].withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(isDark ? 0.08 : 0.15),
                      Colors.white.withOpacity(isDark ? 0.04 : 0.08),
                      auroraColors[3].withOpacity(0.02),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Enhanced premium icon with aurora glow
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            auroraColors[3].withOpacity(0.4),
                            auroraColors[4].withOpacity(0.3),
                            auroraColors[5].withOpacity(0.2),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 0.8, 1.0],
                        ),
                        border: Border.all(
                          color: auroraColors[3].withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: auroraColors[3].withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: auroraColors[4].withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Icon(
                            Icons.video_library_outlined,
                            size: 45,
                            color: auroraColors[3],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Enhanced title with aurora glow
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            auroraColors[3].withOpacity(0.1),
                            auroraColors[4].withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Text(
                        'Subscription Required',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: isDark ? auroraColors[6] : auroraColors[1],
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: auroraColors[3].withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Text(
                      'Video support requires a premium subscription. Unlock this feature and illuminate your video memories like the northern lights!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: isDark ? auroraColors[6].withOpacity(0.9) : auroraColors[1].withOpacity(0.8),
                        height: 1.5,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    
                    Row(
                      children: [
                        // Enhanced cancel button
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(isDark ? 0.15 : 0.8),
                                  Colors.white.withOpacity(isDark ? 0.08 : 0.6),
                                  auroraColors[7].withOpacity(isDark ? 0.05 : 0.4),
                                ],
                              ),
                              border: Border.all(
                                color: auroraColors[4].withOpacity(0.3),
                                width: 1.2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? auroraColors[5] : auroraColors[1],
                                          letterSpacing: 0.3,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Enhanced upgrade button
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  auroraColors[3],
                                  auroraColors[4],
                                  auroraColors[5],
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: auroraColors[3].withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: auroraColors[4].withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
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
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    'Upgrade',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      shadows: [
                                        Shadow(
                                          color: auroraColors[1].withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
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
