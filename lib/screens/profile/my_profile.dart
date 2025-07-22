import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/advanced_settings_controller.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../models/user.dart';
import '../../widgets/nav_shell_background_wrapper.dart';
import 'edit_profile.dart';
import 'change_password.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NavShellBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Profile Header Card
              GlassmorphismSettingsWrapper(
                horizontalPadding: 8.0,
                child: Obx(() {
                  final user = authCtrl.currentUser.value;
                  if (user == null) {
                    return const Center(
                      child: Text('Not logged in', style: TextStyle(color: Colors.grey)),
                    );
                  }

                  // Create UserProfile from Firebase user
                  final profile = UserProfile.fromFirebaseUser(user);
                  
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                      // Profile Picture
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: profile.photoURL != null
                                ? NetworkImage(profile.photoURL!)
                                : const NetworkImage(
                                    'https://www.caseyscaptures.com/wp-content/uploads/IMG_0225-3000@70.jpg'
                                  ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Display Name
                      Text(
                        profile.effectiveDisplayName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Email
                      Text(
                        profile.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Provider Badge
                      if (profile.provider != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getProviderColor(profile.provider!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Signed in with ${_getProviderDisplayName(profile.provider!)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
                }),
              ),
              
              const SizedBox(height: 20),
              
              // Account Actions
              GlassmorphismSettingsWrapper(
                title: 'Account Actions',
                horizontalPadding: 8.0,
                child: Obx(() {
                  final user = authCtrl.currentUser.value;
                  final profile = user != null ? UserProfile.fromFirebaseUser(user) : null;
                  final isEmailPasswordUser = profile?.provider == 'password';

                  return Column(
                    children: [
                      _buildActionTile(
                        icon: Icons.edit,
                        title: 'Edit Profile',
                        subtitle: 'Update your personal information',
                        onTap: () => Get.to(() => const EditProfile()),
                        isDark: isDark,
                      ),
                      // Only show password change for email/password users
                      if (isEmailPasswordUser)
                        _buildActionTile(
                          icon: Icons.security,
                          title: 'Change Password',
                          subtitle: 'Update your login password',
                          onTap: () => Get.to(() => const ChangePassword()),
                          isDark: isDark,
                        ),
                      // Show general security for social users
                      if (!isEmailPasswordUser)
                        _buildActionTile(
                          icon: Icons.security,
                          title: 'Account Security',
                          subtitle: 'Manage your account security settings',
                          onTap: () {
                            Get.snackbar(
                              'Social Login Account',
                              'Password is managed by your ${profile?.provider == 'google.com' ? 'Google' : 'social login'} provider',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.blue,
                              colorText: Colors.white,
                            );
                          },
                          isDark: isDark,
                        ),
                      _buildActionTile(
                        icon: Icons.download,
                        title: 'Export Data',
                        subtitle: 'Download your photos and data',
                        onTap: () {
                          // TODO: Implement data export
                          Get.snackbar('Coming Soon', 'Data export will be available soon');
                        },
                        isDark: isDark,
                      ),
                    ],
                  );
                }),
              ),
              
              const SizedBox(height: 20),
              
              // Security Section
              GlassmorphismSettingsWrapper(
                title: 'Security',
                horizontalPadding: 8.0,
                child: Builder(
                  builder: (context) {
                    final advancedController = Get.put(AdvancedSettingsController());
                    
                    return Column(
                      children: [
                        // Passcode Lock
                        Obx(() => SwitchListTile(
                          title: Text(
                            'Passcode Lock',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            'Secure app access with a passcode',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          value: advancedController.passcodeEnabled.value,
                          onChanged: advancedController.setPasscodeEnabled,
                          activeColor: Theme.of(context).colorScheme.primary,
                        )),
                        
                        // Face ID / Biometrics
                        Obx(() => SwitchListTile(
                          title: Text(
                            'Biometric Authentication',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            advancedController.biometricsAvailable.value 
                                ? 'Use Face ID, Touch ID, or fingerprint' 
                                : 'Not available on this device',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          value: advancedController.faceIdEnabled.value,
                          onChanged: advancedController.biometricsAvailable.value 
                              ? advancedController.setFaceIdEnabled 
                              : null,
                          activeColor: Theme.of(context).colorScheme.primary,
                        )),
                      ],
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Account Management
              GlassmorphismSettingsWrapper(
                title: 'Account Management',
                horizontalPadding: 8.0,
                child: Column(
                  children: [
                    _buildActionTile(
                      icon: Icons.logout,
                      title: 'Sign Out',
                      subtitle: 'Sign out of your account',
                      onTap: () => _showLogoutDialog(context, authCtrl),
                      isDark: isDark,
                      isDestructive: true,
                    ),
                    _buildActionTile(
                      icon: Icons.delete_forever,
                      title: 'Delete Account',
                      subtitle: 'Permanently delete your account',
                      onTap: () => _showDeleteAccountDialog(context, authCtrl),
                      isDark: isDark,
                      isDestructive: true,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
  }) {
    final color = isDestructive 
        ? Colors.red 
        : (isDark ? Colors.white : Colors.black87);
    
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDestructive 
              ? Colors.red.withOpacity(0.7)
              : (isDark ? Colors.white70 : Colors.black54),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDark ? Colors.white54 : Colors.black38,
      ),
      onTap: onTap,
    );
  }

  Color _getProviderColor(String provider) {
    switch (provider) {
      case 'google':
        return Colors.red;
      case 'apple':
        return Colors.black;
      case 'facebook':
        return Colors.blue;
      case 'phone':
        return Colors.green;
      case 'email':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getProviderDisplayName(String provider) {
    switch (provider) {
      case 'google':
        return 'Google';
      case 'apple':
        return 'Apple';
      case 'facebook':
        return 'Facebook';
      case 'phone':
        return 'Phone';
      case 'email':
        return 'Email';
      default:
        return 'Unknown';
    }
  }

  void _showLogoutDialog(BuildContext context, AuthController authCtrl) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Get.dialog(
      AlertDialog(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Text(
          'Sign Out',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              authCtrl.logout();
            },
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, AuthController authCtrl) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Get.dialog(
      AlertDialog(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Text(
          'Delete Account',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          'This action cannot be undone. All your photos, settings, and data will be permanently deleted.',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Implement account deletion
              Get.snackbar('Coming Soon', 'Account deletion will be available soon');
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}