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
    loadAlbums();
  }
  
  // Load albums from all sources or specific source
  Future<void> loadAlbums() async {
    isLoading.value = true;
    error.value = '';
    
    try {
      albums.clear();
      
      switch (currentSource.value) {
        case MediaSource.local:
          final localAlbums = await _mediaService.fetchLocalAlbums();
          albums.addAll(localAlbums);
          break;
        case MediaSource.googlePhotos:
          final googleAlbums = await _mediaService.fetchGooglePhotosAlbums();
          albums.addAll(googleAlbums);
          break;
        case MediaSource.flickr:
          final flickrAlbums = await _mediaService.fetchFlickrAlbums();
          albums.addAll(flickrAlbums);
          break;
        case MediaSource.all:
          final localAlbums = await _mediaService.fetchLocalAlbums();
          final googleAlbums = await _mediaService.fetchGooglePhotosAlbums();
          final flickrAlbums = await _mediaService.fetchFlickrAlbums();
          
          albums.addAll(localAlbums);
          albums.addAll(googleAlbums);
          albums.addAll(flickrAlbums);
          break;
      }
      
      _sortAlbums();
    } catch (e) {
      error.value = 'Failed to load albums: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Load photos from specific album or all photos
  Future<void> loadPhotos({Album? album}) async {
    isLoading.value = true;
    error.value = '';
    
    try {
      photos.clear();
      
      if (album != null) {
        // Load photos from specific album
        selectedAlbum.value = album;
        currentMode.value = MediaPickerMode.albumPhotos;
        
        switch (album.source) {
          case 'local':
            final albumPhotos = await _mediaService.fetchLocalAlbumPhotos(album.id);
            photos.addAll(albumPhotos);
            break;
          case 'google_photos':
            final albumPhotos = await _mediaService.fetchGooglePhotosAlbumPhotos(album.id);
            photos.addAll(albumPhotos);
            break;
          case 'flickr':
            final albumPhotos = await _mediaService.fetchFlickrAlbumPhotos(album.id);
            photos.addAll(albumPhotos);
            break;
        }
      } else {
        // Load all photos from current source
        currentMode.value = MediaPickerMode.allPhotos;
        
        switch (currentSource.value) {
          case MediaSource.local:
            final localPhotos = await _mediaService.fetchLocalPhotos();
            photos.addAll(localPhotos);
            break;
          case MediaSource.googlePhotos:
            final googlePhotos = await _mediaService.fetchGooglePhotos();
            photos.addAll(googlePhotos);
            break;
          case MediaSource.flickr:
            final flickrPhotos = await _mediaService.fetchFlickrPhotos();
            photos.addAll(flickrPhotos);
            break;
          case MediaSource.all:
            final allPhotos = await _mediaService.fetchAllPhotos();
            photos.addAll(allPhotos);
            break;
        }
      }
      
      _applyFilters();
      _sortPhotos();
    } catch (e) {
      error.value = 'Failed to load photos: $e';
    } finally {
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
