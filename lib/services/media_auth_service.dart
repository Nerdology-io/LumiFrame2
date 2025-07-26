import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import '../widgets/glassmorphism_dialog.dart';
import '../widgets/glassmorphism_loading_dialog.dart';
import '../widgets/glassmorphism_dialogs.dart';

class MediaAuthService extends GetxService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/photoslibrary.readonly',
    ],
  );

  final RxBool _isGooglePhotosConnected = false.obs;
  final RxBool _isDeviceGalleryConnected = false.obs;
  final RxBool _isConnecting = false.obs;
  final RxString _connectionStatus = ''.obs;

  // Getters
  bool get isGooglePhotosConnected => _isGooglePhotosConnected.value;
  bool get isDeviceGalleryConnected => _isDeviceGalleryConnected.value;
  bool get isConnecting => _isConnecting.value;
  String get connectionStatus => _connectionStatus.value;
  
  // Reactive getters for listening to changes
  RxBool get isGooglePhotosConnectedRx => _isGooglePhotosConnected;
  RxBool get isDeviceGalleryConnectedRx => _isDeviceGalleryConnected;
  RxBool get isConnectingRx => _isConnecting;
  RxString get connectionStatusRx => _connectionStatus;

  @override
  void onInit() {
    super.onInit();
    // Only check existing connections, don't auto-request permissions
    _checkExistingConnections();
  }

  // Public method to manually recheck permissions (call when app becomes active)
  Future<void> recheckPermissions() async {
    // For now, just log that we're avoiding automatic permission requests
    // The user should explicitly tap buttons to request permissions
    print('📋 MediaAuthService: Skipping automatic permission recheck on app resume');
  }

  void _checkExistingConnections() {
    // Check if Google Photos was previously connected
    _checkGooglePhotosConnection();
    
    // Check if Device Gallery permissions are granted
    _checkDeviceGalleryPermission();
  }

  Future<void> _checkGooglePhotosConnection() async {
    try {
      final account = await _googleSignIn.signInSilently();
      _isGooglePhotosConnected.value = account != null;
    } catch (e) {
      _isGooglePhotosConnected.value = false;
    }
  }

  Future<void> _checkDeviceGalleryPermission() async {
    // For onboarding, don't auto-connect even if permission is granted
    // This ensures a clean slate during the onboarding experience
    _isDeviceGalleryConnected.value = false;
  }

  Future<bool> connectToGooglePhotos() async {
    try {
      _isConnecting.value = true;
      _connectionStatus.value = 'Connecting to Google Photos...';

      // Show loading dialog
      Get.dialog(
        GlassmorphismLoadingDialog(
          message: _connectionStatus.value,
        ),
        barrierDismissible: false,
      );

      final account = await _googleSignIn.signIn();
      
      if (account != null) {
        _isGooglePhotosConnected.value = true;
        _connectionStatus.value = 'Successfully connected to Google Photos';
        
        // Close loading dialog
        Get.back();
        
        // Show success dialog
        Get.dialog(
          GlassmorphismSuccessDialog(
            title: 'Connected',
            message: 'Successfully connected to ${account.displayName}\'s Google Photos',
          ),
        );
        
        return true;
      } else {
        _connectionStatus.value = 'Connection cancelled';
        Get.back(); // Close loading dialog
        return false;
      }
    } catch (error) {
      _connectionStatus.value = 'Failed to connect: $error';
      Get.back(); // Close loading dialog
      
      // Show error dialog
      Get.dialog(
        GlassmorphismErrorDialog(
          title: 'Connection Failed',
          message: 'Failed to connect to Google Photos: $error',
        ),
      );
      
      return false;
    } finally {
      _isConnecting.value = false;
    }
  }

  Future<bool> connectToDeviceGallery() async {
    try {
      print('🖼️ Device Gallery: Starting connection using PhotoManager...');
      _isConnecting.value = true;
      _connectionStatus.value = 'Requesting gallery access...';
      
      // Use PhotoManager's permission system (same as MediaService)
      final result = await PhotoManager.requestPermissionExtend();
      print('🖼️ Device Gallery: PhotoManager permission result: ${result.name}');
      
      if (result.isAuth) {
        print('🖼️ Device Gallery: Permission granted successfully');
        _isDeviceGalleryConnected.value = true;
        _connectionStatus.value = 'Device Gallery connected';
        return true;
      } else {
        print('🖼️ Device Gallery: Permission denied: ${result.name}');
        
        // Check if it's permanently denied
        if (result == PermissionState.denied) {
          print('🖼️ Device Gallery: Permission permanently denied, showing settings dialog');
          await Get.dialog(
            GlassmorphismConfirmDialog(
              title: 'Permission Required',
              message: 'Photo access is required to connect to your Device Gallery. We\'ll take you to Settings to enable it.',
              confirmText: 'Open Settings',
              cancelText: 'Cancel',
              onConfirm: () async {
                Get.back();
                await openAppSettings();
              },
              onCancel: () {
                Get.back();
              },
            ),
          );
        }
        
        _isDeviceGalleryConnected.value = false;
        _connectionStatus.value = 'Gallery access denied';
        return false;
      }
    } catch (error) {
      print('🖼️ Device Gallery: Error occurred: $error');
      _connectionStatus.value = 'Failed to access gallery: $error';
      _isDeviceGalleryConnected.value = false;
      return false;
    } finally {
      _isConnecting.value = false;
    }
  }

  Future<void> disconnectFromGooglePhotos() async {
    try {
      await _googleSignIn.signOut();
      _isGooglePhotosConnected.value = false;
      _connectionStatus.value = 'Disconnected from Google Photos';
      
      GlassmorphismSnackbar.show(
        message: 'Successfully disconnected from Google Photos',
      );
    } catch (error) {
      GlassmorphismSnackbar.show(
        message: 'Failed to disconnect: $error',
        backgroundColor: Colors.red.withOpacity(0.8),
      );
    }
  }

  Future<void> disconnectFromDeviceGallery() async {
    // Note: We can't revoke permissions programmatically, 
    // but we can update our internal state
    _isDeviceGalleryConnected.value = false;
    _connectionStatus.value = 'Disconnected from Device Gallery';
    
    GlassmorphismSnackbar.show(
      message: 'Device Gallery access removed. You can re-enable it anytime.',
    );
  }

  // Placeholder methods for future media sources
  Future<bool> connectToICloud() async {
    Get.dialog(
      GlassmorphismDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 12),
            Text('Coming Soon'),
          ],
        ),
        content: const Text('iCloud Photos integration will be available in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return false;
  }

  Future<bool> connectToInstagram() async {
    Get.dialog(
      GlassmorphismDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 12),
            Text('Coming Soon'),
          ],
        ),
        content: const Text('Instagram integration will be available in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return false;
  }

  Future<bool> connectToDropbox() async {
    Get.dialog(
      GlassmorphismDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 12),
            Text('Coming Soon'),
          ],
        ),
        content: const Text('Dropbox integration will be available in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return false;
  }

  Future<bool> connectToOneDrive() async {
    Get.dialog(
      GlassmorphismDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 12),
            Text('Coming Soon'),
          ],
        ),
        content: const Text('OneDrive integration will be available in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return false;
  }

  int get connectedSourcesCount {
    int count = 0;
    if (_isGooglePhotosConnected.value) count++;
    if (_isDeviceGalleryConnected.value) count++;
    return count;
  }
}
