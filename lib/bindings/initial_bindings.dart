import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/slideshow_controller.dart';
import '../controllers/theme_controller.dart';
import '../services/firebase_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseService>(() => FirebaseService());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SlideshowController>(() => SlideshowController());
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}