import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'glassmorphism_container.dart';
import '../controllers/nav_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/auth_controller.dart';
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
      {'icon': Icons.image, 'label': 'Media Library'},
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
          // Edge-to-edge glassmorphism
          GlassmorphismContainer(
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.zero,
            hasBorder: false,
            child: SafeArea(
              child: Column(
                children: [
                  // Centered content
                  // Top row: Profile/name and close button, edge-to-edge
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onClose();
                            Get.to(() => const MyProfile());
                          },
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage('https://www.caseyscaptures.com/wp-content/uploads/IMG_0225-3000@70.jpg'),
                              ),
                              const SizedBox(width: 12),
                              Obx(() {
                                final authCtrl = Get.find<AuthController>();
                                final user = authCtrl.currentUser.value;
                                
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user?.displayName ?? 'User Name',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      user?.email ?? 'user@example.com',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 28),
                          onPressed: onClose,
                        ),
                      ],
                    ),
                  ),
                  // Middle: Scrollable grid of navigation buttons
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: SingleChildScrollView(
                            child: Obx(() {
                              final selected = navCtrl.selectedIndex.value;
                              final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
                              return GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 3.5,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(items.length, (i) {
                                  final isActive = selected == i;
                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        navCtrl.onItemSelected(i);
                                        onClose();
                                      },
                                      child: Container(
                                        decoration: isActive
                                            ? BoxDecoration(
                                                color: highlightColor,
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                            : null,
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              items[i]['icon'] as IconData,
                                              color: isActive ? Colors.white : null,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              items[i]['label'] as String,
                                              style: TextStyle(
                                                color: isActive ? Colors.white : null,
                                                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Theme pills and logout at the bottom, edge-to-edge
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(pills.length, (i) {
                            final pill = pills[i];
                            final isActive = mode == pill['mode'];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => themeController.switchTheme(pill['mode'] as ThemeMode),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    decoration: BoxDecoration(
                                      color: isActive ? highlightColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(16),
                                      border: isActive
                                          ? Border.all(color: highlightText, width: 2)
                                          : Border.all(color: Colors.transparent, width: 2),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Tooltip(
                                      message: pill['tooltip'] as String,
                                      child: Icon(
                                        pill['icon'] as IconData,
                                        color: isActive ? Colors.white : Theme.of(context).iconTheme.color,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(0.08),
                            foregroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          ),
                          icon: const Icon(Icons.logout, color: Colors.red, size: 18),
                          label: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 15)),
                          onPressed: onClose,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
