import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../controllers/auth_controller.dart';

class EmailAddressScreen extends StatelessWidget {
  const EmailAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
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
                // Proceed to password or sign up; example: validate and navigate
                if (emailCtrl.text.isNotEmpty) {
                  Get.toNamed('/auth/password'); // Assume next route
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