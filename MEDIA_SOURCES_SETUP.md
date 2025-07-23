# Media Sources Implementation Guide

This implementation provides integration with multiple photo sources for LumiFrame.

## Supported Sources

### 1. Local Storage
- **iOS**: Accesses Photos app library (includes iCloud photos)
- **Android**: Accesses device gallery and Google Photos if synced locally
- **Implementation**: Uses `photo_manager` package with proper permissions

### 2. Google Photos
- **Authentication**: OAuth 2.0 via `google_sign_in`
- **API**: Google Photos Library API
- **Scope**: `https://www.googleapis.com/auth/photoslibrary.readonly`

### 3. Flickr
- **Authentication**: OAuth 1.0a
- **API**: Flickr REST API
- **Note**: Requires API key and secret from Flickr

## Setup Required (One-Time Developer Setup)

**Important**: You only set up the API credentials once. Each user will sign into their own accounts.

### Google Photos API Setup (Required for all users to access their Google Photos)
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create/select a project for your LumiFrame app ✅ **DONE**
3. Enable Photos Library API ✅ **DONE** 
4. Set up OAuth consent screen and add test users ✅ **DONE**
5. **CREATE OAuth 2.0 CREDENTIALS (NEXT STEP):**
   - In Google Cloud Console, go to "Credentials" in left sidebar
   - Click "+ CREATE CREDENTIALS" → "OAuth client ID"
   - Choose "iOS" as application type
   - Enter your iOS Bundle ID: `com.nerdologyio.lumiframe` (from your project)
   - Download the resulting `GoogleService-Info.plist` file
6. **CONFIGURE FLUTTER APP (NEXT STEP):**
   - Add `GoogleService-Info.plist` to `ios/Runner/` folder
   - Update `Info.plist` with URL scheme
7. **Result**: Any user can now sign into their own Google Photos account

### Flickr API Setup (Required for all users to access their Flickr)
1. Go to [Flickr App Garden](https://www.flickr.com/services/apps/create/)
2. Create a new app representing your LumiFrame app
3. Get your API Key and Secret for your app
4. Update `MediaService._flickrApiKey` and `MediaService._flickrApiSecret`
5. **Result**: Any user can now sign into their own Flickr account

### iOS Permissions (Info.plist)
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photos to display them in slideshow</string>
```

### Android Permissions (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
```

## Features Implemented

- ✅ Local photo access (includes iCloud on iOS)
- ✅ Google Photos integration with OAuth
- ✅ Flickr integration (basic implementation)
- ✅ Authentication status tracking
- ✅ Photo count and sync status
- ✅ Auto-sync capability
- ✅ Manual sync with progress indication
- ✅ Disconnect/logout functionality
- ✅ Error handling and user feedback

## Next Steps

1. **API Keys**: Add your actual Flickr API credentials
2. **Google Cloud**: Set up Google Photos API project
3. **OAuth Flow**: Enhance Flickr OAuth implementation for production
4. **Caching**: Implement photo caching for better performance
5. **Thumbnails**: Generate and cache thumbnails for faster loading
6. **Filtering**: Add date range and album filtering options

## Usage

The MediaSourcesController manages all photo source settings and the MediaService handles the actual API calls. The UI provides easy toggles and status information for users.

## Privacy Notes

- **Each user signs into their own accounts** - you never see their credentials
- **All authentication tokens are stored locally** on each user's device
- **No photos are uploaded to external servers** - they're streamed directly from user's accounts
- **Users can disconnect services at any time** - full control over their data
- **Only read-only access is requested** for external services
- **You (developer) never access user accounts** - only provide the app credentials
