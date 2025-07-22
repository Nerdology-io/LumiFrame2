import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ProfilePictureService extends GetxService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
      return null;
    }
  }

  /// Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      Get.snackbar('Error', 'Failed to take photo: ${e.toString()}');
      return null;
    }
  }

  /// Upload profile picture to Firebase Storage
  Future<String?> uploadProfilePicture(XFile imageFile, String userId) async {
    try {
      final File file = File(imageFile.path);
      final String fileName = 'profile_pictures/$userId.jpg';
      
      // Upload to Firebase Storage
      final TaskSnapshot snapshot = await _storage.ref(fileName).putFile(file);
      
      // Get download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      
      // Update Firebase Auth profile
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePhotoURL(downloadUrl);
        await user.reload();
      }
      
      return downloadUrl;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: ${e.toString()}');
      return null;
    }
  }

  /// Delete profile picture
  Future<bool> deleteProfilePicture(String userId) async {
    try {
      final String fileName = 'profile_pictures/$userId.jpg';
      await _storage.ref(fileName).delete();
      
      // Remove from Firebase Auth profile
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePhotoURL(null);
        await user.reload();
      }
      
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete image: ${e.toString()}');
      return false;
    }
  }

  /// Show image source selection dialog
  Future<XFile?> showImageSourceDialog() async {
    XFile? selectedImage;
    
    await Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Get.back();
                selectedImage = await pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Get.back();
                selectedImage = await pickImageFromCamera();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    
    return selectedImage;
  }
}
