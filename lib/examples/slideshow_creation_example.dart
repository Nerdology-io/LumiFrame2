import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/media_picker_helper.dart';
import '../models/photo.dart';
import '../theme/app_colors.dart';
import '../theme/glassmorphism_container.dart';

class SlideshowCreationExample extends StatefulWidget {
  const SlideshowCreationExample({Key? key}) : super(key: key);

  @override
  State<SlideshowCreationExample> createState() => _SlideshowCreationExampleState();
}

class _SlideshowCreationExampleState extends State<SlideshowCreationExample> {
  List<Photo> selectedPhotos = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create Slideshow',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Select Photos & Videos',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose photos from your device, Google Photos, or Flickr',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Media Selection Card
            GlassmorphismContainer(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Select Media Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _selectMedia,
                        icon: const Icon(Icons.photo_library),
                        label: Text(
                          selectedPhotos.isEmpty 
                              ? 'Select Photos & Videos'
                              : 'Selected ${selectedPhotos.length} items',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Quick Selection Options
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickSelectButton(
                            'Local Photos',
                            Icons.phone_iphone,
                            () => _selectFromSource('local'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildQuickSelectButton(
                            'Google Photos',
                            Icons.cloud,
                            () => _selectFromSource('google'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildQuickSelectButton(
                            'Flickr',
                            Icons.camera_alt,
                            () => _selectFromSource('flickr'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Selected Photos Preview
            if (selectedPhotos.isNotEmpty) ...[
              Text(
                'Selected Media (${selectedPhotos.length})',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: selectedPhotos.length,
                  itemBuilder: (context, index) {
                    final photo = selectedPhotos[index];
                    return _buildPhotoPreview(photo, index);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Create Slideshow Button
            if (selectedPhotos.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _createSlideshow,
                  icon: const Icon(Icons.slideshow),
                  label: const Text('Create Slideshow'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickSelectButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.border.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPhotoPreview(Photo photo, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: photo.thumbnailUrl.isNotEmpty
              ? Image.network(
                  photo.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.surfaceLight.withOpacity(0.3),
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.textSecondary,
                    ),
                  ),
                )
              : Container(
                  color: AppColors.surfaceLight.withOpacity(0.3),
                  child: const Icon(
                    Icons.photo,
                    color: AppColors.textSecondary,
                  ),
                ),
        ),
        
        // Source indicator
        Positioned(
          top: 4,
          left: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              _getSourceIcon(photo.metadata?['source'] ?? ''),
              size: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        
        // Remove button
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _removePhoto(index),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 14,
              ),
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
              size: 16,
            ),
          ),
      ],
    );
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
  
  Future<void> _selectMedia() async {
    final photos = await MediaPickerHelper.pickMedia(
      allowMultiple: true,
      showVideos: true,
      showPhotos: true,
    );
    
    if (photos != null) {
      setState(() {
        selectedPhotos = photos;
      });
    }
  }
  
  Future<void> _selectFromSource(String source) async {
    List<Photo>? photos;
    
    switch (source) {
      case 'local':
        photos = await MediaPickerHelper.pickLocalPhotos();
        break;
      case 'google':
        photos = await MediaPickerHelper.pickGooglePhotos();
        break;
      case 'flickr':
        // You could add a specific Flickr picker method
        photos = await MediaPickerHelper.pickMedia();
        break;
    }
    
    if (photos != null) {
      setState(() {
        // Add to existing selection or replace?
        // For demo, we'll add to existing
        selectedPhotos.addAll(photos!);
        // Remove duplicates
        selectedPhotos = selectedPhotos.toSet().toList();
      });
    }
  }
  
  void _removePhoto(int index) {
    setState(() {
      selectedPhotos.removeAt(index);
    });
  }
  
  void _createSlideshow() {
    // Navigate to slideshow screen with selected photos
    Get.snackbar(
      'Slideshow Created',
      'Created slideshow with ${selectedPhotos.length} photos',
      backgroundColor: AppColors.accent,
      colorText: Colors.white,
    );
    
    // Example: Navigate to slideshow player
    // Get.to(() => SlideshowPlayerScreen(photos: selectedPhotos));
  }
}
