import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_action_button.dart';


class AdvancedSettingsScreen extends StatelessWidget {
  const AdvancedSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            GlassmorphismSettingsWrapper(
              title: "Advanced Settings",
              horizontalPadding: 16.0,
              blurSigma: 10.0,
              opacity: 0.1,
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Enable Debug Mode'),
                    value: false, // Placeholder; bind to controller if needed
                    onChanged: (val) {},
                  ),
                  GlassmorphismActionButton(
                    labelText: 'Clear Cache',
                    subtitle: 'Free up storage space',
                    icon: Icons.delete_outline,
                    requiresConfirmation: true,
                    confirmationTitle: 'Clear Cache',
                    confirmationMessage: 'This will clear all cached data and may slow down the app temporarily.',
                    confirmButtonText: 'Clear',
                    isDestructive: true,
                    padding: EdgeInsets.zero, // Remove default padding for alignment
                    onPressed: () {
                      // Call clear cache from storage controller
                      Get.snackbar(
                        'Cache Cleared', 
                        'App cache has been cleared.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}