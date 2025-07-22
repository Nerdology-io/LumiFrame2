import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../models/user.dart';
import '../../widgets/nav_shell_background_wrapper.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NavShellBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header with title and save button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: _isLoading 
                                ? Colors.grey 
                                : Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Display Name Section
                GlassmorphismSettingsWrapper(
                  title: 'Display Name',
                  horizontalPadding: 8.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Display Name:',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _customDisplayNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your preferred name',
                          hintStyle: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                          filled: true,
                          fillColor: isDark 
                              ? Colors.white.withOpacity(0.05) 
                              : Colors.black.withOpacity(0.03),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark 
                                  ? Colors.white.withOpacity(0.1) 
                                  : Colors.black.withOpacity(0.1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark 
                                  ? Colors.white.withOpacity(0.1) 
                                  : Colors.black.withOpacity(0.1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
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
                          color: isDark ? Colors.white54 : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Account Information (Read-only)
                GlassmorphismSettingsWrapper(
                  title: 'Account Information',
                  horizontalPadding: 8.0,
                  child: Obx(() {
                    final user = authCtrl.currentUser.value;
                    if (user == null) return const SizedBox.shrink();
                    
                    final profile = UserProfile.fromFirebaseUser(user);
                    
                    return Column(
                      children: [
                        _buildReadOnlyField(
                          label: 'Email Address',
                          value: profile.email,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 16),
                        if (profile.phoneNumber != null)
                          _buildReadOnlyField(
                            label: 'Phone Number',
                            value: profile.phoneNumber!,
                            isDark: isDark,
                          ),
                        if (profile.provider != null) ...[
                          const SizedBox(height: 16),
                          _buildReadOnlyField(
                            label: 'Sign-in Method',
                            value: _getProviderDisplayName(profile.provider!),
                            isDark: isDark,
                          ),
                        ],
                      ],
                    );
                  }),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white70 : Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withOpacity(0.03) 
                : Colors.black.withOpacity(0.02),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark 
                  ? Colors.white.withOpacity(0.05) 
                  : Colors.black.withOpacity(0.05),
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white60 : Colors.black54,
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
