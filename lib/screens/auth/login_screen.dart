import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/dynamic_time_controller.dart';
import '../../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final DynamicTimeController timeController = Get.find<DynamicTimeController>();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    
    return Scaffold(
      body: Obx(() => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _getTimeBasedGradient(),
        ),
        child: SafeArea(
          child: isLandscape ? _buildLandscapeLayout(size) : _buildPortraitLayout(size),
        ),
      )),
    );
  }

  Widget _buildPortraitLayout(Size size) {
    return SingleChildScrollView(
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
            SizedBox(height: size.height * 0.08),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(Size size) {
    return Padding(
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
                ],
              ),
            ),
          ),
        ],
      ),
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
              const SizedBox(height: 24),
              _buildSignInButton(),
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

  Widget _buildSignInButton() {
    return Obx(() => Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryColor.withOpacity(0.8),
            AppConstants.accentColor.withOpacity(0.6),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          onTap: authController.isLoading.value ? null : () => _handleSignIn(),
          child: Center(
            child: authController.isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
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
    ));
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
    final timeBasedColors = _getTimeBasedColors();
    final luminosity = _getLuminosityMultiplier();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: timeBasedColors.map((color) => 
        Color.lerp(isDark ? Colors.black : Colors.white, color, luminosity)!
      ).toList(),
      stops: const [0.0, 0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.85, 1.0],
    );
  }

  // Get time-based gradient colors that work with light/dark theme
  List<Color> _getTimeBasedColors() {
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    // Convert current time to normalized time of day (0.0 = midnight, 1.0 = next midnight)
    final timeOfDay = _getCurrentNormalizedTime();
    
    // Base colors - adjust opacity and intensity based on theme
    final baseMultiplier = isDark ? 0.8 : 1.0;
    final opacityMultiplier = isDark ? 0.9 : 0.7;
    
    if (timeOfDay < 0.15) {
      // Night - Deep blues and purples
      return [
        Color(0xFF0a0a1a).withOpacity(baseMultiplier),
        Color(0xFF1a1a2e).withOpacity(baseMultiplier),
        Color(0xFF16213e).withOpacity(baseMultiplier),
        Color(0xFF0f3460).withOpacity(baseMultiplier),
        Color(0xFF533483).withOpacity(baseMultiplier),
        Color(0xFF7209b7).withOpacity(opacityMultiplier),
        Color(0xFF560bad).withOpacity(opacityMultiplier),
        Color(0xFF480ca8).withOpacity(opacityMultiplier),
        Color(0xFF3a0ca3).withOpacity(opacityMultiplier),
      ];
    } else if (timeOfDay < 0.25) {
      // Early Morning - Purple to pink dawn
      double progress = (timeOfDay - 0.15) / 0.1;
      return _interpolateGradients([
        Color(0xFF0a0a1a).withOpacity(baseMultiplier),
        Color(0xFF1a1a2e).withOpacity(baseMultiplier),
        Color(0xFF16213e).withOpacity(baseMultiplier),
        Color(0xFF0f3460).withOpacity(baseMultiplier),
        Color(0xFF533483).withOpacity(baseMultiplier),
        Color(0xFF7209b7).withOpacity(opacityMultiplier),
        Color(0xFF560bad).withOpacity(opacityMultiplier),
        Color(0xFF480ca8).withOpacity(opacityMultiplier),
        Color(0xFF3a0ca3).withOpacity(opacityMultiplier),
      ], [
        Color(0xFF1a1c3a).withOpacity(baseMultiplier),
        Color(0xFF2d1b69).withOpacity(baseMultiplier),
        Color(0xFF4a148c).withOpacity(baseMultiplier),
        Color(0xFF6a1b9a).withOpacity(baseMultiplier),
        Color(0xFFad1457).withOpacity(baseMultiplier),
        Color(0xFFd81b60).withOpacity(opacityMultiplier),
        Color(0xFFf06292).withOpacity(opacityMultiplier),
        Color(0xFFffa726).withOpacity(opacityMultiplier),
        Color(0xFFffcc02).withOpacity(opacityMultiplier),
      ], progress);
    } else if (timeOfDay < 0.4) {
      // Morning - Warm sunrise colors
      double progress = (timeOfDay - 0.25) / 0.15;
      return _interpolateGradients([
        Color(0xFF1a1c3a).withOpacity(baseMultiplier),
        Color(0xFF2d1b69).withOpacity(baseMultiplier),
        Color(0xFF4a148c).withOpacity(baseMultiplier),
        Color(0xFF6a1b9a).withOpacity(baseMultiplier),
        Color(0xFFad1457).withOpacity(baseMultiplier),
        Color(0xFFd81b60).withOpacity(opacityMultiplier),
        Color(0xFFf06292).withOpacity(opacityMultiplier),
        Color(0xFFffa726).withOpacity(opacityMultiplier),
        Color(0xFFffcc02).withOpacity(opacityMultiplier),
      ], [
        Color(0xFF87ceeb).withOpacity(isDark ? 0.6 : 1.0),
        Color(0xFF98d8e8).withOpacity(isDark ? 0.6 : 1.0),
        Color(0xFFb8e6b8).withOpacity(isDark ? 0.6 : 1.0),
        Color(0xFFffb347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
      ], progress);
    } else if (timeOfDay < 0.6) {
      // Afternoon - Bright blues and whites (adjusted for dark theme)
      if (isDark) {
        return [
          Color(0xFF4a90e2).withOpacity(0.6),
          Color(0xFF5ba3f5).withOpacity(0.6),
          Color(0xFF6bb6ff).withOpacity(0.6),
          Color(0xFF7cc8ff).withOpacity(0.6),
          Color(0xFF8dd9ff).withOpacity(0.6),
          Color(0xFF9eeaff).withOpacity(0.6),
          Color(0xFFaffbff).withOpacity(0.6),
          Color(0xFFc0ffff).withOpacity(0.6),
          Color(0xFFd1ffff).withOpacity(0.6),
        ];
      } else {
        return [
          const Color(0xFF87ceeb),
          const Color(0xFF87cefa),
          const Color(0xFF98d8e8),
          const Color(0xFFb8e6b8),
          const Color(0xFFe0ffff),
          const Color(0xFFf0f8ff),
          const Color(0xFFf5f5dc),
          const Color(0xFFfffacd),
          const Color(0xFFffffff),
        ];
      }
    } else if (timeOfDay < 0.75) {
      // Late Afternoon - Golden hour
      double progress = (timeOfDay - 0.6) / 0.15;
      final fromColors = isDark ? [
        Color(0xFF4a90e2).withOpacity(0.6),
        Color(0xFF5ba3f5).withOpacity(0.6),
        Color(0xFF6bb6ff).withOpacity(0.6),
        Color(0xFF7cc8ff).withOpacity(0.6),
        Color(0xFF8dd9ff).withOpacity(0.6),
        Color(0xFF9eeaff).withOpacity(0.6),
        Color(0xFFaffbff).withOpacity(0.6),
        Color(0xFFc0ffff).withOpacity(0.6),
        Color(0xFFd1ffff).withOpacity(0.6),
      ] : [
        const Color(0xFF87ceeb),
        const Color(0xFF87cefa),
        const Color(0xFF98d8e8),
        const Color(0xFFb8e6b8),
        const Color(0xFFe0ffff),
        const Color(0xFFf0f8ff),
        const Color(0xFFf5f5dc),
        const Color(0xFFfffacd),
        const Color(0xFFffffff),
      ];
      
      return _interpolateGradients(fromColors, [
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff7f50).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFdc143c).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFb22222).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFF8b0000).withOpacity(isDark ? 0.7 : 1.0),
      ], progress);
    } else if (timeOfDay < 0.85) {
      // Evening - Sunset colors
      return [
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff7f50).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFdc143c).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFb22222).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFF8b0000).withOpacity(isDark ? 0.7 : 1.0),
      ];
    } else if (timeOfDay < 0.95) {
      // Late Evening - Deep oranges to purples
      double progress = (timeOfDay - 0.85) / 0.1;
      return _interpolateGradients([
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff7f50).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFdc143c).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFb22222).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFF8b0000).withOpacity(isDark ? 0.7 : 1.0),
      ], [
        Color(0xFF4b0082).withOpacity(baseMultiplier),
        Color(0xFF483d8b).withOpacity(baseMultiplier),
        Color(0xFF6a5acd).withOpacity(baseMultiplier),
        Color(0xFF7b68ee).withOpacity(baseMultiplier),
        Color(0xFF9370db).withOpacity(baseMultiplier),
        Color(0xFFba55d3).withOpacity(opacityMultiplier),
        Color(0xFFda70d6).withOpacity(opacityMultiplier),
        Color(0xFFdda0dd).withOpacity(opacityMultiplier),
        Color(0xFFe6e6fa).withOpacity(opacityMultiplier),
      ], progress);
    } else {
      // Night - Return to deep night colors
      double progress = (timeOfDay - 0.95) / 0.05;
      return _interpolateGradients([
        Color(0xFF4b0082).withOpacity(baseMultiplier),
        Color(0xFF483d8b).withOpacity(baseMultiplier),
        Color(0xFF6a5acd).withOpacity(baseMultiplier),
        Color(0xFF7b68ee).withOpacity(baseMultiplier),
        Color(0xFF9370db).withOpacity(baseMultiplier),
        Color(0xFFba55d3).withOpacity(opacityMultiplier),
        Color(0xFFda70d6).withOpacity(opacityMultiplier),
        Color(0xFFdda0dd).withOpacity(opacityMultiplier),
        Color(0xFFe6e6fa).withOpacity(opacityMultiplier),
      ], [
        Color(0xFF0a0a1a).withOpacity(baseMultiplier),
        Color(0xFF1a1a2e).withOpacity(baseMultiplier),
        Color(0xFF16213e).withOpacity(baseMultiplier),
        Color(0xFF0f3460).withOpacity(baseMultiplier),
        Color(0xFF533483).withOpacity(baseMultiplier),
        Color(0xFF7209b7).withOpacity(opacityMultiplier),
        Color(0xFF560bad).withOpacity(opacityMultiplier),
        Color(0xFF480ca8).withOpacity(opacityMultiplier),
        Color(0xFF3a0ca3).withOpacity(opacityMultiplier),
      ], progress);
    }
  }
  
  // Interpolate between two gradient arrays
  List<Color> _interpolateGradients(List<Color> from, List<Color> to, double t) {
    List<Color> result = [];
    for (int i = 0; i < from.length && i < to.length; i++) {
      result.add(Color.lerp(from[i], to[i], t)!);
    }
    return result;
  }
  
  // Get luminosity multiplier based on time of day and theme
  double _getLuminosityMultiplier() {
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    final timeOfDay = _getCurrentNormalizedTime();
    
    // Adjust luminosity based on theme
    final baseMultiplier = isDark ? 1.2 : 1.0;
    
    // Darkest at night (0.3), brightest at midday (1.0)
    if (timeOfDay < 0.15 || timeOfDay > 0.9) {
      return (0.3 * baseMultiplier).clamp(0.0, 1.0); // Night
    } else if (timeOfDay < 0.25) {
      return (0.4 + (timeOfDay - 0.15) * 2) * baseMultiplier; // Early morning rising
    } else if (timeOfDay < 0.4) {
      return (0.6 + (timeOfDay - 0.25) * 2.67) * baseMultiplier; // Morning brightening
    } else if (timeOfDay < 0.6) {
      return (1.0 * baseMultiplier).clamp(0.0, 1.0); // Full daylight
    } else if (timeOfDay < 0.85) {
      return (1.0 - (timeOfDay - 0.6) * 2.8) * baseMultiplier; // Evening dimming
    } else {
      return (0.3 + (0.9 - timeOfDay) * 4) * baseMultiplier; // Late evening to night
    }
  }

  // Convert current system time to normalized time of day (0.0 = midnight, 1.0 = next midnight)
  double _getCurrentNormalizedTime() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final second = now.second;
    
    // Convert to decimal hours (0.0 to 24.0)
    final decimalHours = hour + (minute / 60.0) + (second / 3600.0);
    
    // Normalize to 0.0 to 1.0 (where 0.0 is midnight)
    return decimalHours / 24.0;
  }
}