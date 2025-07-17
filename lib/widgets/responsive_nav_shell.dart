import 'package:flutter/material.dart';
import 'package:get/get.dart';
// For ImageFilter in BackdropFilter
import '../theme/glassmorphism_container.dart';

import '../screens/dashboard/components/dashboard_screen.dart';
import '../screens/dashboard/components/media_browsing_screen.dart';
import '../screens/slideshow_screen.dart';
import '../screens/dashboard/components/cast_screen.dart';
import '../screens/dashboard/components/settings_screen.dart';
import '../screens/profile/my_profile.dart';
import '../screens/profile/edit_profile.dart';

import '../controllers/nav_controller.dart';
import '../controllers/slideshow_controller.dart';
import '../controllers/theme_controller.dart';

/// Responsive navigation shell widget with GetX integration.
/// Handles 5 destinations with adaptive nav: slideout drawer on small screens, side rail on larger.
/// Reactively updates with theme changes, prioritizing stunning immersion.
class ResponsiveNavShell extends StatefulWidget {
  const ResponsiveNavShell({super.key});

  @override
  State<ResponsiveNavShell> createState() => _ResponsiveNavShellState();
}

class _ResponsiveNavShellState extends State<ResponsiveNavShell> {
  final ValueNotifier<bool> _drawerOpen = ValueNotifier(false);

  // List of your screens/widgets (synced exactly with menu items)
  static const List<Widget> _screens = [
    DashboardScreen(),
    MediaBrowsingScreen(),
    CastScreen(),
    SettingsScreen(),
    MyProfile(),
    EditProfile(),
  ];

  // All widget methods start here

  @override
  Widget build(BuildContext context) {
    final NavController navCtrl = Get.find<NavController>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // For drawer control on small screens

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        final bool isExtended = constraints.maxWidth > 840;

        Widget scaffold;
        if (isSmallScreen) {
          // Mobile: Top-left menu button for glassmorphism slideout drawer
          scaffold = Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                icon: const DotGridIcon(),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                  _drawerOpen.value = true;
                },
              ),
              title: const Text('Discover'),
            ),
            drawer: _buildGlassmorphismDrawer(navCtrl, context),
            onDrawerChanged: (isOpen) {
              _drawerOpen.value = isOpen;
            },
            body: Obx(() => _screens[navCtrl.selectedIndex.value]),
          );
        } else {
          // Tablet/Desktop: Collapsible glassmorphism side rail
          scaffold = Scaffold(
            body: Row(
              children: [
                _buildGlassmorphismRail(navCtrl, isExtended, context),
                Obx(() => Expanded(child: _screens[navCtrl.selectedIndex.value])),
              ],
            ),
          );
        }
        Widget glassFab = Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: 64,
              height: 64,
              child: GlassmorphismContainer(
                width: 64,
                borderRadius: BorderRadius.circular(32),
                child: IconButton(
                  icon: const Icon(Icons.slideshow, color: Colors.white, size: 32),
                  tooltip: 'Start Slideshow',
                  onPressed: () {
                    if (!Get.isRegistered<SlideshowController>()) {
                      Get.put(SlideshowController());
                    }
                    Get.to(() => SlideshowScreen());
                  },
                ),
              ),
            ),
          ),
        );

        return ValueListenableBuilder<bool>(
          valueListenable: _drawerOpen,
          builder: (context, drawerOpen, child) {
            return Stack(
              children: [
                scaffold,
                if (!drawerOpen) glassFab,
              ],
            );
          },
        );
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
                ? Colors.white.withAlpha((0.08 * 255).round())
                : Colors.black.withAlpha((0.08 * 255).round()),
          ),
          // Navigation items with more spacing and larger highlight
          Obx(() {
            final selected = navCtrl.selectedIndex.value;
            final highlightColor = Theme.of(context).colorScheme.primary.withValues(alpha: 0.16);
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
                                color: isActive ? Colors.white : null,
                              ),
                              const SizedBox(width: 20),
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
                ? Colors.white.withAlpha((0.08 * 255).round())
                : Colors.black.withAlpha((0.08 * 255).round()),
          ),
          // Bottom: Theme switcher and logout (reactive)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Obx(() {
              final themeController = Get.find<ThemeController>();
              final mode = themeController.themeMode.value;
              final highlightColor = Theme.of(context).colorScheme.primary.withValues(alpha: 0.16);
              final highlightText = Theme.of(context).colorScheme.primary;
              final pills = [
                {
                  'icon': Icons.auto_mode,
                  'mode': ThemeMode.system,
                  'tooltip': 'System',
                },
                {
                  'icon': Icons.nightlight,
                  'mode': ThemeMode.dark,
                  'tooltip': 'Dark',
                },
                {
                  'icon': Icons.wb_sunny,
                  'mode': ThemeMode.light,
                  'tooltip': 'Light',
                },
              ];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pills.length, (i) {
                    final pill = pills[i];
                    final isActive = mode == pill['mode'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Tooltip(
                              message: pill['tooltip'] as String,
                              child: Icon(
                                pill['icon'] as IconData,
                                color: isActive ? Colors.white : Theme.of(context).iconTheme.color,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: 0.08),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Obx(() {
              final themeController = Get.find<ThemeController>();
              final mode = themeController.themeMode.value;
              final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
              final highlightText = Theme.of(context).colorScheme.primary;
              final pills = [
                {
                  'icon': Icons.auto_mode,
                  'mode': ThemeMode.system,
                  'tooltip': 'System',
                },
                {
                  'icon': Icons.nightlight,
                  'mode': ThemeMode.dark,
                  'tooltip': 'Dark',
                },
                {
                  'icon': Icons.wb_sunny,
                  'mode': ThemeMode.light,
                  'tooltip': 'Light',
                },
              ];
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pills.length, (i) {
                  final pill = pills[i];
                  final isActive = mode == pill['mode'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => themeController.switchTheme(pill['mode'] as ThemeMode),
                        child: Container(
                          decoration: isActive
                              ? BoxDecoration(
                                  color: highlightColor,
                                  borderRadius: BorderRadius.circular(20),
                                )
                              : null,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Tooltip(
                            message: pill['tooltip'] as String,
                            child: Icon(
                              pill['icon'] as IconData,
                              color: isActive ? highlightText : Theme.of(context).iconTheme.color,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
          Obx(() {
            final selected = navCtrl.selectedIndex.value;
            final highlightColor = Theme.of(context).colorScheme.primary.withValues(alpha: 0.16);
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
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.08),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Obx(() {
              Get.find<ThemeController>();
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ...existing code for navigation items...
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: 0.08),
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

/// A 3x3 dot grid icon, matching the modern hamburger style in the screenshot.
class DotGridIcon extends StatelessWidget {
  const DotGridIcon({super.key});

  @override
  Widget build(BuildContext context) {
    const double size = 24;
    const double dotSize = 3.5;
    const double spacing = 6.0;
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (row) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (col) =>
                Container(
                  width: dotSize,
                  height: dotSize,
                  margin: EdgeInsets.all(spacing / 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).iconTheme.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}