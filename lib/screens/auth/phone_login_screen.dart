import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Phone Sign In')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (e.g., +1 123-456-7890)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value?.isEmpty ?? true ? 'Phone number required' : (value?.startsWith('+') ?? false ? null : 'Include country code (+)'),
              ),
              const SizedBox(height: 24),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          controller.verifyPhone(phoneController.text);
                        }
                      },
                      child: const Text('Send Code'),
                    ),
              ),
              Obx(() => controller.errorMessage.value.isNotEmpty
                  ? Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red))
                  : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
