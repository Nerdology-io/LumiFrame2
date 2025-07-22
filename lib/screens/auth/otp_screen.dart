import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/nav_shell_background_wrapper.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../theme/buttons/glassmorphism_auth_input.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController otpController = TextEditingController();

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
                        'Verification Code',
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
                        'Enter the 6-digit code sent to your phone',
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
                              labelText: 'Verification Code',
                              hintText: 'Enter 6-digit code',
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              autofocus: true,
                              prefixIcon: const Icon(Icons.sms_outlined),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) {
                                if (value?.isEmpty ?? true) return 'Verification code is required';
                                if (value!.length != 6) return 'Please enter the complete 6-digit code';
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
                                    Icons.timer_outlined,
                                    color: Colors.blue.withOpacity(0.8),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Code expires in 5 minutes. Check your messages for the verification code.',
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
                              text: 'Verify Code',
                              isLoading: controller.isLoading.value,
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  controller.confirmOtp(otpController.text);
                                }
                              },
                            )),
                            
                            GlassmorphismAuthTextButton(
                              text: 'Resend Code',
                              onPressed: () {
                                // TODO: Implement resend functionality
                                Get.snackbar(
                                  'Code Sent',
                                  'A new verification code has been sent to your phone',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                            ),
                            
                            GlassmorphismAuthTextButton(
                              text: 'Change Phone Number',
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
