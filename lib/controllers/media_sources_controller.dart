import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/media_service.dart';

class MediaSourcesController extends GetxController {
  final GetStorage _box = GetStorage();
  final MediaService _mediaService = Get.find<MediaService>();

  // Source enablement
  var localStorageEnabled = true.obs;
  var googlePhotosEnabled = false.obs;
  var flickrEnabled = false.obs;
  var autoSyncEnabled = true.obs;

  // Authentication status
  var googlePhotosAuthenticated = false.obs;
  var flickrAuthenticated = false.obs;

  // Sync status
  var isSyncing = false.obs;
  var lastSyncTime = Rx<DateTime?>(null);
  var syncProgress = 0.0.obs;
  var syncStatus = ''.obs;

  // Media counts
  var localPhotoCount = 0.obs;
  var googlePhotosCount = 0.obs;
  var flickrPhotoCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
    _checkAuthenticationStatus();
    _updateMediaCounts();
  }

  void _loadSettings() {
    localStorageEnabled.value = _box.read('localStorageEnabled') ?? true;
    googlePhotosEnabled.value = _box.read('googlePhotosEnabled') ?? false;
    flickrEnabled.value = _box.read('flickrEnabled') ?? false;
    autoSyncEnabled.value = _box.read('autoSyncEnabled') ?? true;
    
    final lastSyncString = _box.read('lastSyncTime');
    if (lastSyncString != null) {
      lastSyncTime.value = DateTime.tryParse(lastSyncString);
    }

    // Set up observers to save settings when they change
    ever(localStorageEnabled, (val) => _box.write('localStorageEnabled', val));
    ever(googlePhotosEnabled, (val) => _box.write('googlePhotosEnabled', val));
    ever(flickrEnabled, (val) => _box.write('flickrEnabled', val));
    ever(autoSyncEnabled, (val) => _box.write('autoSyncEnabled', val));
    ever(lastSyncTime, (val) => _box.write('lastSyncTime', val?.toIso8601String()));
  }

  Future<void> _checkAuthenticationStatus() async {
    googlePhotosAuthenticated.value = _mediaService.isGooglePhotosAuthenticated();
    flickrAuthenticated.value = _mediaService.isFlickrAuthenticated();
  }

  Future<void> _updateMediaCounts() async {
    if (localStorageEnabled.value) {
      final localPhotos = await _mediaService.fetchLocalPhotos();
      localPhotoCount.value = localPhotos.length;
    }
    
    if (googlePhotosEnabled.value && googlePhotosAuthenticated.value) {
      final googlePhotos = await _mediaService.fetchGooglePhotos();
      googlePhotosCount.value = googlePhotos.length;
    }
    
    if (flickrEnabled.value && flickrAuthenticated.value) {
      final flickrPhotos = await _mediaService.fetchFlickrPhotos();
      flickrPhotoCount.value = flickrPhotos.length;
    }
  }

  // Settings methods
  void setLocalStorageEnabled(bool value) {
    localStorageEnabled.value = value;
    if (value) _updateMediaCounts();
  }

  void setGooglePhotosEnabled(bool value) async {
    if (value && !googlePhotosAuthenticated.value) {
      final authenticated = await authenticateGooglePhotos();
      if (!authenticated) return;
    }
    googlePhotosEnabled.value = value;
    if (value) _updateMediaCounts();
  }

  void setFlickrEnabled(bool value) async {
    if (value && !flickrAuthenticated.value) {
      final authenticated = await authenticateFlickr();
      if (!authenticated) return;
    }
    flickrEnabled.value = value;
    if (value) _updateMediaCounts();
  }

  void setAutoSyncEnabled(bool value) {
    autoSyncEnabled.value = value;
  }

  // Authentication methods
  Future<bool> authenticateGooglePhotos() async {
    try {
      syncStatus.value = 'Authenticating with Google Photos...';
      final success = await _mediaService.authenticateGooglePhotos();
      googlePhotosAuthenticated.value = success;
      
      if (success) {
        syncStatus.value = 'Google Photos authenticated successfully';
        Get.snackbar(
          'Success',
          'Google Photos connected successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        syncStatus.value = 'Google Photos authentication failed';
        Get.snackbar(
          'Authentication Failed',
          'Could not connect to Google Photos',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
      
      return success;
    } catch (e) {
      syncStatus.value = 'Error: ${e.toString()}';
      return false;
    }
  }

  Future<bool> authenticateFlickr() async {
    try {
      syncStatus.value = 'Authenticating with Flickr...';
      final success = await _mediaService.authenticateFlickr();
      flickrAuthenticated.value = success;
      
      if (success) {
        syncStatus.value = 'Flickr authenticated successfully';
        Get.snackbar(
          'Success',
          'Flickr connected successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        syncStatus.value = 'Flickr authentication failed';
        Get.snackbar(
          'Authentication Failed',
          'Could not connect to Flickr',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
      
      return success;
    } catch (e) {
      syncStatus.value = 'Error: ${e.toString()}';
      return false;
    }
  }

  // Sync methods
  Future<void> syncAllSources() async {
    if (isSyncing.value) return;
    
    isSyncing.value = true;
    syncProgress.value = 0.0;
    syncStatus.value = 'Starting sync...';
    
    try {
      final sources = <String>[];
      if (localStorageEnabled.value) sources.add('local');
      if (googlePhotosEnabled.value && googlePhotosAuthenticated.value) sources.add('google');
      if (flickrEnabled.value && flickrAuthenticated.value) sources.add('flickr');
      
      for (int i = 0; i < sources.length; i++) {
        final source = sources[i];
        syncStatus.value = 'Syncing $source photos...';
        
        switch (source) {
          case 'local':
            await _mediaService.fetchLocalPhotos();
            break;
          case 'google':
            await _mediaService.fetchGooglePhotos();
            break;
          case 'flickr':
            await _mediaService.fetchFlickrPhotos();
            break;
        }
        
        syncProgress.value = (i + 1) / sources.length;
      }
      
      await _updateMediaCounts();
      lastSyncTime.value = DateTime.now();
      syncStatus.value = 'Sync completed successfully';
      
      Get.snackbar(
        'Sync Complete',
        'All media sources have been synced',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      
    } catch (e) {
      syncStatus.value = 'Sync failed: ${e.toString()}';
      Get.snackbar(
        'Sync Failed',
        'Could not sync media sources: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isSyncing.value = false;
      syncProgress.value = 0.0;
    }
  }

  // Disconnect methods
  Future<void> disconnectGooglePhotos() async {
    await _mediaService.disconnectGooglePhotos();
    googlePhotosAuthenticated.value = false;
    googlePhotosEnabled.value = false;
    googlePhotosCount.value = 0;
    
    Get.snackbar(
      'Disconnected',
      'Google Photos has been disconnected',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> disconnectFlickr() async {
    await _mediaService.disconnectFlickr();
    flickrAuthenticated.value = false;
    flickrEnabled.value = false;
    flickrPhotoCount.value = 0;
    
    Get.snackbar(
      'Disconnected',
      'Flickr has been disconnected',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Utility methods
  int get totalPhotoCount => localPhotoCount.value + googlePhotosCount.value + flickrPhotoCount.value;
  
  String get lastSyncTimeFormatted {
    if (lastSyncTime.value == null) return 'Never';
    
    final now = DateTime.now();
    final difference = now.difference(lastSyncTime.value!);
    
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inDays < 1) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    
    return '${lastSyncTime.value!.day}/${lastSyncTime.value!.month}/${lastSyncTime.value!.year}';
  }
}
