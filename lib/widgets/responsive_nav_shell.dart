import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

// Theme and background imports
import '../theme/glassmorphism_container.dart';
import '../theme/glassmorphism_fullscreen_menu.dart';
import '../theme/backgrounds/earlymorning_blur_background.dart';
import '../theme/backgrounds/earlymorning_dark_blur_background.dart';
import '../theme/backgrounds/morning_blur_background.dart';
import '../theme/backgrounds/morning_dark_blur_background.dart';
import '../theme/backgrounds/afternoon_blur_background.dart';
import '../theme/backgrounds/afternoon_dark_blur_background.dart';
import '../theme/backgrounds/evening_blur_background.dart';
import '../theme/backgrounds/evening_dark_blur_background.dart';
import '../theme/backgrounds/lateevening_blur_background.dart';
import '../theme/backgrounds/lateevening_dark_blur_background.dart';
import '../theme/backgrounds/night_blur_background.dart';
import '../theme/backgrounds/night_dark_blur_background.dart';
import '../theme/backgrounds/animations/mist_overlay.dart';
import '../theme/backgrounds/animations/godray_top_glow_overlay.dart';
import '../theme/backgrounds/animations/flare_dust_overlay.dart';
import '../theme/backgrounds/animations/evening_overlay.dart';
import '../theme/backgrounds/animations/late_evening_overlay.dart';
import '../theme/backgrounds/animations/starfield_overlay.dart';

// Screens
import '../screens/dashboard/components/dashboard_screen.dart';
import '../screens/media_picker_screen.dart';
import '../screens/slideshow_screen.dart';
import '../screens/dashboard/components/cast_screen.dart';
import '../screens/dashboard/components/settings_screen.dart';
import '../screens/profile/my_profile.dart';
import '../screens/profile/edit_profile.dart';

// Controllers
import '../controllers/nav_controller.dart';
import '../controllers/slideshow_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/dynamic_time_controller.dart';
import '../controllers/auth_controller.dart';
import '../theme/base_theme.dart';
import '../theme/base_theme.dart';

/// Responsive navigation shell widget with GetX integration.
/// Handles menu destinations with adaptive nav: slideout drawer on small screens, side rail on larger.
/// Reactively updates with theme changes
class ResponsiveNavShell extends StatefulWidget {
  const ResponsiveNavShell({super.key});

  @override
  State<ResponsiveNavShell> createState() => _ResponsiveNavShellState();
}

