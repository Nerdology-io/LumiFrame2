import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../services/firebase_service.dart';


class AuthController extends GetxController {
  final FirebaseService _firebaseService = Get.find();
  final GetStorage _box = GetStorage();
  var isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  User? get currentUser => _firebaseService.currentUser;

  Future<void> signInWithEmail(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    final user = await _firebaseService.signInWithEmail(email, password);
    isLoading.value = false;
    if (user != null) {
      await _completeOnboardingAndNavigate();
    } else {
      errorMessage.value = 'Email sign-in failed. Please check your credentials.';
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return; // User cancelled
      }
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      await _completeOnboardingAndNavigate();
    } catch (e) {
      errorMessage.value = 'Google login failed: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithApple() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken ?? '',
        accessToken: appleCredential.authorizationCode,
      );
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      await _completeOnboardingAndNavigate();
    } catch (e) {
      errorMessage.value = 'Apple login failed: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithFacebook() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken?.tokenString ?? '');
        await FirebaseAuth.instance.signInWithCredential(credential);
        await _completeOnboardingAndNavigate();
      } else {
        errorMessage.value = 'Facebook login canceled or failed';
        throw 'Facebook login canceled or failed';
      }
    } catch (e) {
      errorMessage.value = 'Facebook login failed: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        errorMessage.value = 'Verification email sent. Please check your inbox.';
      }
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Sign-up failed.';
    } catch (e) {
      errorMessage.value = 'Sign-up failed: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkEmailVerifiedAndLogin(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await userCredential.user?.reload();
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        await _completeOnboardingAndNavigate();
      } else {
        errorMessage.value = 'Please verify your email before logging in.';
      }
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Login failed.';
    } catch (e) {
      errorMessage.value = 'Login failed: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _firebaseService.logout();
    Get.offAllNamed('/auth/email_address');
  }

  Future<void> _completeOnboardingAndNavigate() async {
    try {
      await _box.write('onboarding_completed', true);
    } catch (e) {
      // Optionally log or handle storage error
    }
    Get.offAllNamed('/dashboard');
  }
}