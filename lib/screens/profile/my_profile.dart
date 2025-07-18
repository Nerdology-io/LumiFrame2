import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../controllers/auth_controller.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('My Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Email: ${authCtrl.currentUser.value?.email ?? 'Not logged in'}')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed('/profile/edit'),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: authCtrl.logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}