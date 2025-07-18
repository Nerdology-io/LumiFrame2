import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Ensure availability for ImageFilter

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
                iconSize: 36, // Make the button larger
                padding: const EdgeInsets.all(8), // Reduce padding for a bigger touch area
                icon: const DotGridIcon(size: 36),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                  _drawerOpen.value = true;
                },
              ),
              // No title
            ),
            drawer: Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 16, 16), // CHANGED: Set left padding to 0 to hide left glow bleed off-screen; keeps space for right/top/bottom glow
              child: _buildGlassmorphismDrawer(navCtrl, context),
            ),
            onDrawerChanged: (isOpen) {
              _drawerOpen.value = isOpen;
            },
            drawerScrimColor: Colors.transparent, // Ensures blur applies to actual content
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // ...existing code...
        ],
      ),
      child: GlassmorphismContainer(
        width: 280,
        borderRadius: BorderRadius.circular(20),
        hasBorder: false,
        child: SafeArea(
          top: true,
          bottom: true,
          left: false,
          right: false,
          child: Stack(
            children: [
              // Top section anchored
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // No top padding, avatar flush with SafeArea
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => const MyProfile());
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://www.caseyscaptures.com/wp-content/uploads/IMG_0225-3000@70.jpg'),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(40),
                                    splashColor: Colors.white24,
                                    highlightColor: Colors.white10,
                                    onTap: () {
                                      Navigator.pop(context);
                                      Get.to(() => const MyProfile());
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 6, right: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Remove or reduce vertical space below avatar if needed
                        const SizedBox(height: 6),
                        const Text(
                          'Casey Schneider', // Replace with dynamic user name
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.08)
                          : Colors.black.withOpacity(0.08),
                    ),
                  ],
                ),
              ),
              // Middle section scrollable
              Padding(
                padding: const EdgeInsets.only(top: 98, bottom: 120), // Adjusted top padding to match new top section height
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Obx(() {
                      final selected = navCtrl.selectedIndex.value;
                      final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
                      final items = [
                        {'icon': Icons.grid_view, 'label': 'Dashboard'},
                        {'icon': Icons.image, 'label': 'Media Sources'},
                        {'icon': Icons.cast_connected, 'label': 'Casting'},
                        {'icon': Icons.settings, 'label': 'Settings'},
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
                  ],
                ),
              ),
              // Bottom section anchored
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.08)
                          : Colors.black.withOpacity(0.08),
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
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
                      child: SafeArea(
                        top: false,
                        left: false,
                        right: false,
                        bottom: true,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8), // Extra bottom padding for safe area
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Glassmorphism rail for larger screens (collapsible)
  Widget _buildGlassmorphismRail(NavController navCtrl, bool isExtended, BuildContext context) {
    const neonColor = Colors.cyanAccent;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        // Strong right-side glow, minimal top/bottom, no left
        boxShadow: [
          BoxShadow(
            color: neonColor.withOpacity(0.7),
            blurRadius: 32,
            spreadRadius: -16,
            offset: const Offset(24, 0),
            blurStyle: BlurStyle.outer,
          ),
          BoxShadow(
            color: neonColor.withOpacity(0.2),
            blurRadius: 24,
            spreadRadius: -16,
            offset: const Offset(24, -16), // Increased x-offset to push glow further right
            blurStyle: BlurStyle.outer,
          ),
          BoxShadow(
            color: neonColor.withOpacity(0.2),
            blurRadius: 24,
            spreadRadius: -16,
            offset: const Offset(24, 16), // Increased x-offset to push glow further right
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: GlassmorphismContainer(
        width: isExtended ? 280 : 80,
        borderRadius: BorderRadius.zero, // No rounding for full-height rail
        hasBorder: false,
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const MyProfile());
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage('https://www.caseyscaptures.com/wp-content/uploads/IMG_0225-3000@70.jpg'),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(28),
                                splashColor: Colors.white24,
                                highlightColor: Colors.white10,
                                onTap: () {
                                  Get.to(() => const MyProfile());
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 4, right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                    child: const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
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
              final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
              final highlightText = Theme.of(context).colorScheme.primary;
              final items = [
                {'icon': Icons.grid_view, 'label': 'Dashboard'},
                {'icon': Icons.image, 'label': 'Media Sources'},
                {'icon': Icons.cast_connected, 'label': 'Casting'},
                {'icon': Icons.settings, 'label': 'Settings'},
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 0),
              child: SafeArea(
                top: false,
                left: false,
                right: false,
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8), // Extra bottom padding for safe area
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A 3x3 dot grid icon, matching the modern hamburger style in the screenshot.
class DotGridIcon extends StatelessWidget {
  final double size;
  const DotGridIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    final double dotSize = size * 0.145; // scale dot size with icon
    final double spacing = size * 0.25;
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (row) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (col) => Container(
              width: dotSize,
              height: dotSize,
              margin: EdgeInsets.all(spacing / 4),
              decoration: BoxDecoration(
                color: Theme.of(context).iconTheme.color,
                shape: BoxShape.circle,
              ),
            )),
          )),
        ),
      ),
    );
  }
}