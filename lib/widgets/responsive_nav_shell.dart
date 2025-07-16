import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your screens (adjust paths as needed)
import '../screens/dashboard/components/dashboard_screen.dart';
import '../screens/dashboard/components/media_browsing_screen.dart';
import '../screens/slideshow_screen.dart';
import '../screens/dashboard/components/cast_screen.dart';
import '../screens/dashboard/components/settings_screen.dart';

import '../controllers/nav_controller.dart';

/// Responsive navigation shell widget with GetX integration.
/// Handles 5 destinations with adaptive nav: bottom bar on small screens, side rail on larger.
/// Reactively updates with theme changes.
class ResponsiveNavShell extends StatelessWidget {
  const ResponsiveNavShell({super.key});

  // List of your screens/widgets (excluding full-screen ones like slideshow)
  static const List<Widget> _screens = [
    DashboardScreen(),
    MediaBrowsingScreen(),
    SizedBox(), // Placeholder for slideshow (handled via route)
    CastScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final NavController navCtrl = Get.put(NavController()); // Initialize controller (singleton)

    return Obx(() {
      return LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmallScreen = constraints.maxWidth < 600;
          final bool isExtended = constraints.maxWidth > 840;

          if (isSmallScreen) {
            // Mobile: Bottom nav with 5 items
            return Scaffold(
              body: _screens[navCtrl.selectedIndex.value],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navCtrl.selectedIndex.value,
                onTap: navCtrl.onItemSelected,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                  BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Media'),
                  BottomNavigationBarItem(icon: Icon(Icons.slideshow), label: 'Slideshow'),
                  BottomNavigationBarItem(icon: Icon(Icons.cast), label: 'Cast'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
                ],
              ),
            );
          } else {
            // Tablet/Desktop: Side rail (mini/compact or extended) with 5 items
            return Scaffold(
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: navCtrl.selectedIndex.value,
                    extended: isExtended,
                    onDestinationSelected: navCtrl.onItemSelected,
                    labelType: isExtended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                      NavigationRailDestination(icon: Icon(Icons.photo_library), label: Text('Media Sources')),
                      NavigationRailDestination(icon: Icon(Icons.slideshow), label: Text('Launch Slideshow')),
                      NavigationRailDestination(icon: Icon(Icons.cast), label: Text('Casting')),
                      NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
                    ],
                  ),
                  Expanded(child: _screens[navCtrl.selectedIndex.value]),
                ],
              ),
            );
          }
        },
      );
    });
  }
}
