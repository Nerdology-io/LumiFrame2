
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/slideshow_controller.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_dropdown.dart';
import '../../theme/buttons/glassmorphism_duration_input.dart';
import '../../theme/buttons/glassmorphism_inline_slider.dart';

class FrameSettingsScreen extends StatelessWidget {
  final slideshowController = Get.find<SlideshowController>();

  FrameSettingsScreen({super.key});

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
                      value: slideshowController.enableVideos.value,
                      onChanged: slideshowController.setEnableVideos,
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
