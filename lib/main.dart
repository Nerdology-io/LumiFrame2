import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'bindings/initial_bindings.dart';
import 'routes/app_routes.dart';
import 'theme/app_themes.dart';
import 'theme/base_theme.dart';
import 'controllers/theme_controller.dart';
import 'controllers/nav_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/dynamic_time_controller.dart';
import 'services/cast_service.dart';
import 'services/firebase_service.dart';
import 'services/passcode_service.dart';
import 'services/media_service.dart';
import 'services/media_auth_service.dart';
import 'screens/onboarding/onboarding_start.dart';
import 'screens/auth/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'widgets/responsive_nav_shell.dart';
import 'screens/slideshow_screen.dart';
import 'screens/security/passcode_screen.dart';

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
  Get.put(MediaService());
  Get.put(MediaAuthService());
  Get.put(DynamicTimeController());
  Get.put(PasscodeService());
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
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: LumiFrameDarkTheme.primary,
          scaffoldBackgroundColor: LumiFrameDarkTheme.background,
          cardTheme: LumiFrameDarkTheme.cardTheme,
          snackBarTheme: LumiFrameDarkTheme.snackBarTheme,
          dividerTheme: LumiFrameDarkTheme.dividerTheme,
          inputDecorationTheme: LumiFrameDarkTheme.inputDecorationTheme,
          iconTheme: LumiFrameDarkTheme.iconTheme,
          switchTheme: LumiFrameDarkTheme.switchTheme,
          progressIndicatorTheme: LumiFrameDarkTheme.progressIndicatorTheme,
        ),
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
            return LoginScreen();
          }
          
          // User is authenticated, now check app launch passcode
          return const AppLaunchPasscodeWrapper();
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

/// AppLaunchPasscodeWrapper checks if app launch passcode is required
class AppLaunchPasscodeWrapper extends StatefulWidget {
  const AppLaunchPasscodeWrapper({super.key});

  @override
  State<AppLaunchPasscodeWrapper> createState() => _AppLaunchPasscodeWrapperState();
}

class _AppLaunchPasscodeWrapperState extends State<AppLaunchPasscodeWrapper> with WidgetsBindingObserver {
  final PasscodeService passcodeService = Get.find<PasscodeService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Debug logging
    debugPrint('App lifecycle state changed to: $state');
    debugPrint('App passcode enabled: ${passcodeService.isAppPasscodeEnabled.value}');
    debugPrint('App passcode set: ${passcodeService.isAppPasscodeSet.value}');
    
    // Lock the app when it goes to background if app passcode is enabled
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      if (passcodeService.isAppPasscodeEnabled.value && passcodeService.isAppPasscodeSet.value) {
        debugPrint('Locking app due to background state');
        passcodeService.lockApp();
      }
    }
    
    // Note: We do NOT lock on resumed state - the app should only be locked
    // when it actually goes to background (paused/detached), not on normal navigation
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // If app is locked and app launch passcode is enabled, show passcode screen
      if (passcodeService.isAppLocked.value && passcodeService.isAppPasscodeEnabled.value) {
        return PasscodeScreen(
          mode: PasscodeMode.appUnlock,
          title: 'Enter App Passcode',
          subtitle: 'Enter your passcode to access LumiFrame',
          onSuccess: () {
            // App will automatically update isAppLocked.value in PasscodeService
            // No need to navigate as this widget will rebuild
          },
        );
      }
      
      // App is unlocked or no passcode required, show main interface
      return const ResponsiveNavShell();
    });
  }
}