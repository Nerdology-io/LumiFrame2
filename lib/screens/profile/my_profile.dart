import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/advanced_settings_controller.dart';
import '../../services/passcode_service.dart';
import '../../theme/theme_extensions.dart';
import '../../theme/backgrounds/dark_blur_background.dart';
import '../../theme/backgrounds/light_blur_background.dart';
import '../../models/user.dart';
import 'edit_profile.dart';
import 'change_password.dart';
import '../security/passcode_settings_screen.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final background = isDark ? const DarkBlurBackground() : const LightBlurBackground();

    return Stack(
      children: [
        background,
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'My Profile',
              style: TextStyle(
                color: context.primaryTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: context.primaryTextColor),
              onPressed: () => Get.back(),
            ),
          ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      // Profile Header Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: context.glassBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.glassBorder,
                            width: 1,
                          ),
                        ),
                        child: Obx(() {
                          final user = authCtrl.currentUser.value;
                          if (user == null) {
                            return Center(
                              child: Text(
                                'Not logged in',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: context.secondaryTextColor,
                                ),
                              ),
                            );
                          }

                          // Create UserProfile from Firebase user
                          final profile = UserProfile.fromFirebaseUser(user);
                          
                          return Column(
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
                                      color: context.accentColor,
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
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: context.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Email
                              Text(
                                profile.email,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: context.secondaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Provider info
                              if (profile.provider != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getProviderColor(profile.provider!).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _getProviderColor(profile.provider!),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'Signed in with ${_getProviderDisplayName(profile.provider!)}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: _getProviderColor(profile.provider!),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),
                      
                      // Account Actions
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: context.glassBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.glassBorder,
                            width: 1,
                          ),
                        ),
                        child: Obx(() {
                          final user = authCtrl.currentUser.value;
                          final profile = user != null ? UserProfile.fromFirebaseUser(user) : null;
                          final isEmailPasswordUser = profile?.provider == 'password';

                          return Column(
                            children: [
                              _buildActionTile(
                                context: context,
                                icon: Icons.edit,
                                title: 'Edit Profile',
                                subtitle: 'Update your personal information',
                                onTap: () => Get.to(() => const EditProfile()),
                              ),
                              _buildDivider(context),
                              // Only show password change for email/password users
                              if (isEmailPasswordUser)
                                _buildActionTile(
                                  context: context,
                                  icon: Icons.lock,
                                  title: 'Change Password',
                                  subtitle: 'Update your account password',
                                  onTap: () => Get.to(() => const ChangePassword()),
                                ),
                              // Show general security for social users
                              if (!isEmailPasswordUser)
                                _buildActionTile(
                                  context: context,
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
                                ),
                              if (isEmailPasswordUser) _buildDivider(context),
                              _buildActionTile(
                                context: context,
                                icon: Icons.download,
                                title: 'Export Data',
                                subtitle: 'Download your photos and data',
                                onTap: () {
                                  // TODO: Implement data export
                                  Get.snackbar('Coming Soon', 'Data export will be available soon');
                                },
                              ),
                            ],
                          );
                        }),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Security Section
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: context.glassBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.glassBorder,
                            width: 1,
                          ),
                        ),
                        child: Builder(
                          builder: (context) {
                            final advancedController = Get.put(AdvancedSettingsController());
                            final passcodeService = Get.put(PasscodeService());
                            
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Title
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                  child: Text(
                                    'Security',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: context.primaryTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                
                                // Passcode Settings
                                Obx(() => ListTile(
                                  leading: Icon(
                                    Icons.lock,
                                    color: context.primaryTextColor,
                                  ),
                                  title: Text(
                                    'Passcode Lock',
                                    style: TextStyle(
                                      color: context.primaryTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    (passcodeService.isAppPasscodeSet.value || passcodeService.isSlideshowPasscodeSet.value)
                                        ? 'Passcode is set and configured'
                                        : 'Set up passcode protection',
                                    style: TextStyle(
                                      color: context.secondaryTextColor,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (passcodeService.isAppPasscodeSet.value || passcodeService.isSlideshowPasscodeSet.value)
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.chevron_right,
                                        color: context.secondaryTextColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () => Get.to(() => const PasscodeSettingsScreen()),
                                )),
                                
                                // Biometric Authentication
                                Obx(() => ListTile(
                                  leading: Icon(
                                    Icons.fingerprint,
                                    color: context.primaryTextColor,
                                  ),
                                  title: Text(
                                    'Biometric Authentication',
                                    style: TextStyle(
                                      color: context.primaryTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    advancedController.biometricsAvailable.value 
                                        ? (advancedController.faceIdEnabled.value 
                                            ? 'Face ID/Touch ID enabled'
                                            : 'Face ID/Touch ID available')
                                        : 'Not available on this device',
                                    style: TextStyle(
                                      color: context.secondaryTextColor,
                                    ),
                                  ),
                                  trailing: advancedController.biometricsAvailable.value
                                      ? Switch(
                                          value: advancedController.faceIdEnabled.value,
                                          onChanged: advancedController.setFaceIdEnabled,
                                          activeThumbColor: context.accentColor,
                                        )
                                      : null,
                                  onTap: advancedController.biometricsAvailable.value
                                      ? () => advancedController.setFaceIdEnabled(!advancedController.faceIdEnabled.value)
                                      : () {},
                                )),
                              ],
                            );
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Danger Zone
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: context.glassBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.glassBorder,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section Title
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Text(
                                'Account Management',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: context.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                            _buildActionTile(
                              context: context,
                              icon: Icons.logout,
                              title: 'Sign Out',
                              subtitle: 'Sign out of your account',
                              onTap: () => _showLogoutDialog(context, authCtrl),
                              isDestructive: true,
                            ),
                            _buildDivider(context),
                            _buildActionTile(
                              context: context,
                              icon: Icons.delete_forever,
                              title: 'Delete Account',
                              subtitle: 'Permanently delete your account',
                              onTap: () => _showDeleteAccountDialog(context, authCtrl),
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
          ],
        );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : context.accentColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: isDestructive ? Colors.red : context.primaryTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.secondaryTextColor,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: context.secondaryTextColor,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: context.borderColor.withValues(alpha: 0.3),
      indent: 16,
      endIndent: 16,
    );
  }

  Color _getProviderColor(String provider) {
    switch (provider.toLowerCase()) {
      case 'google.com':
      case 'google':
        return Colors.red;
      case 'facebook.com':
      case 'facebook':
        return Colors.blue;
      case 'apple.com':
      case 'apple':
        return Colors.black;
      case 'twitter.com':
      case 'twitter':
        return Colors.lightBlue;
      case 'password':
      case 'email':
        return Colors.orange;
      case 'phone':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getProviderDisplayName(String provider) {
    switch (provider.toLowerCase()) {
      case 'google.com':
      case 'google':
        return 'Google';
      case 'facebook.com':
      case 'facebook':
        return 'Facebook';
      case 'apple.com':
      case 'apple':
        return 'Apple';
      case 'twitter.com':
      case 'twitter':
        return 'Twitter';
      case 'password':
        return 'Email';
      case 'email':
        return 'Email';
      case 'phone':
        return 'Phone';
      default:
        return 'Unknown';
    }
  }

  void _showLogoutDialog(BuildContext context, AuthController authCtrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.surfaceColor,
          title: Text(
            'Sign Out',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: context.primaryTextColor,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.secondaryTextColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(color: context.secondaryTextColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                authCtrl.logout();
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context, AuthController authCtrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.surfaceColor,
          title: const Text(
            'Delete Account',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'This action cannot be undone. All your photos, settings, and data will be permanently deleted.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.secondaryTextColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(color: context.secondaryTextColor),
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
        );
      },
    );
  }
}
