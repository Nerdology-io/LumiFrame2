import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final ThemeController themeController = Get.find<ThemeController>();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isPasswordHidden = true.obs;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _getTimeBasedGradient(),
        ),
        child: SafeArea(
          child: isLandscape ? _buildLandscapeLayout(size) : _buildPortraitLayout(size),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(Size size) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.15),
                _buildWelcomeText(),
                SizedBox(height: size.height * 0.06),
                _buildAuthForm(),
                SizedBox(height: size.height * 0.04),
                _buildSocialAuth(),
                SizedBox(height: size.height * 0.15), // Space for bottom button
              ],
            ),
          ),
        ),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildLandscapeLayout(Size size) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWelcomeText(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAuthForm(),
                      const SizedBox(height: 32),
                      _buildSocialAuth(),
                      const SizedBox(height: 80), // Space for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to your account or create a new one',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
            shadows: [
              Shadow(
                offset: const Offset(0, 1),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAuthForm() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Column(
            children: [
              const SizedBox(height: 8),
              _buildTextField(
                controller: emailController,
                label: 'Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              Obx(() => _buildTextField(
                controller: passwordController,
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: isPasswordHidden.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: () => isPasswordHidden.toggle(),
                ),
              )),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showForgotPasswordDialog(),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.7),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialAuth() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildSocialButton(
                icon: Icons.g_mobiledata,
                label: 'Google',
                onPressed: () => authController.signInWithGoogle(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                onPressed: () => authController.signInWithFacebook(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: () => _showSignUpDialog(),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white.withOpacity(0.9),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.3),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() => Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white.withOpacity(0.15),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: authController.isLoading.value
                        ? null
                        : () => _handleSignIn(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: authController.isLoading.value
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              )
                            : Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.95),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(0, 1),
                                      blurRadius: 2,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }

  void _handleSignIn() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }
    
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }
    
    // For now, simulate a successful login and navigate to dashboard
    authController.isLoading.value = true;
    
    Future.delayed(const Duration(seconds: 2), () {
      authController.isLoading.value = false;
      Get.offAllNamed('/dashboard');
    });
  }

  void _showForgotPasswordDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.8),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Password reset functionality will be implemented soon.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignUpDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.8),
        title: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Account creation will be implemented soon. For now, you can use Google or Facebook sign-in.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _getTimeBasedGradient() {
    final hour = DateTime.now().hour;
    
    if (hour >= 6 && hour < 12) {
      // Morning: Soft sunrise colors
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFF9A9E),
          Color(0xFFFECFEF),
          Color(0xFFFECFEF),
        ],
      );
    } else if (hour >= 12 && hour < 17) {
      // Afternoon: Bright blue sky
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF667eea),
          Color(0xFF764ba2),
        ],
      );
    } else if (hour >= 17 && hour < 20) {
      // Evening: Sunset colors
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF093FB),
          Color(0xFFF5576C),
        ],
      );
    } else {
      // Night: Deep purple/blue
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2C3E50),
          Color(0xFF4A6741),
        ],
      );
    }
  }
}