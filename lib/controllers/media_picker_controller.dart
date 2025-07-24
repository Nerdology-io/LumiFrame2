import 'package:get/get.dart';
import 'package:lumiframe/models/photo.dart';
import 'package:lumiframe/models/album.dart';
import 'package:lumiframe/services/media_service.dart';

enum MediaPickerMode {
  albums,        // Show albums grid
  albumPhotos,   // Show photos within an album
  allPhotos,     // Show all photos from all sources
}

enum MediaSource {
  local,
  googlePhotos,
  flickr,
  all,
}

class MediaPickerController extends GetxController {
  final MediaService _mediaService = Get.find<MediaService>();
  
  // Current state
  var currentMode = MediaPickerMode.albums.obs;
  var currentSource = MediaSource.all.obs;
  var selectedAlbum = Rx<Album?>(null);
  
  // Data
  var albums = <Album>[].obs;
  var photos = <Photo>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  
  // Selection
  var selectedPhotos = <Photo>[].obs;
  var selectedAlbums = <Album>[].obs;
  var isSelectionMode = false.obs;
  var selectAllInAlbum = false.obs;
  
  // Filtering and search
  var searchQuery = ''.obs;
  var showVideos = true.obs;
  var showPhotos = true.obs;
  var sortBy = 'date_desc'.obs; // date_desc, date_asc, name_asc, name_desc
  
  @override
  void onInit() {
    super.onInit();
    _initializePermissionsAndLoadData();
  }
  
  Future<void> _initializePermissionsAndLoadData() async {
    // Request photo permissions
    print('MediaPickerController: Requesting photo permissions...');
    final hasPermission = await _mediaService.requestPermission();
    print('MediaPickerController: Permission granted: $hasPermission');
    
    if (!hasPermission) {
      error.value = 'Photo access permission is required to view media.';
      print('MediaPickerController: Permission denied');
      
      // Add some dummy albums for testing
      print('MediaPickerController: Adding dummy albums for testing...');
      albums.add(Album(
        id: 'dummy_1',
        name: 'Test Album 1',
        photoCount: 5,
        thumbnailUrl: null,
        source: 'local',
        dateCreated: DateTime.now(),
        dateModified: DateTime.now(),
      ));
      albums.add(Album(
        id: 'dummy_2',
        name: 'Test Album 2',
        photoCount: 10,
        thumbnailUrl: null,
        source: 'local',
        dateCreated: DateTime.now(),
        dateModified: DateTime.now(),
      ));
      isLoading.value = false;
      return;
    }
    
    // Run test to see what's available
    print('MediaPickerController: Running photo access test...');
    await _mediaService.testPhotoAccess();
    
    print('MediaPickerController: Loading albums...');
    loadAlbums();
  }
  
