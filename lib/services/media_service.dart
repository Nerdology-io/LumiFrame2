import 'dart:developer' as developer;
import 'dart:convert';
import 'package:photo_manager/photo_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import '../models/photo.dart';
import '../models/album.dart';

class MediaService {
  // Constants for photo sources
  static const String sourceLocal = 'local';
  static const String sourceGooglePhotos = 'google_photos';
  static const String sourceFlickr = 'flickr';

  // OAuth and API configuration
  static const String _googlePhotosBaseUrl = 'https://photoslibrary.googleapis.com/v1';

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/photoslibrary.readonly'],
  );

  // OAuth2 client for Flickr
  oauth2.Client? _flickrClient;

  /// Request permission to access device photos
  Future<bool> requestPermission() async {
    try {
      final result = await PhotoManager.requestPermissionExtend();
      developer.log('Photo permission result: $result');
      return result.isAuth;
    } catch (e) {
      developer.log('Error requesting photo permission: $e');
      return false;
    }
  }

  /// Fetch all photos from local device
  Future<List<Photo>> fetchLocalPhotos({int page = 0, int size = 50}) async {
    try {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
      );

      List<Photo> allPhotos = [];
      for (AssetPathEntity path in paths) {
        final List<AssetEntity> assets = await path.getAssetListRange(
          start: page * size,
          end: (page + 1) * size,
        );

        for (AssetEntity asset in assets) {
          final photo = await _convertAssetToPhoto(asset, sourceLocal);
          if (photo != null) {
            allPhotos.add(photo);
          }
        }
      }

      developer.log('Fetched ${allPhotos.length} local photos');
      return allPhotos;
    } catch (e) {
      developer.log('Error fetching local photos: $e');
      return [];
    }
  }

  /// Fetch local albums
  Future<List<Album>> fetchLocalAlbums() async {
    try {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
      );

      List<Album> albums = [];
      for (AssetPathEntity path in paths) {
        final assetCount = await path.assetCountAsync;
        final assets = await path.getAssetListRange(start: 0, end: 1);
        
        String? thumbnailPath;
        if (assets.isNotEmpty) {
          final thumbnailFile = await assets.first.file;
          thumbnailPath = thumbnailFile?.path;
        }

        albums.add(Album(
          id: path.id,
          name: path.name,
          photoCount: assetCount,
          thumbnailUrl: thumbnailPath,
          source: sourceLocal,
          dateCreated: DateTime.now(),
          dateModified: DateTime.now(),
        ));
      }

      developer.log('Fetched ${albums.length} local albums');
      return albums;
    } catch (e) {
      developer.log('Error fetching local albums: $e');
      return [];
    }
  }

  /// Fetch photos from a specific local album
  Future<List<Photo>> fetchLocalAlbumPhotos(String albumId, {int page = 0, int size = 50}) async {
    try {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
      );

      final album = paths.firstWhere((path) => path.id == albumId);
      final List<AssetEntity> assets = await album.getAssetListRange(
        start: page * size,
        end: (page + 1) * size,
      );

      List<Photo> photos = [];
      for (AssetEntity asset in assets) {
        final photo = await _convertAssetToPhoto(asset, sourceLocal);
        if (photo != null) {
          photos.add(photo);
        }
      }

      developer.log('Fetched ${photos.length} photos from local album $albumId');
      return photos;
    } catch (e) {
      developer.log('Error fetching local album photos: $e');
      return [];
    }
  }

  /// Sign in to Google Photos
  Future<bool> signInToGooglePhotos() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        developer.log('Successfully signed in to Google Photos: ${account.email}');
        return true;
      }
      return false;
    } catch (e) {
      developer.log('Error signing in to Google Photos: $e');
      return false;
    }
  }

  /// Fetch Google Photos albums
  Future<List<Album>> fetchGooglePhotosAlbums() async {
    try {
      final account = _googleSignIn.currentUser;
      if (account == null) {
        developer.log('No Google account signed in');
        return [];
      }

      final authHeaders = await account.authHeaders;
      final response = await http.get(
        Uri.parse('$_googlePhotosBaseUrl/albums'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final albumsData = data['albums'] as List<dynamic>? ?? [];
        
        List<Album> albums = [];
        for (var albumData in albumsData) {
          albums.add(Album(
            id: albumData['id'] ?? '',
            name: albumData['title'] ?? 'Untitled Album',
            photoCount: int.tryParse(albumData['mediaItemsCount'] ?? '0') ?? 0,
            thumbnailUrl: albumData['coverPhotoBaseUrl'],
            source: sourceGooglePhotos,
            dateCreated: DateTime.tryParse(albumData['creationTime'] ?? '') ?? DateTime.now(),
            dateModified: DateTime.tryParse(albumData['creationTime'] ?? '') ?? DateTime.now(),
          ));
        }

        developer.log('Fetched ${albums.length} Google Photos albums');
        return albums;
      } else {
        developer.log('Failed to fetch Google Photos albums: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      developer.log('Error fetching Google Photos albums: $e');
      return [];
    }
  }

  /// Fetch Google Photos
  Future<List<Photo>> fetchGooglePhotos({int pageSize = 50, String? pageToken}) async {
    try {
      final account = _googleSignIn.currentUser;
      if (account == null) {
        developer.log('No Google account signed in');
        return [];
      }

      final authHeaders = await account.authHeaders;
      final uri = Uri.parse('$_googlePhotosBaseUrl/mediaItems').replace(
        queryParameters: {
          'pageSize': pageSize.toString(),
          if (pageToken != null) 'pageToken': pageToken,
        },
      );

      final response = await http.get(uri, headers: authHeaders);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final mediaItems = data['mediaItems'] as List<dynamic>? ?? [];
        
        List<Photo> photos = [];
        for (var item in mediaItems) {
          final creationTime = DateTime.tryParse(item['mediaMetadata']?['creationTime'] ?? '') ?? DateTime.now();
          final mimeType = item['mimeType'] ?? 'image/jpeg';
          final isVideo = mimeType.startsWith('video/');
          
          // Store additional metadata in the metadata field
          final metadata = {
            'source': sourceGooglePhotos,
            'filename': item['filename'] ?? 'Unknown',
            'mimeType': mimeType,
            'width': int.tryParse(item['mediaMetadata']?['width'] ?? '0') ?? 0,
            'height': int.tryParse(item['mediaMetadata']?['height'] ?? '0') ?? 0,
            'originalData': item,
          };

          photos.add(Photo(
            id: item['id'] ?? '',
            url: item['baseUrl'] ?? '',
            thumbnailUrl: item['baseUrl'] ?? '',
            isVideo: isVideo,
            dateAdded: creationTime,
            metadata: metadata,
          ));
        }

        developer.log('Fetched ${photos.length} Google Photos');
        return photos;
      } else {
        developer.log('Failed to fetch Google Photos: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      developer.log('Error fetching Google Photos: $e');
      return [];
    }
  }

  /// Fetch photos from a specific Google Photos album
  Future<List<Photo>> fetchGooglePhotosAlbumPhotos(String albumId, {int pageSize = 50, String? pageToken}) async {
    try {
      final account = _googleSignIn.currentUser;
      if (account == null) {
        developer.log('No Google account signed in');
        return [];
      }

      final authHeaders = await account.authHeaders;
      final response = await http.post(
        Uri.parse('$_googlePhotosBaseUrl/mediaItems:search'),
        headers: {
          ...authHeaders,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'albumId': albumId,
          'pageSize': pageSize,
          if (pageToken != null) 'pageToken': pageToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final mediaItems = data['mediaItems'] as List<dynamic>? ?? [];
        
        List<Photo> photos = [];
        for (var item in mediaItems) {
          final creationTime = DateTime.tryParse(item['mediaMetadata']?['creationTime'] ?? '') ?? DateTime.now();
          final mimeType = item['mimeType'] ?? 'image/jpeg';
          final isVideo = mimeType.startsWith('video/');
          
          // Store additional metadata in the metadata field
          final metadata = {
            'source': sourceGooglePhotos,
            'filename': item['filename'] ?? 'Unknown',
            'mimeType': mimeType,
            'width': int.tryParse(item['mediaMetadata']?['width'] ?? '0') ?? 0,
            'height': int.tryParse(item['mediaMetadata']?['height'] ?? '0') ?? 0,
            'albumId': albumId,
            'originalData': item,
          };

          photos.add(Photo(
            id: item['id'] ?? '',
            url: item['baseUrl'] ?? '',
            thumbnailUrl: item['baseUrl'] ?? '',
            isVideo: isVideo,
            dateAdded: creationTime,
            metadata: metadata,
          ));
        }

        developer.log('Fetched ${photos.length} photos from Google Photos album $albumId');
        return photos;
      } else {
        developer.log('Failed to fetch Google Photos album photos: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      developer.log('Error fetching Google Photos album photos: $e');
      return [];
    }
  }

  /// Sign in to Flickr (OAuth 1.0a flow)
  Future<bool> signInToFlickr() async {
    try {
      // This is a simplified example. In a real app, you'd implement the full OAuth 1.0a flow
      // For now, we'll just return false to indicate Flickr integration is not fully implemented
      developer.log('Flickr OAuth flow not fully implemented');
      return false;
    } catch (e) {
      developer.log('Error signing in to Flickr: $e');
      return false;
    }
  }

  /// Fetch Flickr albums (photosets)
  Future<List<Album>> fetchFlickrAlbums() async {
    try {
      // Placeholder implementation - would require OAuth token
      developer.log('Flickr album fetching not fully implemented');
      return [];
    } catch (e) {
      developer.log('Error fetching Flickr albums: $e');
      return [];
    }
  }

  /// Fetch Flickr photos
  Future<List<Photo>> fetchFlickrPhotos({int page = 1, int perPage = 50}) async {
    try {
      // Placeholder implementation - would require OAuth token
      developer.log('Flickr photo fetching not fully implemented');
      return [];
    } catch (e) {
      developer.log('Error fetching Flickr photos: $e');
      return [];
    }
  }

  /// Fetch photos from a specific Flickr album (photoset)
  Future<List<Photo>> fetchFlickrAlbumPhotos(String albumId, {int page = 1, int perPage = 50}) async {
    try {
      // Placeholder implementation - would require OAuth token
      developer.log('Flickr album photo fetching not fully implemented');
      return [];
    } catch (e) {
      developer.log('Error fetching Flickr album photos: $e');
      return [];
    }
  }

  /// Fetch photos from all sources
  Future<List<Photo>> fetchAllPhotos({int page = 0, int size = 50}) async {
    List<Photo> allPhotos = [];
    
    // Fetch local photos
    final localPhotos = await fetchLocalPhotos(page: page, size: size);
    allPhotos.addAll(localPhotos);
    
    // Fetch Google Photos if signed in
    if (_googleSignIn.currentUser != null) {
      final googlePhotos = await fetchGooglePhotos(pageSize: size);
      allPhotos.addAll(googlePhotos);
    }
    
    // Fetch Flickr photos if authenticated
    if (_flickrClient != null) {
      final flickrPhotos = await fetchFlickrPhotos(page: page + 1, perPage: size);
      allPhotos.addAll(flickrPhotos);
    }
    
    // Sort by creation time (newest first)
    allPhotos.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
    
    developer.log('Fetched ${allPhotos.length} total photos from all sources');
    return allPhotos;
  }

  /// Fetch albums from all sources
  Future<List<Album>> fetchAllAlbums() async {
    List<Album> allAlbums = [];
    
    // Fetch local albums
    final localAlbums = await fetchLocalAlbums();
    allAlbums.addAll(localAlbums);
    
    // Fetch Google Photos albums if signed in
    if (_googleSignIn.currentUser != null) {
      final googleAlbums = await fetchGooglePhotosAlbums();
      allAlbums.addAll(googleAlbums);
    }
    
    // Fetch Flickr albums if authenticated
    if (_flickrClient != null) {
      final flickrAlbums = await fetchFlickrAlbums();
      allAlbums.addAll(flickrAlbums);
    }
    
    developer.log('Fetched ${allAlbums.length} total albums from all sources');
    return allAlbums;
  }

  /// Convert AssetEntity to Photo
  Future<Photo?> _convertAssetToPhoto(AssetEntity asset, String source) async {
    try {
      final file = await asset.file;
      if (file == null) return null;

      // Store additional metadata in the metadata field
      final metadata = {
        'source': source,
        'filename': await asset.titleAsync,
        'mimeType': asset.mimeType ?? 'image/jpeg',
        'width': asset.width,
        'height': asset.height,
        'originalAsset': asset.id,
      };

      return Photo(
        id: asset.id,
        url: file.path,
        thumbnailUrl: file.path,
        isVideo: asset.type == AssetType.video,
        dateAdded: asset.createDateTime,
        metadata: metadata,
      );
    } catch (e) {
      developer.log('Error converting asset to photo: $e');
      return null;
    }
  }

  /// Sign out from all services
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _flickrClient = null;
      developer.log('Signed out from all services');
    } catch (e) {
      developer.log('Error signing out: $e');
    }
  }

  /// Check if user is signed in to Google Photos
  bool get isSignedInToGooglePhotos => _googleSignIn.currentUser != null;

  /// Check if user is signed in to Flickr
  bool get isSignedInToFlickr => _flickrClient != null;

  /// Get current Google account email
  String? get googleAccountEmail => _googleSignIn.currentUser?.email;

  /// Check if Google Photos is authenticated (alternative method name)
  bool isGooglePhotosAuthenticated() => isSignedInToGooglePhotos;

  /// Check if Flickr is authenticated (alternative method name)
  bool isFlickrAuthenticated() => isSignedInToFlickr;

  /// Authenticate Google Photos (alternative method name)
  Future<bool> authenticateGooglePhotos() => signInToGooglePhotos();

  /// Authenticate Flickr (alternative method name)
  Future<bool> authenticateFlickr() => signInToFlickr();

  /// Disconnect Google Photos (alternative method name)
  Future<void> disconnectGooglePhotos() async {
    try {
      await _googleSignIn.signOut();
      developer.log('Disconnected from Google Photos');
    } catch (e) {
      developer.log('Error disconnecting from Google Photos: $e');
    }
  }

  /// Disconnect Flickr (alternative method name)
  Future<void> disconnectFlickr() async {
    try {
      _flickrClient = null;
      developer.log('Disconnected from Flickr');
    } catch (e) {
      developer.log('Error disconnecting from Flickr: $e');
    }
  }

  /// Upload media file (placeholder implementation)
  Future<String?> uploadMedia(String filePath, String fileName) async {
    try {
      // This is a placeholder implementation
      // In a real app, you would upload to your storage service (Firebase Storage, AWS S3, etc.)
      developer.log('Upload media not fully implemented: $filePath -> $fileName');
      
      // For now, return the local file path as the URL
      // In production, this would return the uploaded file URL
      return filePath;
    } catch (e) {
      developer.log('Error uploading media: $e');
      return null;
    }
  }
}
