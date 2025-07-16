import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:lumiframe/widgets/responsive_nav_shell.dart';
import 'package:lumiframe/controllers/auth_controller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    final nameCtrl = TextEditingController(); // Example for name editing

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save changes logic, e.g., update user profile via authCtrl or service
                Get.back();
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}