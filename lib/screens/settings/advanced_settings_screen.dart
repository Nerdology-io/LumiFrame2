import 'package:flutter/material.dart';

import 'package:get/Get.dart';
import '../../../theme/backgrounds/dynamic_time_blur_background.dart';

class AdvancedSettingsScreen extends StatelessWidget {
  const AdvancedSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Advanced Settings'), backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          // Edge-to-edge background
          const DynamicTimeBlurBackground(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                SwitchListTile(
                  title: const Text('Enable Debug Mode'),
                  value: false, // Placeholder; bind to controller if needed
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  title: const Text('Auto-Sync Media'),
                  value: true,
                  onChanged: (val) {},
                ),
                ListTile(
                  title: const Text('Clear Cache'),
                  trailing: const Icon(Icons.delete),
                  onTap: () {
                    // Call clear cache from storage controller
                    Get.snackbar('Cache Cleared', 'App cache has been cleared.');
                  },
                ),
                // Add more advanced options like API keys, logs
              ],
            ),
          ),
        ],
      ),
    );
  }
}