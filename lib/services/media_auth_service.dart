import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/glassmorphism_dialog.dart';

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
    _checkExistingConnections();
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
    // For now, assume Device Gallery is available
    // In a production app, you'd check actual permissions here
    _isDeviceGalleryConnected.value = true;
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
      _isConnecting.value = true;
      _connectionStatus.value = 'Requesting gallery access...';

      // For now, we'll use image_picker to test access
      final ImagePicker picker = ImagePicker();
      
      // Show info dialog first
      final bool? shouldProceed = await Get.dialog<bool>(
        GlassmorphismConfirmDialog(
          title: 'Device Gallery Access',
          message: 'LumiFrame needs access to your device gallery to display your photos. Would you like to grant access?',
          confirmText: 'Allow Access',
          cancelText: 'Cancel',
        ),
      );

      if (shouldProceed == true) {
        // Try to pick an image to test gallery access
        try {
          await picker.pickImage(source: ImageSource.gallery);
          
          _isDeviceGalleryConnected.value = true;
          _connectionStatus.value = 'Device Gallery access granted';
          
          // Show success dialog
          Get.dialog(
            GlassmorphismSuccessDialog(
              title: 'Access Granted',
              message: 'Successfully connected to Device Gallery',
            ),
          );
          
          return true;
        } catch (e) {
          // User cancelled or permission denied
          _connectionStatus.value = 'Gallery access denied';
          
          Get.dialog(
            GlassmorphismErrorDialog(
              title: 'Access Required',
              message: 'Gallery access is required to display your photos. You can try again or enable it later in Settings.',
            ),
          );
          
          return false;
        }
      } else {
        _connectionStatus.value = 'Gallery access cancelled';
        return false;
      }
    } catch (error) {
      _connectionStatus.value = 'Failed to access gallery: $error';
      
      Get.dialog(
        GlassmorphismErrorDialog(
          title: 'Access Failed',
          message: 'Failed to access Device Gallery: $error',
        ),
      );
      
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
        title: 'Disconnected',
        message: 'Successfully disconnected from Google Photos',
        icon: Icons.check_circle,
        iconColor: Colors.orange,
      );
    } catch (error) {
      GlassmorphismSnackbar.show(
        title: 'Error',
        message: 'Failed to disconnect: $error',
        icon: Icons.error,
        iconColor: Colors.red,
      );
    }
  }

  Future<void> disconnectFromDeviceGallery() async {
    // Note: We can't revoke permissions programmatically, 
    // but we can update our internal state
    _isDeviceGalleryConnected.value = false;
    _connectionStatus.value = 'Disconnected from Device Gallery';
    
    GlassmorphismSnackbar.show(
      title: 'Disconnected',
      message: 'Device Gallery access removed. You can re-enable it anytime.',
      icon: Icons.check_circle,
      iconColor: Colors.orange,
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
