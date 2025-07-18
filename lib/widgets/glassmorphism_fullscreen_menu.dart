import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/glassmorphism_container.dart';
import '../controllers/nav_controller.dart';
import '../controllers/theme_controller.dart';
import '../screens/profile/my_profile.dart';

/// Full-screen glassmorphism menu overlay for landscape/tablet/desktop
class GlassmorphismFullScreenMenu extends StatelessWidget {
  final NavController navCtrl;
  final VoidCallback onClose;
  final BuildContext parentContext;

  const GlassmorphismFullScreenMenu({
    super.key,
    required this.navCtrl,
    required this.onClose,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final mode = themeController.themeMode.value;
    final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
    final highlightText = Theme.of(context).colorScheme.primary;
    final pills = [
      {'icon': Icons.auto_mode, 'mode': ThemeMode.system, 'tooltip': 'System'},
      {'icon': Icons.nightlight, 'mode': ThemeMode.dark, 'tooltip': 'Dark'},
      {'icon': Icons.wb_sunny, 'mode': ThemeMode.light, 'tooltip': 'Light'},
    ];
    final items = [
      {'icon': Icons.grid_view, 'label': 'Dashboard'},
      {'icon': Icons.image, 'label': 'Media Sources'},
      {'icon': Icons.cast_connected, 'label': 'Casting'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];
    return Material(
      color: Colors.black.withOpacity(0.3),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onClose,
            child: Container(color: Colors.transparent),
          ),
          Center(
            child: GlassmorphismContainer(
              width: 420,
              height: 600,
              borderRadius: BorderRadius.circular(32),
              hasBorder: false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile
                      GestureDetector(
                        onTap: () {
                          onClose();
                          Get.to(() => const MyProfile());
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 48,
                              backgroundImage: NetworkImage('https://www.caseyscaptures.com/wp-content/uploads/IMG_0225-3000@70.jpg'),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(48),
                                  splashColor: Colors.white24,
                                  highlightColor: Colors.white10,
                                  onTap: () {
                                    onClose();
                                    Get.to(() => const MyProfile());
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 8, right: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'User Name',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      // Theme pills
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pills.length, (i) {
                          final pill = pills[i];
                          final isActive = mode == pill['mode'];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => themeController.switchTheme(pill['mode'] as ThemeMode),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  decoration: BoxDecoration(
                                    color: isActive ? highlightColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: isActive
                                        ? Border.all(color: highlightText, width: 2)
                                        : Border.all(color: Colors.transparent, width: 2),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                  child: Tooltip(
                                    message: pill['tooltip'] as String,
                                    child: Icon(
                                      pill['icon'] as IconData,
                                      color: isActive ? Colors.white : Theme.of(context).iconTheme.color,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      Divider(
                        thickness: 1,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.black.withOpacity(0.08),
                      ),
                      const SizedBox(height: 18),
                      // Menu items
                      Obx(() {
                        final selected = navCtrl.selectedIndex.value;
                        return Column(
                          children: List.generate(items.length, (i) {
                            final isActive = selected == i;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    navCtrl.onItemSelected(i);
                                    onClose();
                                  },
                                  child: Container(
                                    decoration: isActive
                                        ? BoxDecoration(
                                            color: highlightColor,
                                            borderRadius: BorderRadius.circular(20),
                                          )
                                        : null,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                    child: Row(
                                      children: [
                                        Icon(
                                          items[i]['icon'] as IconData,
                                          color: isActive ? Colors.white : null,
                                        ),
                                        const SizedBox(width: 24),
                                        Text(
                                          items[i]['label'] as String,
                                          style: TextStyle(
                                            color: isActive ? Colors.white : null,
                                            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                      const Spacer(),
                      Divider(
                        thickness: 1,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.black.withOpacity(0.08),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.08),
                              foregroundColor: Colors.red,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            icon: const Icon(Icons.logout, color: Colors.red),
                            label: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                            onPressed: onClose,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
