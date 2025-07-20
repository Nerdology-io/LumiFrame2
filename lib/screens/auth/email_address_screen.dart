import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../controllers/auth_controller.dart';

class EmailAddressScreen extends StatelessWidget {
  const EmailAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();
    final emailCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Enter Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Proceed to login screen with the email
                if (emailCtrl.text.isNotEmpty) {
                  Get.toNamed('/auth/login');
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}