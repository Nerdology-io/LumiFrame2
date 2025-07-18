import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../../services/cast_service.dart';


class CastScreen extends StatelessWidget {
  const CastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final castService = Get.find<CastService>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Cast Devices'), backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          // Edge-to-edge background

          SafeArea(
            child: Obx(() {
              if (castService.availableDevices.isEmpty) {
                return const Center(child: Text('No devices found. Ensure casting is enabled.'));
              }
              return ListView.builder(
                itemCount: castService.availableDevices.length,
                itemBuilder: (context, index) {
                  final device = castService.availableDevices[index];
                  return ListTile(
                    title: Text(device.name),
                    subtitle: Text(device.type.toString()),
                    trailing: Icon(
                      castService.connectedDevice.value?.id == device.id ? Icons.cast_connected : Icons.cast,
                    ),
                    onTap: () {
                      if (castService.connectedDevice.value?.id == device.id) {
                        castService.disconnect();
                      } else {
                        castService.connectToDevice(device);
                      }
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}