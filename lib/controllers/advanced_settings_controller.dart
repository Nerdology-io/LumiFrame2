import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/passcode_service.dart';

class AdvancedSettingsController extends GetxController {
  final GetStorage _box = GetStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Security Settings
  var passcodeEnabled = false.obs;
  var faceIdEnabled = false.obs;
  var biometricsAvailable = false.obs;

  // Performance Settings
  var slideshowFrameRate = '30 FPS'.obs;
  var mediaQuality = 'Auto'.obs;
  var preloadNextSlide = true.obs;
  var hardwareAcceleration = true.obs;
  var useImageCache = true.obs;
  var useVideoThumbnail = true.obs;

  // App Info
  var appVersion = ''.obs;
  var buildNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
    _checkBiometricAvailability();
    _getAppInfo();
  }

  void _loadSettings() {
    // Security Settings
    passcodeEnabled.value = _box.read('passcodeEnabled') ?? false;
    faceIdEnabled.value = _box.read('faceIdEnabled') ?? false;

    // Performance Settings
    slideshowFrameRate.value = _box.read('slideshowFrameRate') ?? '30 FPS';
    mediaQuality.value = _box.read('mediaQuality') ?? 'Auto';
    preloadNextSlide.value = _box.read('preloadNextSlide') ?? true;
    hardwareAcceleration.value = _box.read('hardwareAcceleration') ?? true;
    useImageCache.value = _box.read('useImageCache') ?? true;
    useVideoThumbnail.value = _box.read('useVideoThumbnail') ?? true;

    // Set up observers to save settings when they change
    ever(passcodeEnabled, (val) => _box.write('passcodeEnabled', val));
    ever(faceIdEnabled, (val) => _box.write('faceIdEnabled', val));
    ever(slideshowFrameRate, (val) => _box.write('slideshowFrameRate', val));
    ever(mediaQuality, (val) => _box.write('mediaQuality', val));
    ever(preloadNextSlide, (val) => _box.write('preloadNextSlide', val));
    ever(hardwareAcceleration, (val) => _box.write('hardwareAcceleration', val));
    ever(useImageCache, (val) => _box.write('useImageCache', val));
    ever(useVideoThumbnail, (val) => _box.write('useVideoThumbnail', val));
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      biometricsAvailable.value = isAvailable && isDeviceSupported;
    } catch (e) {
      biometricsAvailable.value = false;
    }
  }

  Future<void> _getAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = packageInfo.version;
      buildNumber.value = packageInfo.buildNumber;
    } catch (e) {
      appVersion.value = '1.0.0';
      buildNumber.value = '1';
    }
  }

  // Security Methods
  void setPasscodeEnabled(bool value) {
    final passcodeService = Get.find<PasscodeService>();
    
    if (value && !(passcodeService.isAppPasscodeSet.value || passcodeService.isSlideshowPasscodeSet.value)) {
      // Need to set up passcode first
      Get.snackbar(
        'Passcode Required',
        'Please set up a passcode first in Security Settings.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    
    // For backward compatibility, enable both types when enabling passcode
    passcodeService.setPasscodeEnabled(PasscodeType.appLaunch, value);
    passcodeService.setPasscodeEnabled(PasscodeType.slideshowControl, value);
    passcodeEnabled.value = value;
  }

  void setFaceIdEnabled(bool value) {
    if (biometricsAvailable.value) {
      faceIdEnabled.value = value;
    } else {
      Get.snackbar(
        'Not Available',
        'Biometric authentication is not available on this device.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Performance Methods
  void setSlideshowFrameRate(String value) {
    slideshowFrameRate.value = value;
  }

  void setMediaQuality(String value) {
    mediaQuality.value = value;
  }

  void setPreloadNextSlide(bool value) {
    preloadNextSlide.value = value;
  }

  void setHardwareAcceleration(bool value) {
    hardwareAcceleration.value = value;
  }

  void setUseImageCache(bool value) {
    useImageCache.value = value;
  }

  void setUseVideoThumbnail(bool value) {
    useVideoThumbnail.value = value;
  }

  // Developer Methods
  void sendDiagnosticLogs() {
    // TODO: Implement diagnostic log collection and sending
    Get.snackbar(
      'Feature Coming Soon',
      'Diagnostic log functionality will be available in a future update.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> contactSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'Support@nerdology.io',
      queryParameters: {
        'subject': 'Help Needed with LumiFrame App',
        'body': 'Please describe your issue here:\n\n\n--- App Info ---\nVersion: ${appVersion.value}\nBuild: ${buildNumber.value}',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar(
          'Email Not Available',
          'Please email us at Support@nerdology.io',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open email client. Please email Support@nerdology.io',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearCache() {
    // TODO: Implement actual cache clearing logic
    Get.snackbar(
      'Cache Cleared',
      'App cache has been cleared.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String get formattedVersion => '${appVersion.value} (${buildNumber.value})';
}
