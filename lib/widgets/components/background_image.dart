import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagePath; // Path to the background image

  const BackgroundImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath), // Assuming assets are in pubspec.yaml
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}