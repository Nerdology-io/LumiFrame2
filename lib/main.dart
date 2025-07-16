import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'bindings/initial_bindings.dart';
import 'routes/app_routes.dart';
import 'firebase_options.dart';
import 'theme/app_themes.dart';
import 'controllers/theme_controller.dart';
import 'screens/onboarding/onboarding_start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ThemeController());
  runApp(const LumiFrameApp());
}

class LumiFrameApp extends StatelessWidget {
  const LumiFrameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LumiFrame',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: Get.find<ThemeController>().themeMode.value,
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      // home: const OnboardingStart(),
      home: const Scaffold(
        body: Center(
          child: Text('App Loaded', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}