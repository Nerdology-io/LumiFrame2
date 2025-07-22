import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/nav_shell_background_wrapper.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_auth_input.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController phoneController = TextEditingController();

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
                        'Phone Verification',
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
                        'Enter your phone number to receive a verification code',
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
                              labelText: 'Phone Number',
                              hintText: 'e.g., +1 123-456-7890',
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone_outlined),
                              validator: (value) {
                                if (value?.isEmpty ?? true) return 'Phone number is required';
                                // Basic phone validation - should start with + and contain digits
                                if (!value!.startsWith('+')) return 'Please include country code (e.g., +1)';
                                if (value.replaceAll(RegExp(r'[^\d]'), '').length < 10) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Info Container
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.blue.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.blue.withOpacity(0.8),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'We\'ll send a 6-digit verification code to this number. Message and data rates may apply.',
                                      style: TextStyle(
                                        color: Colors.blue.withOpacity(0.9),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            Obx(() => GlassmorphismAuthButton(
                              text: 'Send Verification Code',
                              isLoading: controller.isLoading.value,
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  controller.verifyPhone(phoneController.text);
                                }
                              },
                            )),
                            
                            GlassmorphismAuthTextButton(
                              text: 'Back to Login',
                              onPressed: () => Get.back(),
                            ),
                            
                            // Error Message
                            const SizedBox(height: 16),
                            Obx(() => controller.errorMessage.value.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.red.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red.withOpacity(0.8),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            controller.errorMessage.value,
                                            style: TextStyle(
                                              color: Colors.red.withOpacity(0.9),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink()),
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