  // Load albums from all sources or specific source
  Future<void> loadAlbums() async {
    print('MediaPickerController: Starting loadAlbums for source: ${currentSource.value}');
    isLoading.value = true;
    error.value = '';
    
    try {
      albums.clear();
      print('MediaPickerController: Cleared albums list');
      
      switch (currentSource.value) {
        case MediaSource.local:
          print('MediaPickerController: Fetching local albums...');
          final localAlbums = await _mediaService.fetchLocalAlbums().timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              print('MediaPickerController: Local albums fetch timed out');
              return <Album>[];
            },
          );
          print('MediaPickerController: Got ${localAlbums.length} local albums');
          albums.addAll(localAlbums);
          break;
        case MediaSource.googlePhotos:
          print('MediaPickerController: Fetching Google Photos albums...');
          final googleAlbums = await _mediaService.fetchGooglePhotosAlbums().timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              print('MediaPickerController: Google Photos albums fetch timed out');
              return <Album>[];
            },
          );
          print('MediaPickerController: Got ${googleAlbums.length} Google Photos albums');
          albums.addAll(googleAlbums);
          break;
        case MediaSource.flickr:
          print('MediaPickerController: Fetching Flickr albums...');
          final flickrAlbums = await _mediaService.fetchFlickrAlbums().timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              print('MediaPickerController: Flickr albums fetch timed out');
              return <Album>[];
            },
          );
          print('MediaPickerController: Got ${flickrAlbums.length} Flickr albums');
          albums.addAll(flickrAlbums);
          break;
        case MediaSource.all:
          print('MediaPickerController: Fetching all albums...');
          final localAlbums = await _mediaService.fetchLocalAlbums().timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              print('MediaPickerController: Local albums fetch timed out in all mode');
              return <Album>[];
            },
          );
          final googleAlbums = await _mediaService.fetchGooglePhotosAlbums().timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              print('MediaPickerController: Google Photos albums fetch timed out in all mode');
              return <Album>[];
            },
          );
          final flickrAlbums = await _mediaService.fetchFlickrAlbums().timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              print('MediaPickerController: Flickr albums fetch timed out in all mode');
              return <Album>[];
            },
          );
          
          print('MediaPickerController: Got ${localAlbums.length} local, ${googleAlbums.length} Google, ${flickrAlbums.length} Flickr albums');
          albums.addAll(localAlbums);
          albums.addAll(googleAlbums);
          albums.addAll(flickrAlbums);
          break;
      }
      
      print('MediaPickerController: About to sort albums...');
      _sortAlbums();
      print('MediaPickerController: Finished loading ${albums.length} albums');
    } catch (e) {
      error.value = 'Failed to load albums: $e';
      print('MediaPickerController: Error loading albums: $e');
    } finally {
      print('MediaPickerController: Setting isLoading to false');
      isLoading.value = false;
    }
  }
  
  // Load photos from specific album or all photos
  Future<void> loadPhotos({Album? album}) async {
    print('MediaPickerController: Starting loadPhotos. Album: ${album?.name ?? 'null'}, Source: ${currentSource.value}');
    isLoading.value = true;
    error.value = '';
    
    try {
      photos.clear();
      print('MediaPickerController: Cleared photos list');
      
      if (album != null) {
        // Load photos from specific album
        selectedAlbum.value = album;
        currentMode.value = MediaPickerMode.albumPhotos;
        print('MediaPickerController: Loading photos from album ${album.name} (source: ${album.source})');
        
        switch (album.source) {
          case 'local':
            final albumPhotos = await _mediaService.fetchLocalAlbumPhotos(album.id).timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                print('MediaPickerController: Local album photos fetch timed out');
                return <Photo>[];
              },
            );
            print('MediaPickerController: Got ${albumPhotos.length} photos from local album');
            photos.addAll(albumPhotos);
            break;
          case 'google_photos':
            final albumPhotos = await _mediaService.fetchGooglePhotosAlbumPhotos(album.id).timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                print('MediaPickerController: Google Photos album photos fetch timed out');
                return <Photo>[];
              },
            );
            print('MediaPickerController: Got ${albumPhotos.length} photos from Google Photos album');
            photos.addAll(albumPhotos);
            break;
          case 'flickr':
            final albumPhotos = await _mediaService.fetchFlickrAlbumPhotos(album.id).timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                print('MediaPickerController: Flickr album photos fetch timed out');
                return <Photo>[];
              },
            );
            print('MediaPickerController: Got ${albumPhotos.length} photos from Flickr album');
            photos.addAll(albumPhotos);
            break;
        }
      } else {
        // Load all photos from current source
        currentMode.value = MediaPickerMode.allPhotos;
        print('MediaPickerController: Loading all photos from source: ${currentSource.value}');
        
        switch (currentSource.value) {
          case MediaSource.local:
            final localPhotos = await _mediaService.fetchLocalPhotos().timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                print('MediaPickerController: Local photos fetch timed out');
                return <Photo>[];
              },
            );
            print('MediaPickerController: Got ${localPhotos.length} local photos');
            photos.addAll(localPhotos);
            break;
          case MediaSource.googlePhotos:
            final googlePhotos = await _mediaService.fetchGooglePhotos().timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                print('MediaPickerController: Google Photos fetch timed out');
                return <Photo>[];
              },
            );
            print('MediaPickerController: Got ${googlePhotos.length} Google Photos');
            photos.addAll(googlePhotos);
            break;
          case MediaSource.flickr:
            final flickrPhotos = await _mediaService.fetchFlickrPhotos().timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                print('MediaPickerController: Flickr photos fetch timed out');
                return <Photo>[];
              },
            );
            print('MediaPickerController: Got ${flickrPhotos.length} Flickr photos');
            photos.addAll(flickrPhotos);
            break;
          case MediaSource.all:
            final allPhotos = await _mediaService.fetchAllPhotos().timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                print('MediaPickerController: All photos fetch timed out');
                return <Photo>[];
              },
            );
            print('MediaPickerController: Got ${allPhotos.length} photos from all sources');
            photos.addAll(allPhotos);
            break;
        }
      }
      
      print('MediaPickerController: About to apply filters...');
      _applyFilters();
      print('MediaPickerController: About to sort photos...');
      _sortPhotos();
      print('MediaPickerController: Finished loading photos. Total: ${photos.length}, Filtered: ${filteredPhotos.length}');
    } catch (e) {
      error.value = 'Failed to load photos: $e';
      print('MediaPickerController: Error loading photos: $e');
    } finally {
      print('MediaPickerController: Setting isLoading to false');
      isLoading.value = false;
    }
  }
  
  // Navigation methods
  void goBack() {
    if (currentMode.value == MediaPickerMode.albumPhotos) {
      selectedAlbum.value = null;
      currentMode.value = MediaPickerMode.albums;
      clearSelection();
    }
  }
  
  void goToAllPhotos() {
    selectedAlbum.value = null;
    loadPhotos();
  }
  
  void goToAlbums() {
    selectedAlbum.value = null;
    currentMode.value = MediaPickerMode.albums;
    clearSelection();
  }
  
  // Source switching
  void switchSource(MediaSource source) {
    if (currentSource.value != source) {
      currentSource.value = source;
      clearSelection();
      
      if (currentMode.value == MediaPickerMode.albums) {
        loadAlbums();
      } else {
        loadPhotos();
      }
    }
  }
  
  // Selection methods
  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      clearSelection();
    }
  }
  
  void togglePhotoSelection(Photo photo) {
    if (selectedPhotos.contains(photo)) {
      selectedPhotos.remove(photo);
    } else {
      selectedPhotos.add(photo);
    }
  }
  
  void toggleAlbumSelection(Album album) {
    if (selectedAlbums.contains(album)) {
      selectedAlbums.remove(album);
    } else {
      selectedAlbums.add(album);
    }
  }
  
  void selectAllPhotos() {
    selectedPhotos.clear();
    selectedPhotos.addAll(filteredPhotos);
  }
  
  void selectAllAlbums() {
    selectedAlbums.clear();
    selectedAlbums.addAll(filteredAlbums);
  }
  
  void clearSelection() {
    selectedPhotos.clear();
    selectedAlbums.clear();
    isSelectionMode.value = false;
  }
  
  // Search and filter
  void setSearchQuery(String query) {
    searchQuery.value = query;
    _applyFilters();
  }
  
  void toggleShowVideos() {
    showVideos.value = !showVideos.value;
    _applyFilters();
  }
  
  void toggleShowPhotos() {
    showPhotos.value = !showPhotos.value;
    _applyFilters();
  }
  
  void setSortBy(String sort) {
    sortBy.value = sort;
    _sortPhotos();
    _sortAlbums();
  }
  
  // Private methods
  void _applyFilters() {
    // This will trigger filtered getters to update
    update();
  }
  
  void _sortPhotos() {
    switch (sortBy.value) {
      case 'date_desc':
        photos.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
        break;
      case 'date_asc':
        photos.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
        break;
      case 'name_asc':
        photos.sort((a, b) => (a.metadata?['filename'] ?? '').compareTo(b.metadata?['filename'] ?? ''));
        break;
      case 'name_desc':
        photos.sort((a, b) => (b.metadata?['filename'] ?? '').compareTo(a.metadata?['filename'] ?? ''));
        break;
    }
  }
  
  void _sortAlbums() {
    switch (sortBy.value) {
      case 'date_desc':
        albums.sort((a, b) => b.dateModified.compareTo(a.dateModified));
        break;
      case 'date_asc':
        albums.sort((a, b) => a.dateModified.compareTo(b.dateModified));
        break;
      case 'name_asc':
        albums.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name_desc':
        albums.sort((a, b) => b.name.compareTo(a.name));
        break;
    }
  }
  
  // Getters for filtered data
  List<Photo> get filteredPhotos {
    return photos.where((photo) {
      // Filter by media type
      if (!showPhotos.value && !photo.isVideo) return false;
      if (!showVideos.value && photo.isVideo) return false;
      
      // Filter by search query
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        final filename = photo.metadata?['filename']?.toString().toLowerCase() ?? '';
        final title = photo.metadata?['title']?.toString().toLowerCase() ?? '';
        
        if (!filename.contains(query) && !title.contains(query)) {
          return false;
        }
      }
      
      return true;
    }).toList();
  }
  
  List<Album> get filteredAlbums {
    return albums.where((album) {
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        if (!album.name.toLowerCase().contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }
  
  // Selection getters
  bool isPhotoSelected(Photo photo) => selectedPhotos.contains(photo);
  bool isAlbumSelected(Album album) => selectedAlbums.contains(album);
  int get selectedCount => selectedPhotos.length + selectedAlbums.length;
  
  // Get selected items for slideshow
  List<Photo> getSelectedMediaForSlideshow() {
    final List<Photo> result = [];
    
    // Add directly selected photos
    result.addAll(selectedPhotos);
    
    // TODO: Add photos from selected albums
    // This would require loading photos from each selected album
    // For now, we'll just return the directly selected photos
    
    return result;
  }
}
