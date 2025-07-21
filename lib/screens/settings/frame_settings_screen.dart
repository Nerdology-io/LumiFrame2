

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/slideshow_controller.dart';

class FrameSettingsScreen extends StatelessWidget {
  final slideshowController = Get.find<SlideshowController>();

  FrameSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Shuffle
            Obx(() => SwitchListTile(
              title: const Text('Shuffle'),
              value: slideshowController.shuffle.value,
              onChanged: slideshowController.setShuffle,
            )),
            // Slide Duration
            Obx(() => ListTile(
              title: const Text('Slide Duration (seconds)'),
              subtitle: Slider(
                min: 1,
                max: 20,
                divisions: 19,
                value: slideshowController.slideDuration.value.toDouble(),
                label: slideshowController.slideDuration.value.toString(),
                onChanged: (v) => slideshowController.setSlideDuration(v.toInt()),
              ),
            )),
            // Transition Type
            Obx(() => DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Transition Type'),
              value: slideshowController.transitionType.value,
              items: [
                'slide_left', 'slide_right', 'slide_up', 'slide_down', 'flip', 'fade'
              ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (val) {
                if (val != null) slideshowController.setTransitionType(val);
              },
            )),
            // Transition Speed
            Obx(() => DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Transition Speed'),
              value: slideshowController.transitionSpeed.value,
              items: [
                'slow', 'medium', 'fast'
              ].map((speed) => DropdownMenuItem(value: speed, child: Text(speed))).toList(),
              onChanged: (val) {
                if (val != null) slideshowController.setTransitionSpeed(val);
              },
            )),
            // Enable Photos
            Obx(() => SwitchListTile(
              title: const Text('Enable Photos'),
              value: slideshowController.enablePhotos.value,
              onChanged: slideshowController.setEnablePhotos,
            )),
            // Enable Videos
            Obx(() => SwitchListTile(
              title: const Text('Enable Videos'),
              value: slideshowController.enableVideos.value,
              onChanged: slideshowController.setEnableVideos,
            )),
            // Photo Animation
            Obx(() => DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Photo Animation'),
              value: slideshowController.photoAnimation.value,
              items: [
                'none', 'zoom_in', 'zoom_out', 'pan_left', 'pan_right'
              ].map((anim) => DropdownMenuItem(value: anim, child: Text(anim))).toList(),
              onChanged: (val) {
                if (val != null) slideshowController.setPhotoAnimation(val);
              },
            )),
            // Content Mode
            Obx(() => DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Content Mode'),
              value: slideshowController.contentMode.value,
              items: [
                'fill', 'stretch', 'fit'
              ].map((mode) => DropdownMenuItem(value: mode, child: Text(mode))).toList(),
              onChanged: (val) {
                if (val != null) slideshowController.setContentMode(val);
              },
            )),
            // Background Effect
            Obx(() => DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Background Effect'),
              value: slideshowController.backgroundEffect.value,
              items: [
                'blur', 'black', 'white', 'custom'
              ].map((effect) => DropdownMenuItem(value: effect, child: Text(effect))).toList(),
              onChanged: (val) {
                if (val != null) slideshowController.setBackgroundEffect(val);
              },
            )),
            // Default Volume
            Obx(() => ListTile(
              title: const Text('Default Volume'),
              subtitle: Slider(
                min: 0,
                max: 1,
                divisions: 10,
                value: slideshowController.defaultVolume.value,
                label: slideshowController.defaultVolume.value.toStringAsFixed(1),
                onChanged: slideshowController.setDefaultVolume,
              ),
            )),
            // Auto Play
            Obx(() => SwitchListTile(
              title: const Text('Auto Play'),
              value: slideshowController.autoPlay.value,
              onChanged: slideshowController.setAutoPlay,
            )),
          ],
        ),
      ),
    );
  }
}
