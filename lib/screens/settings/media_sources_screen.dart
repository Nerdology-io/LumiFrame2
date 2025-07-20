import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/photo_repo.dart';

class MediaSourcesScreen extends StatelessWidget {
  const MediaSourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final photoRepo = PhotoRepo();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SwitchListTile(
              title: const Text('Local Storage'),
              value: true, // Bind to setting
              onChanged: (val) {},
            ),
            SwitchListTile(
              title: const Text('Google Photos'),
              value: false,
              onChanged: (val) {},
            ),
            SwitchListTile(
              title: const Text('Flickr'),
              value: false,
              onChanged: (val) {},
            ),
            ElevatedButton(
              onPressed: () async {
                await photoRepo.getPhotos(localOnly: false); // Trigger sync
                Get.snackbar('Media Synced', 'Media sources updated.');
              },
              child: const Text('Sync Now'),
            ),
          ],
        ),
      ),
    );
  }
}