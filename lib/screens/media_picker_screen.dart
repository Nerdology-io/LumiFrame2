import 'package:flutter/material.dart';
import '../theme/backgrounds/dark_blur_background.dart';
import '../theme/backgrounds/light_blur_background.dart';
import 'package:get/get.dart';
import '../controllers/media_picker_controller.dart';
import '../models/photo.dart';
import '../models/album.dart';
import '../theme/glassmorphism_container.dart';
import '../theme/theme_extensions.dart';
import '../theme/app_colors.dart';
import 'settings/media_sources_screen.dart';

class MediaPickerScreen extends StatelessWidget {
  const MediaPickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaPickerController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final background = isDark ? const DarkBlurBackground() : const LightBlurBackground();

    return Stack(
      children: [
        background,
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Obx(() => Text(
              _getTitle(controller),
              style: TextStyle(
                color: context.primaryTextColor,
                fontWeight: FontWeight.w600,
              ),
            )),
            leading: Obx(() => controller.currentMode.value == MediaPickerMode.albumPhotos
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: context.primaryTextColor),
                    onPressed: controller.goBack,
                  )
                : IconButton(
                    icon: Icon(Icons.close, color: context.primaryTextColor),
                    onPressed: () => Get.back(),
                  )),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: context.primaryTextColor),
                onPressed: () => Get.to(() => const MediaSourcesScreen()),
                tooltip: 'Media Sources Settings',
              ),
              Obx(() => controller.isSelectionMode.value
                  ? TextButton(
                      onPressed: controller.selectedCount > 0 ? _onDone : null,
                      child: Text(
                        'Done (${controller.selectedCount})',
                        style: TextStyle(
                          color: controller.selectedCount > 0 
                              ? theme.colorScheme.primary 
                              : context.primaryTextColor.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.select_all, color: context.primaryTextColor),
                      onPressed: controller.toggleSelectionMode,
                    )),
            ],
          ),
          body: Column(
            children: [
              _buildTopControls(controller, context),
              Expanded(
                child: Obx(() => _buildContent(controller, context)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getTitle(MediaPickerController controller) {
    switch (controller.currentMode.value) {
      case MediaPickerMode.albums:
        return _getSourceTitle(controller.currentSource.value) + ' Albums';
      case MediaPickerMode.albumPhotos:
        return controller.selectedAlbum.value?.name ?? 'Album Photos';
      case MediaPickerMode.allPhotos:
        return _getSourceTitle(controller.currentSource.value) + ' Photos';
    }
  }

  String _getSourceTitle(MediaSource source) {
    switch (source) {
      case MediaSource.local:
        return 'Local';
      case MediaSource.googlePhotos:
        return 'Google Photos';
      case MediaSource.flickr:
        return 'Flickr';
      case MediaSource.all:
        return 'All';
    }
  }

  Widget _buildTopControls(MediaPickerController controller, BuildContext context) {
    return GlassmorphismContainer(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Source selector
            Row(
              children: [
                Expanded(
                  child: _buildSourceChip(controller, MediaSource.all, 'All', Icons.collections, context),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSourceChip(controller, MediaSource.local, 'Local', Icons.phone_iphone, context),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSourceChip(controller, MediaSource.googlePhotos, 'Google', Icons.cloud, context),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSourceChip(controller, MediaSource.flickr, 'Flickr', Icons.camera_alt, context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // View mode and search
            Row(
              children: [
                // View mode buttons
                Obx(() => _buildViewModeButton(
                  controller,
                  MediaPickerMode.albums,
                  Icons.photo_album,
                  'Albums',
                  context,
                )),
                const SizedBox(width: 8),
                Obx(() => _buildViewModeButton(
                  controller,
                  MediaPickerMode.allPhotos,
                  Icons.photo_library,
                  'All Photos',
                  context,
                )),
                const SizedBox(width: 16),
                // Search
                Expanded(
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: context.surfaceColor.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: context.borderColor,
                      ),
                    ),
                    child: TextField(
                      onChanged: controller.setSearchQuery,
                      style: TextStyle(color: context.primaryTextColor, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: context.secondaryTextColor, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: context.secondaryTextColor, size: 18),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceChip(MediaPickerController controller, MediaSource source, String label, IconData icon, BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () => controller.switchSource(source),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: controller.currentSource.value == source
              ? context.selectedBackground
              : context.surfaceColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: controller.currentSource.value == source
                ? context.selectedBorder
                : context.borderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: controller.currentSource.value == source
                  ? context.selectedText
                  : context.primaryTextColor,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: controller.currentSource.value == source
                      ? context.selectedText
                      : context.primaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildViewModeButton(MediaPickerController controller, MediaPickerMode mode, IconData icon, String label, BuildContext context) {
    final isActive = controller.currentMode.value == mode;
    return GestureDetector(
      onTap: () {
        if (mode == MediaPickerMode.albums) {
          controller.goToAlbums();
        } else if (mode == MediaPickerMode.allPhotos) {
          controller.goToAllPhotos();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive
              ? context.selectedBackground
              : context.surfaceColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? context.selectedBorder
                : context.borderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isActive ? context.selectedText : context.primaryTextColor,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isActive ? context.selectedText : context.primaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(MediaPickerController controller, BuildContext context) {
    if (controller.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(context.accentColor),
        ),
      );
    }

    if (controller.error.value.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: context.secondaryTextColor,
              ),
              const SizedBox(height: 16),
              Text(
                controller.error.value,
                style: TextStyle(
                  color: context.secondaryTextColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (controller.currentMode.value == MediaPickerMode.albums) {
                    controller.loadAlbums();
                  } else {
                    controller.loadPhotos();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.accentColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    switch (controller.currentMode.value) {
      case MediaPickerMode.albums:
        return _buildAlbumsGrid(controller, context);
      case MediaPickerMode.albumPhotos:
      case MediaPickerMode.allPhotos:
        return _buildPhotosGrid(controller);
    }
  }

  Widget _buildAlbumsGrid(MediaPickerController controller, BuildContext context) {
    final albums = controller.filteredAlbums;
    if (albums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_album_outlined,
              size: 48,
              color: context.secondaryTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              'No albums found',
              style: TextStyle(
                color: context.secondaryTextColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return _buildAlbumCard(controller, albums[index], context);
      },
    );
  }

  Widget _buildAlbumCard(MediaPickerController controller, Album album, BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        if (controller.isSelectionMode.value) {
          controller.toggleAlbumSelection(album);
        } else {
          controller.loadPhotos(album: album);
        }
      },
      onLongPress: () {
        if (!controller.isSelectionMode.value) {
          controller.toggleSelectionMode();
        }
        controller.toggleAlbumSelection(album);
      },
      child: GlassmorphismContainer(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: controller.selectedAlbums.contains(album)
                ? context.selectedBackground
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: controller.selectedAlbums.contains(album)
                  ? context.selectedBorder
                  : Colors.transparent,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Album thumbnail
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.surfaceColor.withValues(alpha: 0.1),
                  ),
                  child: album.thumbnailUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            album.thumbnailUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => _buildAlbumPlaceholder(),
                          ),
                        )
                      : _buildAlbumPlaceholder(),
                ),
              ),
              const SizedBox(height: 8),
              // Album info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      album.name,
                      style: TextStyle(
                        color: context.primaryTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          _getSourceIcon(album.source),
                          size: 12,
                          color: context.secondaryTextColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${album.photoCount} photo${album.photoCount != 1 ? 's' : ''}',
                          style: TextStyle(
                            color: context.secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Selection indicator
              if (controller.isSelectionMode.value)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: controller.isAlbumSelected(album)
                          ? context.accentColor
                          : context.surfaceColor.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.accentColor,
                        width: 2,
                      ),
                    ),
                    child: controller.isAlbumSelected(album)
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildAlbumPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surfaceLight.withOpacity(0.1),
      ),
      child: const Center(
        child: Icon(
          Icons.photo_album_outlined,
          size: 32,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildPhotosGrid(MediaPickerController controller) {
    final photos = controller.filteredPhotos;
    
    if (photos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No photos found',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return _buildPhotoCard(controller, photos[index]);
      },
    );
  }

  Widget _buildPhotoCard(MediaPickerController controller, Photo photo) {
    return Obx(() => GestureDetector(
      onTap: () {
        if (controller.isSelectionMode.value) {
          controller.togglePhotoSelection(photo);
        } else {
          // Open photo viewer or start selection mode
          controller.toggleSelectionMode();
          controller.togglePhotoSelection(photo);
        }
      },
      onLongPress: () {
        if (!controller.isSelectionMode.value) {
          controller.toggleSelectionMode();
        }
        controller.togglePhotoSelection(photo);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Photo
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: photo.thumbnailUrl.isNotEmpty
                ? Image.network(
                    photo.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceLight.withOpacity(0.1),
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : Container(
                    color: AppColors.surfaceLight.withOpacity(0.1),
                    child: const Icon(
                      Icons.photo,
                      color: AppColors.textSecondary,
                    ),
                  ),
          ),
          
          // Video indicator
          if (photo.isVideo)
            const Positioned(
              bottom: 4,
              left: 4,
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
          
          // Selection overlay and indicator
          if (controller.isSelectionMode.value) ...[
            // Overlay
            if (controller.isPhotoSelected(photo))
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.accent.withOpacity(0.3),
                ),
              ),
            
            // Selection indicator
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: controller.isPhotoSelected(photo)
                      ? AppColors.accent
                      : AppColors.surface.withOpacity(0.7),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accent,
                    width: 1.5,
                  ),
                ),
                child: controller.isPhotoSelected(photo)
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      )
                    : null,
              ),
            ),
          ],
        ],
      ),
    ));
  }

  IconData _getSourceIcon(String source) {
    switch (source) {
      case 'local':
        return Icons.phone_iphone;
      case 'google_photos':
        return Icons.cloud;
      case 'flickr':
        return Icons.camera_alt;
      default:
        return Icons.photo;
    }
  }

  void _onDone() {
    final controller = Get.find<MediaPickerController>();
    final selectedPhotos = controller.getSelectedMediaForSlideshow();
    
    // Return the selected photos
    Get.back(result: selectedPhotos);
  }
}
