# Unified Media Picker System

## Overview

The LumiFrame app now has a **unified media picker** that allows users to select photos and videos from multiple sources in a single, cohesive interface. You don't need separate screens for each source.

## Supported Sources

- **Local Photos**: Device gallery (includes iCloud on iOS)
- **Google Photos**: User's Google Photos library (requires OAuth)
- **Flickr**: User's Flickr photos (requires OAuth)

## Features

### Single Unified Interface
- ✅ **Source Switching**: Toggle between Local, Google Photos, Flickr, or "All" sources
- ✅ **View Modes**: Switch between Albums view and All Photos view
- ✅ **Search**: Search across photos and albums by name/title
- ✅ **Multi-Selection**: Select multiple photos, albums, or both
- ✅ **Real-time Filtering**: Filter by photos/videos, search terms

### Glassmorphism Design
- ✅ **Consistent UI**: Matches your app's glassmorphism theme
- ✅ **Source Indicators**: Clear visual indicators for each photo source
- ✅ **Selection Feedback**: Beautiful selection states and counters

### Smart Navigation
- ✅ **Album Drill-down**: Tap album → see photos within that album
- ✅ **Breadcrumb Navigation**: Easy back navigation with context
- ✅ **Quick Modes**: Jump directly to "All Photos" or "Albums" view

## Usage Examples

### Basic Usage

```dart
import '../utils/media_picker_helper.dart';

// Open the unified media picker
final selectedPhotos = await MediaPickerHelper.pickMedia(
  allowMultiple: true,
  showVideos: true,
  showPhotos: true,
);

if (selectedPhotos != null && selectedPhotos.isNotEmpty) {
  // User selected photos - use them for slideshow
  print('Selected ${selectedPhotos.length} photos');
}
```

### Direct Navigation

```dart
// Navigate directly to the media picker screen
final result = await Get.to(() => const MediaPickerScreen());

if (result != null && result is List<Photo>) {
  final photos = result as List<Photo>;
  // Handle selected photos
}
```

### Integration with Slideshow

```dart
// In your slideshow creation screen
ElevatedButton(
  onPressed: () async {
    final photos = await MediaPickerHelper.pickMedia();
    if (photos != null) {
      // Create slideshow with selected photos
      _startSlideshow(photos);
    }
  },
  child: Text('Select Photos'),
)
```

## File Structure

```
lib/
├── controllers/
│   └── media_picker_controller.dart    # State management
├── models/
│   ├── photo.dart                      # Photo model (existing)
│   └── album.dart                      # New album model
├── screens/
│   └── media_picker_screen.dart        # Main picker UI
├── services/
│   └── media_service.dart              # Enhanced with album methods
└── utils/
    └── media_picker_helper.dart        # Convenience methods
```

## Controller Features

The `MediaPickerController` provides:

- **State Management**: Current mode, source, selections
- **Data Loading**: Automatic loading of albums/photos from all sources
- **Search & Filter**: Real-time filtering by name, media type
- **Selection Logic**: Multi-select with validation
- **Navigation**: Smart mode switching and history

## UI Components

### Top Controls
- **Source Chips**: Local | Google | Flickr | All
- **View Mode Buttons**: Albums | All Photos
- **Search Bar**: Real-time search across all content

### Albums Grid
- **2-column layout** with glassmorphism cards
- **Source indicators** (phone, cloud, camera icons)
- **Photo counts** for each album
- **Selection overlays** in multi-select mode

### Photos Grid
- **3-column layout** for optimal browsing
- **Video indicators** for video files
- **Source mixing** - photos from all enabled sources
- **Fast selection** with visual feedback

## Benefits

### For Users
1. **Single Interface**: No confusion about which screen to use
2. **Mixed Sources**: Can select from local + Google Photos + Flickr in one session
3. **Flexible Selection**: Pick individual photos, entire albums, or mix both
4. **Visual Clarity**: Clear source indicators and selection states

### For Developers
1. **Single Implementation**: One screen handles all photo sources
2. **Modular Design**: Easy to add new sources (Instagram, Dropbox, etc.)
3. **Consistent UX**: Same patterns across all photo operations
4. **Reusable**: Can be used from any part of the app

## Next Steps

1. **Test the OAuth flows** for Google Photos and Flickr
2. **Add more source filters** (date ranges, favorites, etc.)
3. **Implement photo caching** for better performance
4. **Add bulk operations** (select all in album, etc.)

## Integration Notes

- The picker returns `List<Photo>` objects that work with your existing slideshow system
- All photos include source metadata, so you can track where they came from
- Authentication states are handled automatically by the MediaService
- The UI automatically adapts based on which sources are authenticated

This unified approach provides a much better user experience than having separate pickers for each source!
