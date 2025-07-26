import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../theme/theme_extensions.dart';
import '../../theme/backgrounds/dark_blur_background.dart';
import '../../theme/backgrounds/light_blur_background.dart';
import '../../theme/buttons/glassmorphism_radio_input.dart';
import '../../theme/glassmorphism_container.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Appearance Settings',
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
                  _buildSettingsSection(
                    context: context,
                    title: 'Theme Mode',
                    children: [
                      Obx(() => GlassmorphismRadioInput<ThemeMode>(
                        labelText: 'Theme Mode',
                        value: themeCtrl.themeMode.value,
                        options: const [ThemeMode.light, ThemeMode.dark, ThemeMode.system],
                        onChanged: (val) {
                          if (val != null) themeCtrl.switchTheme(val);
                        },
                        padding: EdgeInsets.zero, // Remove default padding for alignment
                        optionDisplayText: (mode) {
                          switch (mode) {
                            case ThemeMode.light:
                              return 'Light';
                            case ThemeMode.dark:
                              return 'Dark';
                            case ThemeMode.system:
                              return 'System';
                          }
                        },
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),
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
}