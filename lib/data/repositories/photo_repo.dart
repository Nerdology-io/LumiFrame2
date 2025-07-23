import 'package:get/Get.dart';
import 'package:lumiframe/models/photo.dart';
import 'package:lumiframe/services/media_service.dart';

class PhotoRepo {
  final MediaService _mediaService = Get.find<MediaService>();

  Future<List<Photo>> getPhotos({bool localOnly = false}) async {
    if (localOnly) {
      return await _mediaService.fetchLocalPhotos();
    } else {
      // Fetch from all configured sources (local, Google Photos, Flickr)
      return await _mediaService.fetchAllPhotos();
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