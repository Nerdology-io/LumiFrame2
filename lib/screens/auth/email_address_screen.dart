import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/nav_shell_background_wrapper.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_auth_input.dart';

class EmailAddressScreen extends StatelessWidget {
  const EmailAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return NavShellBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: GlassmorphismSettingsWrapper(
                  horizontalPadding: 0,
                  blurSigma: 15.0,
                  opacity: 0.12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Text(
                        'Welcome to LumiFrame',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your email address to get started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.7)
                              : Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Form
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            GlassmorphismAuthInput(
                              labelText: 'Email Address',
                              hintText: 'Enter your email',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: true,
                              prefixIcon: const Icon(Icons.email_outlined),
                              validator: (value) {
                                if (value?.isEmpty ?? true) return 'Email is required';
                                if (!GetUtils.isEmail(value!)) return 'Please enter a valid email';
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Info Container
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.green.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.security_outlined,
                                    color: Colors.green.withOpacity(0.8),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Your email is secure and will only be used for authentication and important updates.',
                                      style: TextStyle(
                                        color: Colors.green.withOpacity(0.9),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            GlassmorphismAuthButton(
                              text: 'Continue',
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  // Store email and proceed to login
                                  Get.toNamed('/auth/login');
                                }
                              },
                            ),
                            
                            GlassmorphismAuthTextButton(
                              text: 'Already have an account? Sign In',
                              onPressed: () => Get.toNamed('/auth/login'),
                            ),
                            
                            // Alternative sign-in options
                            const SizedBox(height: 16),
                            
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.black.withOpacity(0.02),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.black.withOpacity(0.05),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Other sign-in options',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white.withOpacity(0.8)
                                          : Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _QuickSignInButton(
                                        icon: Icons.g_mobiledata,
                                        label: 'Google',
                                        onTap: () => controller.signInWithGoogle(),
                                      ),
                                      _QuickSignInButton(
                                        icon: Icons.apple,
                                        label: 'Apple',
                                        onTap: () => controller.signInWithApple(),
                                      ),
                                      _QuickSignInButton(
                                        icon: Icons.phone,
                                        label: 'Phone',
                                        onTap: () => Get.toNamed('/auth/phone-login'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickSignInButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _QuickSignInButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isDark 
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isDark 
                  ? Colors.white.withOpacity(0.8)
                  : Colors.black.withOpacity(0.7),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark 
                    ? Colors.white.withOpacity(0.7)
                    : Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}