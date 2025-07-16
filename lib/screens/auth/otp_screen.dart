import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Enter OTP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: otpController,
                decoration: const InputDecoration(
                  labelText: '6-Digit Code',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) => value?.length != 6 ? 'Enter 6-digit code' : null,
              ),
              const SizedBox(height: 24),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          controller.confirmOtp(otpController.text);
                        }
                      },
                      child: const Text('Verify'),
                    ),
              ),
              Obx(() => controller.errorMessage.value.isNotEmpty
                  ? Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red))
                  : const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Resend Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
