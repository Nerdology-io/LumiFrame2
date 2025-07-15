import 'package:get/Get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lumiframe/models/photo.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:lumiframe/services/firebase_service.dart';

class MediaService extends GetxService {
  final ImagePicker _picker = ImagePicker();

  Future<List<Photo>> fetchLocalPhotos() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      final albums = await PhotoManager.getAssetPathList(onlyAll: true);
      if (albums.isNotEmpty) {
        final assets = await albums[0].getAssetListPaged(page: 0, size: 100);
        return await Future.wait(assets.map((asset) async => Photo(
          id: asset.id,
          url: (await asset.file)?.path ?? '',
          isVideo: asset.type == AssetType.video,
          dateAdded: asset.createDateTime,
        )));
      }
    }
    return [];
  }

  Future<String?> uploadMedia(String path, String fileName) async {
    final firebaseService = Get.find<FirebaseService>();
    return await firebaseService.uploadMedia(path, fileName);
  }

  Future<Photo?> pickFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      return Photo(
        id: DateTime.now().toString(),
        url: picked.path,
        dateAdded: DateTime.now(),
      );
    }
    return null;
  }

  // Add integrations for Google Photos, Flickr, etc.
}