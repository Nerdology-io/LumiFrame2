import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'bindings/initial_bindings.dart';
import 'routes/app_routes.dart';
import 'theme/app_themes.dart';
import 'controllers/theme_controller.dart';
import 'controllers/nav_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/dynamic_time_controller.dart';
import 'services/cast_service.dart';
import 'services/firebase_service.dart';
import 'screens/onboarding/onboarding_start.dart';
import 'screens/auth/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'widgets/responsive_nav_shell.dart';
import 'screens/slideshow_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure system UI overlay style to make status bar transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  
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
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(NavController());
  Get.put(FirebaseService());
  Get.put(AuthController());
  Get.put(CastService());
  Get.put(DynamicTimeController());
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
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const RootWidget()),
          ...AppRoutes.routes,
          GetPage(name: '/slideshow', page: () => const SlideshowScreen()),
        ],
      );
    });
  }
}

/// RootWidget checks onboarding completion and authentication status.
class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    
    return FutureBuilder<bool>(
      future: _isOnboardingCompleted(),
      builder: (context, onboardingSnapshot) {
        if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        // If onboarding is not complete, show onboarding
        if (onboardingSnapshot.hasError || !(onboardingSnapshot.data ?? false)) {
          return const OnboardingStart();
        }
        
        // Onboarding is complete, now check authentication
        return Obx(() {
          final user = authController.currentUser.value;
          
          // If user is not signed in, go to login screen
          if (user == null) {
            return const LoginScreen();
          }
          
          // User is authenticated, show the nav shell
          return const ResponsiveNavShell();
        });
      },
    );
  }

  Future<bool> _isOnboardingCompleted() async {
    try {
      final box = GetStorage();
      return box.read<bool>('onboarding_completed') ?? false;
    } catch (e) {
      debugPrint('Storage check failed: $e');
      return false;
    }
  }
}