class _ResponsiveNavShellState extends State<ResponsiveNavShell> {
  // Dynamic background and overlay builder
  Widget buildDynamicBackgroundAndOverlay(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final period = Get.find<DynamicTimeController>().currentPeriod.value;
    switch (period) {
      case TimeOfDayPeriod.earlyMorning:
        return Stack(
          children: [
            isDark ? const EarlyMorningDarkBlurBackground() : const EarlyMorningBlurBackground(),
            const MistOverlay(),
          ],
        );
      case TimeOfDayPeriod.morning:
        return Stack(
          children: [
            isDark ? const MorningDarkBlurBackground() : const MorningBlurBackground(),
            const GodRayTopGlowOverlay(),
          ],
        );
      case TimeOfDayPeriod.afternoon:
        return Stack(
          children: [
            isDark ? const AfternoonDarkBlurBackground() : const AfternoonBlurBackground(),
            const FlareDustOverlay(),
          ],
        );
      case TimeOfDayPeriod.evening:
        return Stack(
          children: [
            isDark ? const EveningDarkBlurBackground() : const EveningBlurBackground(),
            const EveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.lateEvening:
        return Stack(
          children: [
            isDark ? const LateEveningDarkBlurBackground() : const LateEveningBlurBackground(),
            const LateEveningOverlay(),
          ],
        );
      case TimeOfDayPeriod.night:
        return Stack(
          children: [
            isDark ? const NightDarkBlurBackground() : const LightGradientBlurBackground(),
            const StarfieldOverlay(),
          ],
        );
    }
  }
  final ValueNotifier<bool> _drawerOpen = ValueNotifier(false);
  final ValueNotifier<bool> _fullscreenMenuOpen = ValueNotifier(false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Class-level scaffold key

  // List of your screens/widgets (synced exactly with menu items)
  static const List<Widget> _screens = [
    DashboardScreen(), // Main dashboard page
    MediaPickerScreen(), // Media Library - Browse and select photos
    CastScreen(),
    SettingsScreen(),
    SizedBox.shrink(), // Placeholder for MyProfile (not const)
    EditProfile(),
  ];

  // Get title for the current screen based on selectedIndex
  String? _getScreenTitle(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return null; // Dashboard - no title needed
      case 1:
        return 'Media Library';
      case 2:
        return 'Casting';
      case 3:
        return 'App Settings';
      case 4:
      case 5:
        return null; // Profile screens use NavShellBackgroundWrapper titles
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NavController navCtrl = Get.find<NavController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Update system UI overlay style based on theme
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double shortestSide = MediaQuery.of(context).size.shortestSide;
          final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
          final bool isMobile = !kIsWeb && (Platform.isIOS || Platform.isAndroid);
          final bool isIpad = !kIsWeb && Platform.isIOS && shortestSide >= 600;
          final bool useFullScreenMenu = (isMobile || isIpad) && isLandscape;
          final bool isSmallScreen = width < 600;

        Widget scaffold;
        if (useFullScreenMenu) {
          scaffold = Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
                statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              ),
              leading: IconButton(
                iconSize: 36,
                padding: const EdgeInsets.all(8),
                icon: const DotGridIcon(size: 36),
                onPressed: () {
                  _fullscreenMenuOpen.value = true;
                },
              ),
              title: Obx(() {
                final title = _getScreenTitle(navCtrl.selectedIndex.value);
                return title != null
                    ? Text(
                        title,
                        style: Theme.of(context).brightness == Brightness.dark
                          ? LumiFrameDarkTheme.headline
                          : LumiFrameDarkTheme.lightHeadline,
                      )
                    : const SizedBox.shrink();
              }),
            ),
            body: Stack(
              children: [
                buildDynamicBackgroundAndOverlay(context),
                Obx(() => _screens[navCtrl.selectedIndex.value]),
              ],
            ),
          );
        } else if (kIsWeb || Platform.isMacOS || Platform.isWindows) {
          scaffold = Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
                statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              ),
              leading: IconButton(
                iconSize: 36,
                padding: const EdgeInsets.all(8),
                icon: const DotGridIcon(size: 36),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                  _drawerOpen.value = true;
                },
              ),
              title: Obx(() {
                final title = _getScreenTitle(navCtrl.selectedIndex.value);
                return title != null
                    ? Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                            ? LumiFrameDarkTheme.white
                            : LumiFrameDarkTheme.lightPrimaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ),
            drawer: Padding(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 8, 16, MediaQuery.of(context).padding.bottom + 16),
              child: _buildGlassmorphismDrawer(navCtrl, context),
            ),
            onDrawerChanged: (isOpen) {
              _drawerOpen.value = isOpen;
            },
            drawerScrimColor: Colors.transparent,
            body: Stack(
              children: [
                buildDynamicBackgroundAndOverlay(context),
                Obx(() => _screens[navCtrl.selectedIndex.value]),
                // DISABLED: Dimming overlay temporarily disabled for debugging settings screen
                // ValueListenableBuilder<bool>(
                //   valueListenable: _drawerOpen,
                //   builder: (context, isDrawerOpen, child) {
                //     return AnimatedContainer(
                //       duration: const Duration(milliseconds: 250),
                //       color: isDrawerOpen 
                //           ? Colors.black.withOpacity(0.3)
                //           : Colors.transparent,
                //       child: isDrawerOpen
                //           ? GestureDetector(
                //               onTap: () {
                //                 _scaffoldKey.currentState?.closeDrawer();
                //               },
                //               child: Container(
                //                 width: double.infinity,
                //                 height: double.infinity,
                //               ),
                //             )
                //           : null,
                //     );
                //   },
                // ),
              ],
            ),
          );
        } else {
          scaffold = Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
                statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              ),
              leading: IconButton(
                iconSize: 36,
                padding: const EdgeInsets.all(8),
                icon: const DotGridIcon(size: 36),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                  _drawerOpen.value = true;
                },
              ),
              title: Obx(() {
                final title = _getScreenTitle(navCtrl.selectedIndex.value);
                return title != null
                    ? Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                            ? LumiFrameDarkTheme.white
                            : LumiFrameDarkTheme.lightPrimaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ),
            drawer: Padding(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 8, 16, MediaQuery.of(context).padding.bottom + 16),
              child: _buildGlassmorphismDrawer(navCtrl, context),
            ),
            onDrawerChanged: (isOpen) {
              _drawerOpen.value = isOpen;
            },
            drawerScrimColor: Colors.transparent,
            body: Stack(
              children: [
                buildDynamicBackgroundAndOverlay(context),
                Obx(() => _screens[navCtrl.selectedIndex.value]),
                // DISABLED: Second dimming overlay also temporarily disabled for debugging
                // ValueListenableBuilder<bool>(
                //   valueListenable: _drawerOpen,
                //   builder: (context, isDrawerOpen, child) {
                //     return AnimatedContainer(
                //       duration: const Duration(milliseconds: 250),
                //       color: isDrawerOpen 
                //           ? Colors.black.withOpacity(0.3)
                //           : Colors.transparent,
                //       child: isDrawerOpen
                //           ? GestureDetector(
                //               onTap: () {
                //                 _scaffoldKey.currentState?.closeDrawer();
                //               },
                //               child: Container(
                //                 width: double.infinity,
                //                 height: double.infinity,
                //               ),
                //             )
                //           : null,
                //     );
                //   },
                // ),
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
                  icon: Icon(
                    Icons.slideshow, 
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87, 
                    size: 32
                  ),
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
          valueListenable: isSmallScreen ? _drawerOpen : _fullscreenMenuOpen,
          builder: (context, menuOpen, child) {
            return Stack(
              children: [
                scaffold,
                if (!menuOpen) glassFab,
                if (!isSmallScreen && menuOpen)
                  GlassmorphismFullScreenMenu(
                    navCtrl: navCtrl,
                    onClose: () => _fullscreenMenuOpen.value = false,
                    parentContext: context,
                  ),
              ],
            );
          },
        );
        },
      ),
    ); // Close AnnotatedRegion
  }

  // Glassmorphism drawer for small screens (semi-transparent, blurred, floating)
  Widget _buildGlassmorphismDrawer(NavController navCtrl, BuildContext context) {
    return GlassmorphismContainer(
      width: 280,
      borderRadius: BorderRadius.circular(20),
      hasBorder: false,
      child: SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Profile section
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => MyProfile());
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
                              Get.to(() => MyProfile());
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 6, right: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha((255 * 0.5).round()),
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
                const SizedBox(height: 6),
                Obx(() {
                  final authCtrl = Get.find<AuthController>();
                  final user = authCtrl.currentUser.value;
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  
                  return Column(
                    children: [
                      Text(
                        user?.displayName ?? 'User Name',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                            ? LumiFrameDarkTheme.white
                            : LumiFrameDarkTheme.lightPrimaryText,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? 'user@example.com',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                            ? LumiFrameDarkTheme.white
                            : LumiFrameDarkTheme.lightPrimaryText,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 12),
                Divider(
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Theme.of(context).dividerTheme.color ?? LumiFrameDarkTheme.secondary.withOpacity(0.08),
                ),
                ],
              ),
            ),
            // Menu items
            Obx(() {
              final selected = navCtrl.selectedIndex.value;
              final highlightColor = LumiFrameDarkTheme.navSelectionColor;
              final items = [
                {'icon': Icons.grid_view, 'label': 'Dashboard'},
                {'icon': Icons.image, 'label': 'Media Library'},
                {'icon': Icons.cast_connected, 'label': 'Casting'},
                {'icon': Icons.settings, 'label': 'Settings'},
              ];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: List.generate(items.length, (i) {
                    final isActive = selected == i;
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
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
                                  color: isActive 
                                    ? Theme.of(context).iconTheme.color
                                    : Theme.of(context).iconTheme.color?.withOpacity(0.6),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  items[i]['label'] as String,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.dark
                                      ? LumiFrameDarkTheme.white
                                      : LumiFrameDarkTheme.lightPrimaryText,
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
            // Logout button
            Divider(
              thickness: 1,
              indent: 16,
              endIndent: 16,
              color: Theme.of(context).dividerTheme.color ?? LumiFrameDarkTheme.secondary.withOpacity(0.08),
            ),
            // Theme pills - moved here above logout
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Obx(() {
                final themeController = Get.find<ThemeController>();
                final mode = themeController.themeMode.value;
                final highlightColor = Theme.of(context).colorScheme.primary.withOpacity(0.16);
                final highlightText = Theme.of(context).colorScheme.primary;
                final pills = [
                  {'icon': Icons.auto_mode, 'mode': ThemeMode.system, 'tooltip': 'System'},
                  {'icon': Icons.nightlight, 'mode': ThemeMode.dark, 'tooltip': 'Dark'},
                  {'icon': Icons.wb_sunny, 'mode': ThemeMode.light, 'tooltip': 'Light'},
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
                          onTap: () {
                            // Switch theme and prevent drawer auto-close
                            themeController.switchTheme(pill['mode'] as ThemeMode);
                            // Force drawer to stay open after theme rebuild
                            Future.delayed(const Duration(milliseconds: 100), () {
                              if (_scaffoldKey.currentState?.isDrawerOpen == false) {
                                _scaffoldKey.currentState?.openDrawer();
                                _drawerOpen.value = true;
                              }
                            });
                          },
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
                                color: isActive ? LumiFrameDarkTheme.white : Theme.of(context).iconTheme.color,
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withAlpha((255 * 0.08).round()),
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
                    Navigator.pop(context);
                    final authCtrl = Get.find<AuthController>();
                    authCtrl.logout();
                  },
                ),
              ),
            ),
          ], // Fixed - closing bracket for the children array
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
                color: Theme.of(context).iconTheme.color ?? LumiFrameDarkTheme.white,
                shape: BoxShape.circle,
              ),
            )),
          )),
        ),
      ),
    );
  }
}
