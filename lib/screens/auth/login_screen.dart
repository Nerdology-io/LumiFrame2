import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/nav_shell_background_wrapper.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_auth_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController signupEmailController = TextEditingController();
    final TextEditingController signupPasswordController = TextEditingController();
    final RxBool showSignUp = false.obs;
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
                child: Obx(() => GlassmorphismSettingsWrapper(
                  horizontalPadding: 0,
                  blurSigma: 15.0,
                  opacity: 0.12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Text(
                        showSignUp.value ? 'Create Account' : 'Welcome Back',
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
                        showSignUp.value 
                            ? 'Sign up to start your LumiFrame journey'
                            : 'Sign in to access your digital photo frame',
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
                            if (!showSignUp.value) ...[
                              // Sign In Form
                              GlassmorphismAuthInput(
                                labelText: 'Email Address',
                                hintText: 'Enter your email',
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.email_outlined),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) return 'Email is required';
                                  if (!GetUtils.isEmail(value!)) return 'Please enter a valid email';
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              GlassmorphismAuthInput(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                controller: passwordController,
                                obscureText: true,
                                prefixIcon: const Icon(Icons.lock_outlined),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) return 'Password is required';
                                  if (value!.length < 6) return 'Password must be at least 6 characters';
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 8),
                              
                              // Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: GlassmorphismAuthTextButton(
                                  text: 'Forgot Password?',
                                  onPressed: () {
                                    // Handle forgot password
                                  },
                                ),
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // Sign In Button
                              GlassmorphismAuthButton(
                                text: 'Sign In',
                                isLoading: controller.isLoading.value,
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ?? false) {
                                    // Use existing auth method
                                    await controller.signInWithEmail(
                                      emailController.text.trim(),
                                      passwordController.text,
                                    );
                                  }
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Toggle to Sign Up
                              GlassmorphismAuthTextButton(
                                text: "Don't have an account? Sign Up",
                                onPressed: () => showSignUp.value = true,
                              ),
                              
                            ] else ...[
                              // Sign Up Form
                              GlassmorphismAuthInput(
                                labelText: 'Email Address',
                                hintText: 'Enter your email',
                                controller: signupEmailController,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.email_outlined),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) return 'Email is required';
                                  if (!GetUtils.isEmail(value!)) return 'Please enter a valid email';
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              GlassmorphismAuthInput(
                                labelText: 'Password',
                                hintText: 'Create a password',
                                controller: signupPasswordController,
                                obscureText: true,
                                prefixIcon: const Icon(Icons.lock_outlined),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) return 'Password is required';
                                  if (value!.length < 6) return 'Password must be at least 6 characters';
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // Sign Up Button
                              GlassmorphismAuthButton(
                                text: 'Create Account',
                                isLoading: controller.isLoading.value,
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ?? false) {
                                    // Use existing auth method
                                    await controller.signUpWithEmail(
                                      signupEmailController.text.trim(),
                                      signupPasswordController.text,
                                    );
                                  }
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Toggle to Sign In
                              GlassmorphismAuthTextButton(
                                text: 'Already have an account? Sign In',
                                onPressed: () => showSignUp.value = false,
                              ),
                            ],
                            
                            const SizedBox(height: 16),
                            
                            // Error Display
                            if (controller.errorMessage.value.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        controller.errorMessage.value,
                                        style: const TextStyle(color: Colors.red, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                            const SizedBox(height: 24),
                            
                            // Divider
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.grey.withOpacity(0.5))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.grey.withOpacity(0.5))),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Social Login Buttons
                            Column(
                              children: [
                                GlassmorphismAuthButton(
                                  text: 'Continue with Phone',
                                  onPressed: () => Get.toNamed('/auth/phone-login'),
                                ),
                                
                                const SizedBox(height: 12),
                                
                                GlassmorphismAuthButton(
                                  text: 'Continue with Google',
                                  onPressed: () => controller.signInWithGoogle(),
                                ),
                                
                                const SizedBox(height: 12),
                                
                                GlassmorphismAuthButton(
                                  text: 'Continue with Apple',
                                  onPressed: () => controller.signInWithApple(),
                                ),
                                
                                const SizedBox(height: 12),
                                
                                GlassmorphismAuthButton(
                                  text: 'Continue with Facebook',
                                  onPressed: () => controller.signInWithFacebook(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
