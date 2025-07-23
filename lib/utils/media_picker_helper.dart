import 'package:get/get.dart';
import '../screens/media_picker_screen.dart';
import '../models/photo.dart';

class MediaPickerHelper {
  /// Opens the unified media picker screen
  /// Returns a list of selected photos when user taps "Done"
  static Future<List<Photo>?> pickMedia({
    bool allowMultiple = true,
    bool showVideos = true,
    bool showPhotos = true,
  }) async {
    final result = await Get.to(() => const MediaPickerScreen());
    
    if (result != null && result is List<Photo>) {
      return result;
    }
    
    return null;
  }
  
  /// Quick pick from local photos only
  static Future<List<Photo>?> pickLocalPhotos({
    bool allowMultiple = true,
  }) async {
    // Navigate directly to local photos
    final result = await Get.to(() => const MediaPickerScreen());
    return result as List<Photo>?;
  }
  
  /// Quick pick from Google Photos only (requires authentication)
  static Future<List<Photo>?> pickGooglePhotos({
    bool allowMultiple = true,
  }) async {
    // Navigate directly to Google Photos
    final result = await Get.to(() => const MediaPickerScreen());
    return result as List<Photo>?;
  }
}
