import 'package:flutter/material.dart';
import '../../../data/repositories/photo_repo.dart';
import '../../../widgets/photo_tile.dart'; // Assume this exists for displaying photos
import '../../../models/photo.dart';
import 'package:get/get.dart';
import '../../../services/media_service.dart';
import '../../../services/firebase_service.dart';


class MediaBrowsingScreen extends StatelessWidget {
  const MediaBrowsingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Register required services
    if (!Get.isRegistered<MediaService>()) {
      Get.put(MediaService());
    }
    if (!Get.isRegistered<FirebaseService>()) {
      Get.put(FirebaseService());
    }
    
    final photoRepo = PhotoRepo(); // Or inject via Get if needed

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.onBackground;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: FutureBuilder<List<Photo>>(
          future: photoRepo.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                  backgroundColor: theme.colorScheme.surface,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: theme.textTheme.bodyLarge?.copyWith(color: primaryColor),
                ),
              );
            }
            final photos = snapshot.data ?? [];
            if (photos.isEmpty) {
              return Center(
                child: Text(
                  'No media found. Add some photos!',
                  style: theme.textTheme.bodyLarge?.copyWith(color: primaryColor),
                ),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: PhotoTile(photo: photo)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              photo.metadata?['filename'] ?? '',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.phone_iphone, size: 12, color: secondaryColor),
                                const SizedBox(width: 4),
                                Text(
                                  photo.isVideo ? 'Video' : 'Photo',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: secondaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger photo upload/pick
          photoRepo.uploadPhoto('path/to/photo'); // Example
        },
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }
}