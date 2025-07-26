import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../../services/passcode_service.dart';
import '../../theme/glassmorphism_settings_wrapper.dart';
import '../../widgets/glassmorphism_dialog.dart';
import '../../theme/glassmorphism_container.dart';
import '../../widgets/nav_shell_background_wrapper.dart';
import 'passcode_screen.dart';

class PasscodeSettingsScreen extends StatefulWidget {
  const PasscodeSettingsScreen({super.key});

  @override
  State<PasscodeSettingsScreen> createState() => _PasscodeSettingsScreenState();
}

class _PasscodeSettingsScreenState extends State<PasscodeSettingsScreen> {
  final PasscodeService _passcodeService = Get.find<PasscodeService>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _biometricsAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricsAvailability();
  }

  Future<void> _checkBiometricsAvailability() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      setState(() {
        _biometricsAvailable = isAvailable && isDeviceSupported;
      });
    } catch (e) {
      setState(() {
        _biometricsAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NavShellBackgroundWrapper(
        title: 'Passcode Settings',
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 12),

                // App Launch Passcode Section
                GlassmorphismSettingsWrapper(
                  title: 'App Launch Protection',
                  horizontalPadding: 8.0,
                  child: Obx(() {
                    final hasPasscode = _passcodeService.isAppPasscodeSet.value;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status indicator
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: hasPasscode 
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: hasPasscode 
                                  ? Colors.green.withOpacity(0.3)
                                  : Colors.orange.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                hasPasscode ? Icons.check_circle : Icons.warning,
                                color: hasPasscode ? Colors.green : Colors.orange,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                hasPasscode 
                                    ? 'App launch passcode is active'
                                    : 'No app launch passcode set',
                                style: TextStyle(
                                  color: hasPasscode ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Setup/Change passcode button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _setupPasscode(context, PasscodeType.appLaunch),
                            icon: Icon(hasPasscode ? Icons.edit : Icons.lock),
                            label: Text(hasPasscode ? 'Change App Launch Passcode' : 'Set App Launch Passcode'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        // Remove passcode button (only if passcode exists)
                        if (hasPasscode) ...[
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              onPressed: () => _removePasscode(context, PasscodeType.appLaunch),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text(
                                'Remove App Launch Passcode',
                                style: TextStyle(color: Colors.red),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.red, width: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Slideshow Control Passcode Section
                GlassmorphismSettingsWrapper(
                  title: 'Slideshow Control Protection',
                  horizontalPadding: 8.0,
                  child: Obx(() {
                    final hasPasscode = _passcodeService.isSlideshowPasscodeSet.value;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status indicator
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: hasPasscode 
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: hasPasscode 
                                  ? Colors.green.withOpacity(0.3)
                                  : Colors.orange.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                hasPasscode ? Icons.check_circle : Icons.warning,
                                color: hasPasscode ? Colors.green : Colors.orange,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                hasPasscode 
                                    ? 'Slideshow control passcode is active'
                                    : 'No slideshow control passcode set',
                                style: TextStyle(
                                  color: hasPasscode ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Setup/Change passcode button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _setupPasscode(context, PasscodeType.slideshowControl),
                            icon: Icon(hasPasscode ? Icons.edit : Icons.slideshow),
                            label: Text(hasPasscode ? 'Change Slideshow Control Passcode' : 'Set Slideshow Control Passcode'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        // Remove passcode button (only if passcode exists)
                        if (hasPasscode) ...[
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              onPressed: () => _removePasscode(context, PasscodeType.slideshowControl),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text(
                                'Remove Slideshow Control Passcode',
                                style: TextStyle(color: Colors.red),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.red, width: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Face ID Section (if available)
                if (_biometricsAvailable) ...[
                  GlassmorphismSettingsWrapper(
                    title: 'Biometric Authentication',
                    horizontalPadding: 8.0,
                    child: Column(
                      children: [
                        Obx(() => SwitchListTile(
                          title: Text(
                            'Face ID / Touch ID',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            'Use biometric authentication for faster access',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          value: _passcodeService.isFaceIdEnabled.value,
                          onChanged: (value) {
                            _passcodeService.setFaceIdEnabled(value);
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                          contentPadding: EdgeInsets.zero,
                        )),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setupPasscode(BuildContext context, PasscodeType type) {
    final hasPasscode = type == PasscodeType.appLaunch 
        ? _passcodeService.isAppPasscodeSet.value
        : _passcodeService.isSlideshowPasscodeSet.value;

    if (hasPasscode) {
      // Verify current passcode first
      Get.to(() => PasscodeScreen(
        mode: PasscodeMode.verify,
        passcodeType: type,
        onSuccess: () {
          // Navigate to setup new passcode
          Get.to(() => PasscodeScreen(
            mode: PasscodeMode.setup,
            passcodeType: type,
            onSuccess: () {
              // Show success message first
              debugPrint('Passcode update success callback called');
              Get.snackbar(
                'Success',
                'Passcode updated successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
              );
              // Wait longer before navigation to ensure snackbar appears
              Future.delayed(const Duration(milliseconds: 500), () {
                if (Get.isRegistered<NavigatorState>()) {
                  Get.back(); // Close setup screen
                  Get.back(); // Close verify screen
                }
              });
            },
          ));
        },
      ));
    } else {
      // No existing passcode, go straight to setup
      Get.to(() => PasscodeScreen(
        mode: PasscodeMode.setup,
        passcodeType: type,
        onSuccess: () {
          // Show success message first
          debugPrint('Passcode setup success callback called');
          Get.snackbar(
            'Success',
            'Passcode set successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          // Wait longer before navigation to ensure snackbar appears
          Future.delayed(const Duration(milliseconds: 500), () {
            if (Get.isRegistered<NavigatorState>()) {
              Get.back(); // Close setup screen
            }
          });
        },
      ));
    }
  }

  void _removePasscode(BuildContext context, PasscodeType type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Show confirmation dialog
    Get.dialog(
      GlassmorphismDialog(
        title: Text('Remove Passcode'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to remove the ${type == PasscodeType.appLaunch ? 'app launch' : 'slideshow control'} passcode? This will disable protection for this feature.',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.8),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GlassmorphismContainer.light(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.red.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Get.back();
                          // Verify current passcode before removal
                          Get.to(() => PasscodeScreen(
                            mode: PasscodeMode.verify,
                            passcodeType: type,
                            onSuccess: () {
                              debugPrint('Passcode remove success callback called');
                              _passcodeService.removePasscode(type);
                              // Show success message first
                              Get.snackbar(
                                'Success',
                                'Passcode removed successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                              );
                              // Wait longer before navigation to ensure snackbar appears
                              Future.delayed(const Duration(milliseconds: 500), () {
                                if (Get.isRegistered<NavigatorState>()) {
                                  Get.back(); // Close verify screen
                                }
                              });
                            },
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Center(
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
