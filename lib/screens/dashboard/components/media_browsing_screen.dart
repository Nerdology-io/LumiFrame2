import 'package:flutter/material.dart';
import '../../../data/repositories/photo_repo.dart';
import '../../../widgets/photo_tile.dart'; // Assume this exists for displaying photos
import '../../../models/photo.dart';


class MediaBrowsingScreen extends StatelessWidget {
  const MediaBrowsingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final photoRepo = PhotoRepo(); // Or inject via Get if needed

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Media Browsing'), backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          // Edge-to-edge background

          SafeArea(
            child: FutureBuilder<List<Photo>>(
              future: photoRepo.getPhotos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final photos = snapshot.data ?? [];
                if (photos.isEmpty) {
                  return const Center(child: Text('No media found. Add some photos!'));
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return PhotoTile(photo: photos[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger photo upload/pick
          photoRepo.uploadPhoto('path/to/photo'); // Example
        },
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }
}