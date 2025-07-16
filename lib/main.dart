import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'bindings/initial_bindings.dart';
import 'routes/app_routes.dart';
import 'theme/app_themes.dart';
import 'controllers/theme_controller.dart';
import 'screens/onboarding/onboarding_start.dart';
import 'package:get_storage/get_storage.dart';
import 'widgets/responsive_nav_shell.dart';
import 'screens/slideshow_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      // Handle init error (e.g., log or show dialog in app)
      debugPrint('Firebase init failed: $e');
    }
  }
  Get.put(ThemeController());
  await GetStorage.init();
  runApp(const LumiFrameApp());
}

class LumiFrameApp extends StatelessWidget {
  const LumiFrameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
      return GetMaterialApp(
        title: 'LumiFrame',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
        initialBinding: InitialBindings(),
        debugShowCheckedModeBanner: false,
        getPages: [
          ...AppRoutes.routes,
          GetPage(name: '/slideshow', page: () => const SlideshowScreen()),
        ],
        home: const RootWidget(),
      );
    });
  }
}

/// RootWidget checks onboarding completion and routes accordingly.
class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  Future<bool> _isOnboardingCompleted() async {
    try {
      final box = GetStorage();
      return box.read<bool>('onboarding_completed') ?? false;
    } catch (e) {
      debugPrint('Storage check failed: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isOnboardingCompleted(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !(snapshot.data ?? false)) {
          return const OnboardingStart();
        }
        // If onboarding is complete, show the nav shell
        return const ResponsiveNavShell();
      },
    );
  }
}