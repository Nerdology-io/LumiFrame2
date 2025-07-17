import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui'; // For ImageFilter in BackdropFilter
import '../theme/glassmorphism_container.dart';

import '../screens/dashboard/components/dashboard_screen.dart';
import '../screens/dashboard/components/media_browsing_screen.dart';
// import '../screens/slideshow_screen.dart';
import '../screens/dashboard/components/cast_screen.dart';
import '../screens/dashboard/components/settings_screen.dart';
import '../screens/profile/my_profile.dart';
import '../screens/profile/edit_profile.dart';

import '../controllers/nav_controller.dart';

/// Responsive navigation shell widget with GetX integration.
/// Handles 5 destinations with adaptive nav: slideout drawer on small screens, side rail on larger.
/// Reactively updates with theme changes, prioritizing stunning immersion.
class ResponsiveNavShell extends StatelessWidget {
  const ResponsiveNavShell({super.key});

  // List of your screens/widgets (synced exactly with menu items)
  static const List<Widget> _screens = [
    DashboardScreen(),
    MediaBrowsingScreen(),
    CastScreen(),
    SettingsScreen(),
    MyProfile(),
    EditProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    final NavController navCtrl = Get.find<NavController>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // For drawer control on small screens

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        final bool isExtended = constraints.maxWidth > 840;

        if (isSmallScreen) {
          // Mobile: Top-left menu button for glassmorphism slideout drawer
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
              title: const Text('Discover'),
            ),
            drawer: _buildGlassmorphismDrawer(navCtrl, context),
            body: Obx(() => _screens[navCtrl.selectedIndex.value]),
          );
        } else {
          // Tablet/Desktop: Collapsible glassmorphism side rail
          return Scaffold(
            body: Row(
              children: [
                _buildGlassmorphismRail(navCtrl, isExtended, context),
                Obx(() => Expanded(child: _screens[navCtrl.selectedIndex.value])),
              ],
            ),
          );
        }
      },
    );
  }

  // Glassmorphism drawer for small screens (semi-transparent, blurred, floating)
  Widget _buildGlassmorphismDrawer(NavController navCtrl, BuildContext context) {
    return GlassmorphismContainer(
      width: 280,
      child: Column(
        children: [
          // Custom centered profile header (SafeArea + smaller avatar)
          SafeArea(
            top: true,
            bottom: false,
            left: false,
            right: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://example.com/profile.jpg'), // Replace with user image
                  ),
                  SizedBox(height: 12),
                  Text(
                    'User Name', // Replace with dynamic user name
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.08),
          ),
          // Navigation items with more spacing and larger highlight
          Obx(() {
            final selected = navCtrl.selectedIndex.value;
            final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
            final highlightText = Theme.of(context).colorScheme.primary;
            final items = [
              {'icon': Icons.grid_view, 'label': 'Dashboard'},
              {'icon': Icons.image, 'label': 'Media Sources'},
              {'icon': Icons.cast_connected, 'label': 'Casting'},
              {'icon': Icons.settings, 'label': 'Settings'},
              {'icon': Icons.person, 'label': 'Profile'},
              {'icon': Icons.edit, 'label': 'Edit Profile'},
            ];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: List.generate(items.length, (i) {
                  final isActive = selected == i;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          navCtrl.onItemSelected(i);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: isActive
                              ? BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(20),
                          )
                              : null,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          child: Row(
                            children: [
                              Icon(
                                items[i]['icon'] as IconData,
                                color: isActive ? highlightText : null,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                items[i]['label'] as String,
                                style: TextStyle(
                                  color: isActive ? highlightText : null,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
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
              ),
            );
          }),
          const Spacer(),
          Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.08),
          ),
          // Bottom: Theme switcher and logout (reactive)
          Obx(() => SwitchListTile(
            title: const Text('Dark Mode'),
            value: navCtrl.isDarkMode.value,
            onChanged: (value) {
              navCtrl.isDarkMode.value = value;
              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                onPressed: () {
                  // Add your logout logic (e.g., clear auth, navigate to login)
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Glassmorphism rail for larger screens (collapsible)
  Widget _buildGlassmorphismRail(NavController navCtrl, bool isExtended, BuildContext context) {
    return GlassmorphismContainer(
      width: isExtended ? 280 : 80,
      child: Column(
        children: [
          // SafeArea for the profile header only, with a smaller avatar
          SafeArea(
            top: true,
            bottom: false,
            left: false,
            right: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage('https://example.com/profile.jpg'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'User Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.08),
          ),
          // Navigation items with more spacing and larger highlight
          Obx(() {
            final selected = navCtrl.selectedIndex.value;
            final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
            final highlightText = Theme.of(context).colorScheme.primary;
            final items = [
              {'icon': Icons.grid_view, 'label': 'Dashboard'},
              {'icon': Icons.image, 'label': 'Media Sources'},
              {'icon': Icons.cast_connected, 'label': 'Casting'},
              {'icon': Icons.settings, 'label': 'Settings'},
              {'icon': Icons.person, 'label': 'Profile'},
              {'icon': Icons.edit, 'label': 'Edit Profile'},
            ];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: List.generate(items.length, (i) {
                  final isActive = selected == i;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => navCtrl.onItemSelected(i),
                        child: Container(
                          decoration: isActive
                              ? BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(20),
                          )
                              : null,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          child: Row(
                            mainAxisAlignment: isExtended
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              Icon(
                                items[i]['icon'] as IconData,
                                color: isActive ? highlightText : null,
                              ),
                              if (isExtended) ...[
                                const SizedBox(width: 20),
                                Text(
                                  items[i]['label'] as String,
                                  style: TextStyle(
                                    color: isActive ? highlightText : null,
                                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
          const Spacer(),
          Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.08),
          ),
          Obx(() => SwitchListTile(
            title: const Text('Dark Mode'),
            value: navCtrl.isDarkMode.value,
            onChanged: (value) {
              navCtrl.isDarkMode.value = value;
              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                onPressed: () {
                  // Add your logout logic
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}