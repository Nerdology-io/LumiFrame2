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
      print('MediaService: Requesting photo permission...');
      final result = await PhotoManager.requestPermissionExtend();
      print('MediaService: Photo permission result: $result');
      developer.log('Photo permission result: $result');
      
      if (result.isAuth) {
        print('MediaService: Permission granted successfully');
      } else {
        print('MediaService: Permission denied or limited: ${result.name}');
      }
      
      return result.isAuth;
    } catch (e) {
      print('MediaService: Error requesting photo permission: $e');
      developer.log('Error requesting photo permission: $e');
      return false;
    }
  }

  /// Fetch all photos from local device (excludes shared/cloud albums)
  Future<List<Photo>> fetchLocalPhotos({int page = 0, int size = 50}) async {
    try {
      print('MediaService: Starting to fetch LOCAL photos only (page: $page, size: $size)...');
      
      // Check permission first
      final hasPermission = await PhotoManager.requestPermissionExtend().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('MediaService: Permission check timed out');
          return PermissionState.denied;
        },
      );
      
      if (!hasPermission.isAuth) {
        print('MediaService: No permission to access photos');
        return [];
      }
      
      // Get only the user albums that have photos, not all the smart albums
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        hasAll: true,
        onlyAll: false,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            needTitle: true,
          ),
          videoOption: const FilterOption(
            needTitle: true,
          ),
          // This helps filter to local content
          createTimeCond: DateTimeCond(
            min: DateTime(2000),
            max: DateTime.now(),
          ),
        ),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('MediaService: Asset path list timed out');
          return <AssetPathEntity>[];
        },
      );
      
      print('MediaService: Found ${paths.length} asset paths, filtering for LOCAL albums...');

      List<Photo> allPhotos = [];
      
      // Filter to only albums that actually have photos
      final nonEmptyPaths = <AssetPathEntity>[];
      for (final path in paths) {
        if (!_isSmartAlbumEmpty(path.name)) {
          try {
            final assetCount = await path.assetCountAsync.timeout(
              const Duration(seconds: 2),
              onTimeout: () => 0,
            );
            if (assetCount > 0) {
              nonEmptyPaths.add(path);
              print('MediaService: Found non-empty album: ${path.name} ($assetCount photos)');
            }
          } catch (e) {
            print('MediaService: Error checking ${path.name}: $e');
            continue;
          }
        }
      }
      
      print('MediaService: Processing ${nonEmptyPaths.length} non-empty albums');
      
      // Process albums, limiting to reasonable number to avoid timeouts
      final maxAlbumsToProcess = 5; // Process up to 5 albums with photos
      final albumsToProcess = nonEmptyPaths.take(maxAlbumsToProcess).toList();
      
      for (int pathIndex = 0; pathIndex < albumsToProcess.length; pathIndex++) {
        final path = albumsToProcess[pathIndex];
        print('MediaService: Processing LOCAL photos from album ${pathIndex + 1}/${albumsToProcess.length}: ${path.name}');
        
        try {
          // Get a reasonable number of photos from each album
          final photosPerAlbum = (size / albumsToProcess.length).ceil();
          final List<AssetEntity> assets = await path.getAssetListRange(
            start: page * photosPerAlbum,
            end: (page + 1) * photosPerAlbum,
          ).timeout(
            const Duration(seconds: 8),
            onTimeout: () {
              print('MediaService: Asset list timeout for LOCAL album ${path.name}');
              return <AssetEntity>[];
            },
          );
          
          print('MediaService: Got ${assets.length} assets from LOCAL album ${path.name}');

          for (int i = 0; i < assets.length; i++) {
            if (allPhotos.length >= size) break; // Stop when we have enough photos
            
            try {
              final asset = assets[i];
              final photo = await _convertAssetToPhoto(asset, sourceLocal);
              if (photo != null) {
                allPhotos.add(photo);
                if (i < 2 && pathIndex < 2) { // Only log first few for brevity
                  print('MediaService: Converted LOCAL asset to photo: ${photo.id}');
                }
              }
            } catch (e) {
              print('MediaService: Error converting LOCAL asset: $e');
              continue;
            }
          }
          
          // If we have enough photos, stop processing more albums
          if (allPhotos.length >= size) {
            print('MediaService: Reached target size of $size LOCAL photos, stopping...');
            break;
          }
          
        } catch (e) {
          print('MediaService: Error processing LOCAL album ${path.name}: $e');
          continue;
        }
      }

      print('MediaService: Fetched ${allPhotos.length} LOCAL photos total');
      developer.log('Fetched ${allPhotos.length} local photos');
      return allPhotos;
    } catch (e) {
      print('MediaService: Error fetching LOCAL photos: $e');
      developer.log('Error fetching local photos: $e');
      return [];
    }
  }
  
  /// Helper method to identify empty smart albums
  bool _isSmartAlbumEmpty(String albumName) {
    final emptySmartAlbums = [
      'Recents', 'Favorites', 'Videos', 'Selfies', 'Live Photos', 
      'Portrait', 'Long Exposure', 'Spatial', 'Panoramas', 'Time-lapse',
      'Slo-mo', 'Cinematic', 'Bursts', 'Screenshots', 'Screen Recordings',
      'Animated', 'RAW', 'Hidden', 'Recently Saved', 'Recovered'
    ];
    return emptySmartAlbums.contains(albumName);
  }

  /// Fetch local albums
  Future<List<Album>> fetchLocalAlbums() async {
    try {
      print('MediaService: Starting to fetch ALL available albums...');
      
      // Check permission first
      print('MediaService: Checking permission...');
      final hasPermission = await PhotoManager.requestPermissionExtend().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('MediaService: Permission check timed out');
          return PermissionState.denied;
        },
      );
      
      if (!hasPermission.isAuth) {
        print('MediaService: No permission to access photos: ${hasPermission.name}');
        return [];
      }
      
      print('MediaService: Getting ALL asset path list...');
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: RequestType.common, // Gets both images and videos
        hasAll: true, // Include the main "Camera Roll" / "All Photos" album
        onlyAll: false, // Also include all other albums (shared, memories, etc.)
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            needTitle: true,
          ),
          videoOption: const FilterOption(
            needTitle: true,
          ),
        ),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('MediaService: Asset path list fetch timed out');
          return <AssetPathEntity>[];
        },
      );
      
      print('MediaService: Found ${paths.length} total albums');

      if (paths.isEmpty) {
        print('MediaService: No albums found');
        return [];
      }

      List<Album> albums = [];
      for (int i = 0; i < paths.length; i++) {
        final path = paths[i];
        print('MediaService: Processing album ${i + 1}/${paths.length}: "${path.name}" (isAll: ${path.isAll})');
        
        try {
          final assetCount = await path.assetCountAsync.timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              print('MediaService: Asset count timeout for ${path.name}');
              return 0;
            },
          );
          print('MediaService: Album "${path.name}" has $assetCount assets');
          
          // Only skip completely empty albums
          if (assetCount == 0) {
            print('MediaService: Skipping empty album: ${path.name}');
            continue;
          }
          
          String? thumbnailPath;
          final assets = await path.getAssetListRange(start: 0, end: 1).timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              print('MediaService: Asset list timeout for ${path.name}');
              return <AssetEntity>[];
            },
          );
          
          if (assets.isNotEmpty) {
            try {
              final thumbnailFile = await assets.first.file.timeout(
                const Duration(seconds: 3),
                onTimeout: () {
                  print('MediaService: Thumbnail file timeout for ${path.name}');
                  return null;
                },
              );
              thumbnailPath = thumbnailFile?.path;
              print('MediaService: Got thumbnail for ${path.name}: ${thumbnailPath != null ? "✓" : "✗"}');
            } catch (e) {
              print('MediaService: Error getting thumbnail for ${path.name}: $e');
            }
          }

          final album = Album(
            id: path.id,
            name: path.name,
            photoCount: assetCount,
            thumbnailUrl: thumbnailPath,
            source: sourceLocal, // We'll distinguish sources later when we add Google Photos
            dateCreated: DateTime.now(),
            dateModified: DateTime.now(),
          );
          
          albums.add(album);
          print('MediaService: Added album: ${album.name} with ${album.photoCount} photos');
        } catch (e) {
          print('MediaService: Error processing album ${path.name}: $e');
          continue;
        }
      }

      print('MediaService: Successfully fetched ${albums.length} albums total');
      developer.log('Fetched ${albums.length} total albums');
      return albums;
    } catch (e) {
      print('MediaService: Error fetching albums: $e');
      developer.log('Error fetching albums: $e');
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
    
    print('MediaService: Starting fetchAllPhotos with size limit: $size');
    
    // Fetch local photos with size limit
    final localPhotos = await fetchLocalPhotos(page: page, size: size);
    allPhotos.addAll(localPhotos);
    print('MediaService: Added ${localPhotos.length} local photos');
    
    // Only fetch from other sources if we haven't reached the size limit
    final remainingSize = size - allPhotos.length;
    if (remainingSize > 0) {
      // Fetch Google Photos if signed in
      if (_googleSignIn.currentUser != null) {
        final googlePhotos = await fetchGooglePhotos(pageSize: remainingSize);
        allPhotos.addAll(googlePhotos);
        print('MediaService: Added ${googlePhotos.length} Google Photos');
      }
      
      // Fetch Flickr photos if authenticated (but they're not implemented yet)
      if (_flickrClient != null && allPhotos.length < size) {
        final flickrPhotos = await fetchFlickrPhotos(page: page + 1, perPage: size - allPhotos.length);
        allPhotos.addAll(flickrPhotos);
        print('MediaService: Added ${flickrPhotos.length} Flickr photos');
      }
    }
    
    // Sort by creation time (newest first)
    allPhotos.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
    
    // Limit to requested size
    if (allPhotos.length > size) {
      allPhotos = allPhotos.sublist(0, size);
    }
    
    print('MediaService: Fetched ${allPhotos.length} total photos from all sources');
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
      if (file == null) {
        print('MediaService: Failed to get file for asset ${asset.id}');
        return null;
      }

      final title = await asset.titleAsync;
      
      // Store additional metadata in the metadata field
      final metadata = {
        'source': source,
        'filename': title,
        'mimeType': asset.mimeType ?? 'image/jpeg',
        'width': asset.width,
        'height': asset.height,
        'originalAsset': asset.id,
      };

      final photo = Photo(
        id: asset.id,
        url: file.path,
        thumbnailUrl: file.path,
        isVideo: asset.type == AssetType.video,
        dateAdded: asset.createDateTime,
        metadata: metadata,
      );
      
      return photo;
    } catch (e) {
      print('MediaService: Error converting asset ${asset.id} to photo: $e');
      developer.log('Error converting asset to photo: $e');
      return null;
    }
  }

  /// Test method to check if photo access is working
  Future<void> testPhotoAccess() async {
    print('MediaService: Starting photo access test...');
    
    try {
      // Check current permission status
      print('MediaService: Checking permission status...');
      final currentState = await PhotoManager.requestPermissionExtend().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('MediaService: Permission check timed out');
          return PermissionState.denied;
        },
      );
      print('MediaService: Current permission state: ${currentState.name}');
      
      if (!currentState.isAuth) {
        print('MediaService: Permission not granted - ${currentState.name}');
        return;
      }
      
      // Try to get just the path count
      print('MediaService: Getting asset paths...');
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: true,
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('MediaService: Asset path list timed out');
          return <AssetPathEntity>[];
        },
      );
      print('MediaService: Found ${paths.length} photo paths');
      
      if (paths.isEmpty) {
        print('MediaService: No photo paths found - this could indicate permission issues or no photos');
        return;
      }
      
      for (int i = 0; i < paths.length && i < 5; i++) {
        final path = paths[i];
        try {
          final count = await path.assetCountAsync.timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              print('MediaService: Asset count timeout for ${path.name}');
              return 0;
            },
          );
          print('MediaService: Path $i: "${path.name}" has $count assets');
        } catch (e) {
          print('MediaService: Error getting count for path ${path.name}: $e');
        }
      }
      
    } catch (e) {
      print('MediaService: Test failed with error: $e');
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
