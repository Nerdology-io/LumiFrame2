import 'package:get/get.dart';

class CastDevice {
  final String id;
  final String name;
  final String type;

  CastDevice({required this.id, required this.name, required this.type});
}

class CastService extends GetxService {
  final availableDevices = <CastDevice>[].obs;
  final connectedDevice = Rxn<CastDevice>();

  void connectToDevice(CastDevice device) {
    connectedDevice.value = device;
    // Add actual connection logic here
  }

  void disconnect() {
    connectedDevice.value = null;
    // Add actual disconnect logic here
  }
}
