
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' show ImageFilter;
import '../../controllers/slideshow_controller.dart';
import '../../theme/theme_extensions.dart';
import '../../theme/backgrounds/dark_blur_background.dart';
import '../../theme/backgrounds/light_blur_background.dart';
import '../../theme/buttons/glassmorphism_dropdown.dart';
import '../../theme/buttons/glassmorphism_duration_input.dart';
import '../../theme/buttons/glassmorphism_inline_slider.dart';
import '../../theme/glassmorphism_container.dart';
import '../../theme/core/glassmorphism_config.dart';
import '../../utils/constants.dart';

class FrameSettingsScreen extends StatelessWidget {
  final slideshowController = Get.find<SlideshowController>();

  FrameSettingsScreen({super.key});

  void _showSubscriptionDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Frame Configuration',
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
                  // Frame Configuration Section - Enhanced with intense glassmorphism + particles
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GlassmorphismContainer(
                      config: GlassmorphismConfig.intense,
                      enableParticleEffect: true,
                      enableGlow: true,
                      glowColor: context.accentColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: context.accentColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: context.accentColor.withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.settings_display,
                                    color: context.accentColor,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Frame Configuration',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: context.primaryTextColor,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Shuffle
                          Obx(() => _buildSwitchTile(
                            context: context,
                            title: 'Shuffle',
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
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Photo Configuration Section
                  _buildSettingsSection(
                    context: context,
                    title: "Photo Configuration",
                    children: [
                      // Enable Photos
                      Obx(() => _buildSwitchTile(
                        context: context,
                        title: 'Enable Photos',
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
                  const SizedBox(height: 16),
                  
                  // Video Configuration Section
                  _buildSettingsSection(
                    context: context,
                    title: "Video Configuration",
                    children: [
                      // Enable Videos
                      _buildSwitchTile(
                        context: context,
                        title: 'Enable Videos',
                        subtitle: 'Requires premium subscription',
                        value: false, // Always show as disabled
                        onChanged: (val) => _showSubscriptionDialog(context),
                      ),
                      // AutoPlay Videos
                      Obx(() => _buildSwitchTile(
                        context: context,
                        title: 'AutoPlay',
                        subtitle: 'Automatically play videos when displayed',
                        value: slideshowController.autoPlay.value,
                        onChanged: slideshowController.setAutoPlay,
                      )),
                      // Mute Audio
                      Obx(() => _buildSwitchTile(
                        context: context,
                        title: 'Mute Audio',
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
      child: GlassmorphismContainer.medium(
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GlassmorphismContainer.light(
        enableGlow: value,
        glowColor: context.accentColor,
        child: SwitchListTile(
          title: Text(
            title,
            style: TextStyle(
              color: context.primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null 
            ? Text(
                subtitle,
                style: TextStyle(
                  color: context.secondaryTextColor,
                  fontSize: 13,
                ),
              )
            : null,
          value: value,
          onChanged: onChanged,
          activeColor: context.accentColor,
          activeTrackColor: context.accentColor.withOpacity(0.3),
          inactiveTrackColor: context.secondaryTextColor.withOpacity(0.2),
        ),
      ),
    );
  }
}
