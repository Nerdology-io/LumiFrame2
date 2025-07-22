import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/passcode_service.dart';
import '../../widgets/nav_shell_background_wrapper.dart';

enum PasscodeMode { appUnlock, slideshowControl, setup, verify }

class PasscodeScreen extends StatefulWidget {
  final PasscodeMode mode;
  final PasscodeType? passcodeType; // For setup and verify modes
  final String? title;
  final String? subtitle;
  final VoidCallback? onSuccess;
  final VoidCallback? onCancel;

  const PasscodeScreen({
    super.key,
    required this.mode,
    this.passcodeType,
    this.title,
    this.subtitle,
    this.onSuccess,
    this.onCancel,
  });

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> with TickerProviderStateMixin {
  final PasscodeService _passcodeService = Get.find<PasscodeService>();
  String _passcode = '';
  String? _firstPasscode; // For setup mode
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    
    // Try biometric authentication for unlock modes
    _tryBiometricAuthentication();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _tryBiometricAuthentication() async {
    // Only try biometrics for unlock modes, not setup or verify
    if (widget.mode != PasscodeMode.appUnlock && widget.mode != PasscodeMode.slideshowControl) {
      return;
    }
    
    // Don't try biometrics if Face ID is not enabled
    if (!_passcodeService.isFaceIdEnabled.value) {
      return;
    }
    
    try {
      bool authenticated = false;
      
      if (widget.mode == PasscodeMode.appUnlock) {
        authenticated = await _passcodeService.authenticateAppLaunchWithBiometrics();
      } else if (widget.mode == PasscodeMode.slideshowControl) {
        authenticated = await _passcodeService.authenticateSlideshowWithBiometrics();
      }
      
      if (authenticated) {
        // Biometric authentication successful
        if (widget.mode == PasscodeMode.appUnlock) {
          _passcodeService.unlockApp();
        }
        widget.onSuccess?.call();
        Get.back(result: true);
      }
    } catch (e) {
      // Biometric authentication failed or was cancelled
      // Just continue with passcode entry
      print('Biometric authentication failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NavShellBackgroundWrapper(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate available height and adjust spacing
                final availableHeight = constraints.maxHeight;
                final isCompactHeight = availableHeight < 600;
                
                return Column(
                  children: [
                    // Minimal top spacing
                    SizedBox(height: isCompactHeight ? 8 : 16),
                    
                    // Header
                    _buildHeader(isDark, isCompactHeight),
                    
                    // Flexible spacer that adapts to available space - reduced
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _shakeAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(_shakeAnimation.value, 0),
                              child: _buildPasscodeDots(isDark),
                            );
                          },
                        ),
                      ),
                    ),
                    
                    // Number pad - takes more space
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: _buildNumberPad(isDark, isCompactHeight),
                      ),
                    ),
                    
                    // Cancel button (only for certain modes) - minimal bottom spacing
                    if (widget.mode != PasscodeMode.appUnlock && widget.onCancel != null)
                      Padding(
                        padding: EdgeInsets.only(top: isCompactHeight ? 8 : 16),
                        child: TextButton(
                          onPressed: widget.onCancel,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    else
                      // Minimal bottom spacer when no cancel button
                      SizedBox(height: isCompactHeight ? 8 : 16),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark, [bool isCompactHeight = false]) {
    String title;
    String subtitle;
    IconData icon;

    switch (widget.mode) {
      case PasscodeMode.appUnlock:
        title = 'Enter App Passcode';
        subtitle = 'Enter your passcode to unlock LumiFrame';
        icon = Icons.lock;
        break;
      case PasscodeMode.slideshowControl:
        title = 'Protected Slideshow';
        subtitle = 'Enter passcode to control slideshow';
        icon = Icons.security;
        break;
      case PasscodeMode.setup:
        if (widget.passcodeType == PasscodeType.appLaunch) {
          title = _firstPasscode == null ? 'Set App Launch Passcode' : 'Confirm App Launch Passcode';
          subtitle = _firstPasscode == null 
              ? 'Create a 4-digit passcode for app access'
              : 'Enter your app launch passcode again';
        } else {
          title = _firstPasscode == null ? 'Set Slideshow Passcode' : 'Confirm Slideshow Passcode';
          subtitle = _firstPasscode == null 
              ? 'Create a 4-digit passcode for slideshow'
              : 'Enter your slideshow control passcode again';
        }
        icon = Icons.lock_outline;
        break;
      case PasscodeMode.verify:
        if (widget.passcodeType == PasscodeType.appLaunch) {
          title = 'Verify App Launch Passcode';
          subtitle = 'Enter your current app launch passcode';
        } else {
          title = 'Verify Slideshow Passcode';
          subtitle = 'Enter your current slideshow passcode';
        }
        icon = Icons.verified_user;
        break;
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isCompactHeight ? 16 : 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: isCompactHeight ? 40 : 48,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: isCompactHeight ? 16 : 24),
        Text(
          widget.title ?? title,
          style: TextStyle(
            fontSize: isCompactHeight ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          widget.subtitle ?? subtitle,
          style: TextStyle(
            fontSize: isCompactHeight ? 14 : 16,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPasscodeDots(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        bool isFilled = index < _passcode.length;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled 
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            border: Border.all(
              color: isFilled 
                  ? Theme.of(context).colorScheme.primary
                  : (isDark ? Colors.white38 : Colors.black38),
              width: 2,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNumberPad(bool isDark, [bool isCompactHeight = false]) {
    final buttonSize = isCompactHeight ? 44.0 : 64.0;
    final verticalPadding = isCompactHeight ? 1.0 : 6.0;
    
    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rows 1-3
          for (int row = 0; row < 3; row++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int col = 1; col <= 3; col++)
                    _buildNumberButton(row * 3 + col, isDark, buttonSize),
                ],
              ),
            ),
          // Bottom row with biometric (if available), 0, and delete
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _shouldShowBiometricButton() 
                    ? _buildBiometricButton(isDark, buttonSize)
                    : SizedBox(width: buttonSize), // Empty space
                _buildNumberButton(0, isDark, buttonSize),
                _buildDeleteButton(isDark, buttonSize),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(int number, bool isDark, [double size = 72.0]) {
    return GestureDetector(
      onTap: () => _onNumberPressed(number),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark 
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          border: Border.all(
            color: isDark 
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
          ),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: size > 50 ? 18 : 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(bool isDark, [double size = 72.0]) {
    return GestureDetector(
      onTap: _onDeletePressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark 
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          border: Border.all(
            color: isDark 
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            color: isDark ? Colors.white70 : Colors.black54,
            size: size > 50 ? 18 : 12,
          ),
        ),
      ),
    );
  }

  bool _shouldShowBiometricButton() {
    // Show biometric button only for unlock modes and when Face ID is enabled
    return (widget.mode == PasscodeMode.appUnlock || widget.mode == PasscodeMode.slideshowControl) &&
           _passcodeService.isFaceIdEnabled.value;
  }

  Widget _buildBiometricButton(bool isDark, [double size = 72.0]) {
    return GestureDetector(
      onTap: () => _tryBiometricAuthentication(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark 
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          border: Border.all(
            color: isDark 
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.fingerprint,
            color: Theme.of(context).primaryColor,
            size: size > 50 ? 22 : 16,
          ),
        ),
      ),
    );
  }

  void _onNumberPressed(int number) {
    if (_passcode.length < 4) {
      setState(() {
        _passcode += number.toString();
      });

      if (_passcode.length == 4) {
        _handlePasscodeComplete();
      }
    }
  }

  void _onDeletePressed() {
    if (_passcode.isNotEmpty) {
      setState(() {
        _passcode = _passcode.substring(0, _passcode.length - 1);
      });
    }
  }

  void _handlePasscodeComplete() {
    switch (widget.mode) {
      case PasscodeMode.setup:
        _handleSetupMode();
        break;
      case PasscodeMode.appUnlock:
      case PasscodeMode.slideshowControl:
      case PasscodeMode.verify:
        _handleVerificationMode();
        break;
    }
  }

  void _handleSetupMode() {
    if (_firstPasscode == null) {
      // First passcode entry
      setState(() {
        _firstPasscode = _passcode;
        _passcode = '';
      });
    } else {
      // Confirmation entry
      if (_firstPasscode == _passcode) {
        // Passcodes match, save it and auto-complete
        if (widget.passcodeType != null) {
          _passcodeService.setPasscode(_passcode, widget.passcodeType!);
        } else {
          // For backward compatibility
          _passcodeService.setPasscode(_passcode, PasscodeType.appLaunch);
        }
        
        // Call success callback first (this handles navigation)
        widget.onSuccess?.call();
        
        // If no success callback provided, navigate back automatically
        if (widget.onSuccess == null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              Get.back(result: true);
            }
          });
        }
      } else {
        // Passcodes don't match
        _shakeAndReset();
        Get.snackbar(
          'Error',
          'Passcodes do not match. Try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        setState(() {
          _firstPasscode = null;
          _passcode = '';
        });
      }
    }
  }

  void _handleVerificationMode() {
    bool isValid = false;
    
    // Determine which passcode to verify based on mode
    if (widget.mode == PasscodeMode.appUnlock) {
      isValid = _passcodeService.verifyPasscode(_passcode, PasscodeType.appLaunch);
    } else if (widget.mode == PasscodeMode.slideshowControl) {
      isValid = _passcodeService.verifyPasscode(_passcode, PasscodeType.slideshowControl);
    } else if (widget.passcodeType != null) {
      // For verify mode with specific type
      isValid = _passcodeService.verifyPasscode(_passcode, widget.passcodeType!);
    } else {
      // For backward compatibility
      isValid = _passcodeService.verifyPasscode(_passcode, PasscodeType.appLaunch);
    }
    
    if (isValid) {
      // Correct passcode
      if (widget.mode == PasscodeMode.appUnlock) {
        _passcodeService.unlockApp();
      }
      
      // Call success callback first (this handles navigation for most cases)
      widget.onSuccess?.call();
      
      // For app unlock mode, always navigate back automatically
      // For other modes, only navigate if no success callback provided
      if (widget.mode == PasscodeMode.appUnlock || widget.onSuccess == null) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            Get.back(result: true);
          }
        });
      }
    } else {
      // Incorrect passcode
      _shakeAndReset();
      Get.snackbar(
        'Incorrect Passcode',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _shakeAndReset() {
    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });
    
    setState(() {
      _passcode = '';
    });
  }
}
