import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/theme_extensions.dart';
import '../../theme/backgrounds/dark_blur_background.dart';
import '../../theme/backgrounds/light_blur_background.dart';
import '../../theme/buttons/glassmorphism_auth_input.dart';
import '../../models/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _customDisplayNameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final authCtrl = Get.find<AuthController>();
    final user = authCtrl.currentUser.value;
    
    _customDisplayNameController = TextEditingController(
      text: user?.displayName ?? ''
    );
  }

  @override
  void dispose() {
    _customDisplayNameController.dispose();
    super.dispose();
  }

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
              'Edit Profile',
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                
                // Display Name Section
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Display Name',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: context.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Display Name:',
                        style: TextStyle(
                          fontSize: 14,
                          color: context.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _customDisplayNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your preferred name',
                          hintStyle: TextStyle(
                            color: context.secondaryTextColor.withValues(alpha: 0.6),
                          ),
                          filled: true,
                          fillColor: context.glassBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: context.glassBorder,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: context.glassBorder,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: context.accentColor,
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: context.primaryTextColor,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Display name is required';
                          }
                          if (value.trim().length > 50) {
                            return 'Name must be 50 characters or less';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This name will be displayed throughout the app.',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Save Button
                      GlassmorphismAuthButton(
                        text: 'Save Changes',
                        onPressed: _saveProfile,
                        isLoading: _isLoading,
                        margin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Account Information (Read-only)
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Information',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: context.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        final user = authCtrl.currentUser.value;
                        if (user == null) return const SizedBox.shrink();
                    
                    final profile = UserProfile.fromFirebaseUser(user);
                    
                        return Column(
                          children: [
                            _buildReadOnlyField(
                              label: 'Email Address',
                              value: profile.email,
                            ),
                            const SizedBox(height: 16),
                            if (profile.phoneNumber != null)
                              _buildReadOnlyField(
                                label: 'Phone Number',
                                value: profile.phoneNumber!,
                              ),
                            if (profile.provider != null) ...[
                              const SizedBox(height: 16),
                              _buildReadOnlyField(
                                label: 'Sign-in Method',
                                value: _getProviderDisplayName(profile.provider!),
                              ),
                            ],
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: context.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.glassBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.glassBorder,
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: context.secondaryTextColor,
            ),
          ),
        ),
      ],
    );
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
        return 'Account';
    }
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final authCtrl = Get.find<AuthController>();
      final user = authCtrl.currentUser.value;
      
      if (user != null) {
        final newName = _customDisplayNameController.text.trim();
        
        await user.updateDisplayName(newName);
        await user.reload();
        authCtrl.currentUser.refresh(); // Trigger UI update
        
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: \${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
