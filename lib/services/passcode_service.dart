import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

enum PasscodeType { appLaunch, slideshowControl }

class PasscodeService extends GetxService {
  final _box = GetStorage();
  
  // Keys for storage
  static const String _appPasscodeHashKey = 'app_passcode_hash';
  static const String _slideshowPasscodeHashKey = 'slideshow_passcode_hash';
  static const String _appPasscodeEnabledKey = 'app_passcode_enabled';
  static const String _slideshowPasscodeEnabledKey = 'slideshow_passcode_enabled';
  static const String _faceIdEnabledKey = 'face_id_enabled';
  
  // Observable states
  var isAppPasscodeSet = false.obs;
  var isSlideshowPasscodeSet = false.obs;
  var isAppLocked = false.obs;
  var isAppPasscodeEnabled = false.obs;
  var isSlideshowPasscodeEnabled = false.obs;
  var isFaceIdEnabled = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }
  
  void _loadSettings() {
    isAppPasscodeEnabled.value = _box.read(_appPasscodeEnabledKey) ?? false;
    isSlideshowPasscodeEnabled.value = _box.read(_slideshowPasscodeEnabledKey) ?? false;
    isAppPasscodeSet.value = _box.read(_appPasscodeHashKey) != null;
    isSlideshowPasscodeSet.value = _box.read(_slideshowPasscodeHashKey) != null;
    isFaceIdEnabled.value = _box.read(_faceIdEnabledKey) ?? false;
    
    // App is locked if app passcode is enabled and set
    if (isAppPasscodeEnabled.value && isAppPasscodeSet.value) {
      isAppLocked.value = true;
    }
  }
  
  /// Hash a passcode using SHA-256
  String _hashPasscode(String passcode) {
    final bytes = utf8.encode(passcode);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Get the storage key for a specific passcode type
  String _getPasscodeHashKey(PasscodeType type) {
    switch (type) {
      case PasscodeType.appLaunch:
        return _appPasscodeHashKey;
      case PasscodeType.slideshowControl:
        return _slideshowPasscodeHashKey;
    }
  }
  
  /// Set a new passcode for a specific type
  bool setPasscode(String passcode, PasscodeType type) {
    if (passcode.length < 4) return false;
    
    final hashedPasscode = _hashPasscode(passcode);
    final key = _getPasscodeHashKey(type);
    _box.write(key, hashedPasscode);
    
    switch (type) {
      case PasscodeType.appLaunch:
        isAppPasscodeSet.value = true;
        break;
      case PasscodeType.slideshowControl:
        isSlideshowPasscodeSet.value = true;
        break;
    }
    
    return true;
  }
  
  /// Verify if the provided passcode is correct for a specific type
  bool verifyPasscode(String passcode, PasscodeType type) {
    final key = _getPasscodeHashKey(type);
    final storedHash = _box.read(key);
    if (storedHash == null) return false;
    
    final inputHash = _hashPasscode(passcode);
    return inputHash == storedHash;
  }
  
  /// Enable/disable passcode protection for app launch
  void setAppPasscodeEnabled(bool enabled) {
    isAppPasscodeEnabled.value = enabled;
    _box.write(_appPasscodeEnabledKey, enabled);
    
    // If enabling and passcode is set, lock the app
    if (enabled && isAppPasscodeSet.value) {
      isAppLocked.value = true;
    } else if (!enabled) {
      isAppLocked.value = false;
    }
  }
  
  /// Enable/disable passcode protection for slideshow
  void setSlideshowPasscodeEnabled(bool enabled) {
    isSlideshowPasscodeEnabled.value = enabled;
    _box.write(_slideshowPasscodeEnabledKey, enabled);
  }
  
  /// Unlock the app after successful passcode entry
  void unlockApp() {
    isAppLocked.value = false;
  }
  
  /// Lock the app (called when app goes to background)
  void lockApp() {
    if (isAppPasscodeEnabled.value && isAppPasscodeSet.value) {
      isAppLocked.value = true;
    }
  }
  
  /// Remove passcode for a specific type
  void removePasscode(PasscodeType type) {
    final key = _getPasscodeHashKey(type);
    _box.remove(key);
    
    switch (type) {
      case PasscodeType.appLaunch:
        isAppPasscodeSet.value = false;
        isAppPasscodeEnabled.value = false;
        isAppLocked.value = false;
        _box.write(_appPasscodeEnabledKey, false);
        break;
      case PasscodeType.slideshowControl:
        isSlideshowPasscodeSet.value = false;
        isSlideshowPasscodeEnabled.value = false;
        _box.write(_slideshowPasscodeEnabledKey, false);
        break;
    }
  }
  
  /// Remove all passcodes
  void removeAllPasscodes() {
    removePasscode(PasscodeType.appLaunch);
    removePasscode(PasscodeType.slideshowControl);
  }
  
  /// Check if passcode is required for app launch
  bool get requiresPasscodeForApp => isAppPasscodeEnabled.value && isAppPasscodeSet.value;
  
  /// Check if passcode is required for slideshow control
  bool get requiresPasscodeForSlideshow => isSlideshowPasscodeEnabled.value && isSlideshowPasscodeSet.value;
  
  /// Check if passcode is set for a specific type
  bool isPasscodeSet(PasscodeType type) {
    switch (type) {
      case PasscodeType.appLaunch:
        return isAppPasscodeSet.value;
      case PasscodeType.slideshowControl:
        return isSlideshowPasscodeSet.value;
    }
  }
  
  /// Check if passcode is enabled for a specific type
  bool isPasscodeEnabled(PasscodeType type) {
    switch (type) {
      case PasscodeType.appLaunch:
        return isAppPasscodeEnabled.value;
      case PasscodeType.slideshowControl:
        return isSlideshowPasscodeEnabled.value;
    }
  }
  
  /// Set Face ID enabled state
  void setFaceIdEnabled(bool enabled) {
    isFaceIdEnabled.value = enabled;
    _box.write(_faceIdEnabledKey, enabled);
  }
  
  /// Set passcode enabled state for a specific type
  void setPasscodeEnabled(PasscodeType type, bool enabled) {
    switch (type) {
      case PasscodeType.appLaunch:
        isAppPasscodeEnabled.value = enabled;
        _box.write(_appPasscodeEnabledKey, enabled);
        break;
      case PasscodeType.slideshowControl:
        isSlideshowPasscodeEnabled.value = enabled;
        _box.write(_slideshowPasscodeEnabledKey, enabled);
        break;
    }
  }
}
