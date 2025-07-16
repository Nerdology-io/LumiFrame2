import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

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

    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(showSignUp.value ? 'Sign Up' : 'Sign In'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!showSignUp.value) ...[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => controller.checkEmailVerifiedAndLogin(
                        emailController.text,
                        passwordController.text,
                      ),
                      child: const Text('Sign In with Email'),
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => showSignUp.value = true,
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ] else ...[
              TextFormField(
                controller: signupEmailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: signupPasswordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => controller.signUpWithEmail(
                        signupEmailController.text,
                        signupPasswordController.text,
                      ),
                      child: const Text('Sign Up'),
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => showSignUp.value = false,
                child: const Text('Already have an account? Sign In'),
              ),
            ],
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.g_mobiledata),
              label: const Text('Sign in with Google'),
              onPressed: () => controller.signInWithGoogle(),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.apple),
              label: const Text('Sign in with Apple'),
              onPressed: () => controller.signInWithApple(),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.facebook),
              label: const Text('Sign in with Facebook'),
              onPressed: () => controller.signInWithFacebook(),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text('Sign in with Phone'),
              onPressed: () => Get.toNamed('/auth/phone-login'),
            ),
            const SizedBox(height: 24),
            controller.errorMessage.value.isNotEmpty
                ? Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red))
                : const SizedBox.shrink(),
          ],
        )),
      ),
    );
  }
}
