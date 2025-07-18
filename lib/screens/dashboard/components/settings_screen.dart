import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../settings/advanced_settings_screen.dart';
import '../../settings/appearance_settings_screen.dart';
import '../../settings/media_sources_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [

          SafeArea(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Appearance'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Get.to(const AppearanceSettingsScreen()),
                ),
                ListTile(
                  title: const Text('Media Sources'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Get.to(const MediaSourcesScreen()),
                ),
                ListTile(
                  title: const Text('Advanced'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Get.to(const AdvancedSettingsScreen()),
                ),
                // Add more settings options like notifications, account
              ],
            ),
          ),
        ],
      ),
    );
  }
}