import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'glassmorphism_container.dart';
import 'core/glassmorphism_config.dart';
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
          // Edge-to-edge glassmorphism with enhanced effects
          GlassmorphismContainer.intense(
            width: double.infinity,
            height: double.infinity,
            enableGlow: true,
            glowColor: Theme.of(context).colorScheme.primary,
            child: SafeArea(
              child: Column(
                children: [
                  // Centered content
                  // Top row: Profile/name and close button, edge-to-edge
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                    child: GlassmorphismContainer(
                      config: GlassmorphismConfig.medium.withBorderRadius(
                        BorderRadius.circular(20),
                      ),
                      enableGlow: true,
                      glowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                onClose();
                                Get.to(() => MyProfile());
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      radius: 26,
                                      backgroundImage: NetworkImage('https://www.caseyscaptures.com/wp-content/uploads/IMG_0225-3000@70.jpg'),
                                    ),
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
                            GlassmorphismContainer(
                              config: GlassmorphismConfig.light.withBorderRadius(
                                BorderRadius.circular(14),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                                onPressed: onClose,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              return GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 3.5,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(items.length, (i) {
                                  final isActive = selected == i;
                                  return GlassmorphismContainer.light(
                                    enableGlow: isActive,
                                    glowColor: Theme.of(context).colorScheme.primary,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () {
                                          navCtrl.onItemSelected(i);
                                          onClose();
                                        },
                                        child: Container(
                                          decoration: isActive
                                              ? BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                                    width: 1.5,
                                                  ),
                                                )
                                              : null,
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                items[i]['icon'] as IconData,
                                                color: isActive 
                                                    ? Colors.white 
                                                    : Theme.of(context).iconTheme.color?.withOpacity(0.9),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                items[i]['label'] as String,
                                                style: TextStyle(
                                                  color: isActive 
                                                      ? Colors.white 
                                                      : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.9),
                                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                                  fontSize: 16,
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
                        GlassmorphismContainer.light(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: List.generate(pills.length, (i) {
                                final pill = pills[i];
                                final isActive = mode == pill['mode'];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: GlassmorphismContainer(
                                    config: isActive 
                                        ? GlassmorphismConfig.medium.withGlow(
                                            Theme.of(context).colorScheme.primary, 
                                            8.0
                                          )
                                        : GlassmorphismConfig.subtle,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () => themeController.switchTheme(pill['mode'] as ThemeMode),
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 180),
                                          decoration: isActive
                                              ? BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                                    width: 1.5,
                                                  ),
                                                )
                                              : null,
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                          child: Tooltip(
                                            message: pill['tooltip'] as String,
                                            child: Icon(
                                              pill['icon'] as IconData,
                                              color: isActive 
                                                  ? Colors.white 
                                                  : Theme.of(context).iconTheme.color?.withOpacity(0.8),
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        GlassmorphismContainer.light(
                          enableGlow: true,
                          glowColor: Colors.red.withOpacity(0.4),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: onClose,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.red.withOpacity(0.2),
                                      Colors.red.withOpacity(0.1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.red.withOpacity(0.5),
                                    width: 1.5,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.logout, color: Colors.red, size: 18),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Logout', 
                                      style: TextStyle(
                                        color: Colors.red, 
                                        fontWeight: FontWeight.w600, 
                                        fontSize: 15
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
