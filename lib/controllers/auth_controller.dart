import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = Get.find();
  var isLoading = false.obs;

  User? get currentUser => _firebaseService.currentUser;

  Future<void> signInWithEmail(String email, String password) async {
    isLoading.value = true;
    final user = await _firebaseService.signInWithEmail(email, password);
    isLoading.value = false;
    if (user != null) {
      Get.offAllNamed('/dashboard');
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    final user = await _firebaseService.signInWithGoogle();
    isLoading.value = false;
    if (user != null) {
      Get.offAllNamed('/dashboard');
    }
  }

  Future<void> logout() async {
    await _firebaseService.logout();
    Get.offAllNamed('/auth/email_address');
  }
}