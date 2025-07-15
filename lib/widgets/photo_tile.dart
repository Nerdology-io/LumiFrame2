import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lumiframe/models/photo.dart';

class PhotoTile extends StatelessWidget {
  final Photo photo;

  const PhotoTile({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open full view or add to slideshow
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CachedNetworkImage(
            imageUrl: photo.url,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          if (photo.isVideo)
            const Icon(Icons.play_circle_outline, color: Colors.white, size: 32),
        ],
      ),
    );
  }
}