import 'package:get/Get.dart';
import 'package:lumiframe/models/photo.dart';
import 'package:lumiframe/services/media_service.dart';
import 'package:lumiframe/services/firebase_service.dart';

class PhotoRepo {
  final MediaService _mediaService = Get.find<MediaService>();
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  Future<List<Photo>> getPhotos({bool localOnly = false}) async {
    if (localOnly) {
      return await _mediaService.fetchLocalPhotos();
    } else {
      if (_firebaseService.currentUser != null) {
        // Example: Fetch from Firestore/Storage
        // For now, fallback to local
        return await _mediaService.fetchLocalPhotos();
      }
      return await _mediaService.fetchLocalPhotos(); // Fallback to local
    }
  }

  Future<Photo?> uploadPhoto(String path) async {
    final fileName = path.split('/').last;
    final url = await _mediaService.uploadMedia(path, fileName);
    if (url != null) {
      return Photo(id: url, url: url, dateAdded: DateTime.now());
    }
    return null;
  }

  // Add methods for Google Photos, Flickr, etc.
}