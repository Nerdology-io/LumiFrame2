import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class SlideshowController extends GetxController {
  final box = GetStorage();

  var shuffle = false.obs;
  var slideDuration = 5.obs; // seconds
  var transitionType = "fade".obs;
  var enablePhotos = true.obs;
  var enableVideos = true.obs;
  var transitionSpeed = "medium".obs;
  var autoPlay = true.obs;
  var isPlaying = true.obs;
  var muteAudio = false.obs;
  var defaultVolume = 0.5.obs;
  var backgroundEffect = "blur".obs;
  var backgroundCustomColor = Rx<Color>(Colors.black);
  var photoAnimation = "none".obs;
  var contentMode = "fit".obs;
  var currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    shuffle.value = box.read('shuffle') ?? false;
    slideDuration.value = box.read('slideDuration') ?? 5;
    transitionType.value = box.read('transitionType') ?? "fade";
    enablePhotos.value = box.read('enablePhotos') ?? true;
    enableVideos.value = box.read('enableVideos') ?? true;
    transitionSpeed.value = box.read('transitionSpeed') ?? "medium";
    autoPlay.value = box.read('autoPlay') ?? true;
    isPlaying.value = box.read('isPlaying') ?? true;
    muteAudio.value = box.read('muteAudio') ?? false;
    defaultVolume.value = box.read('defaultVolume') ?? 0.5;
    backgroundEffect.value = box.read('backgroundEffect') ?? "blur";
    photoAnimation.value = box.read('photoAnimation') ?? "none";
    contentMode.value = box.read('contentMode') ?? "fit";
    final savedColor = box.read('backgroundCustomColor');
    if (savedColor != null) {
      backgroundCustomColor.value = Color(int.parse(savedColor, radix: 16));
    }

    ever(shuffle, (val) => box.write('shuffle', val));
    ever(slideDuration, (val) => box.write('slideDuration', val));
    ever(transitionType, (val) => box.write('transitionType', val));
    ever(enablePhotos, (val) => box.write('enablePhotos', val));
    ever(enableVideos, (val) => box.write('enableVideos', val));
    ever(transitionSpeed, (val) => box.write('transitionSpeed', val));
    ever(autoPlay, (val) => box.write('autoPlay', val));
    ever(isPlaying, (val) => box.write('isPlaying', val));
    ever(muteAudio, (val) => box.write('muteAudio', val));
    ever(defaultVolume, (val) => box.write('defaultVolume', val));
    ever(backgroundEffect, (val) => box.write('backgroundEffect', val));
    ever(photoAnimation, (val) => box.write('photoAnimation', val));
    ever(contentMode, (val) => box.write('contentMode', val));
    // ignore: deprecated_member_use
    ever(backgroundCustomColor, (color) => box.write('backgroundCustomColor', color.value.toRadixString(16)));
  }

  void resetPage() {
    currentPage.value = 0;
  }

  bool nextPage(int length) {
    if (currentPage.value < length - 1) {
      currentPage.value++;
      return false;
    } else {
      currentPage.value = 0;
      return true;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void setShuffle(bool val) {
    shuffle.value = val;
  }

  void setMuteAudio(bool val) {
    muteAudio.value = val;
  }

  void setDefaultVolume(double val) {
    defaultVolume.value = val;
  }

  void setBackgroundCustomColor(Color color) {
    backgroundCustomColor.value = color;
  }

  void setBackgroundEffect(String effect) {
    backgroundEffect.value = effect;
  }

  void setPhotoAnimation(String animation) {
    photoAnimation.value = animation;
  }

  void setContentMode(String mode) {
    contentMode.value = mode;
  }

  void setTransitionType(String type) {
    transitionType.value = type;
  }

  void setTransitionSpeed(String speed) {
    transitionSpeed.value = speed;
  }

  void setAutoPlay(bool val) {
    autoPlay.value = val;
  }

  void setEnablePhotos(bool val) {
    enablePhotos.value = val;
  }

  void setEnableVideos(bool val) {
    enableVideos.value = val;
  }
  
  void setSlideDuration(int val) {
    slideDuration.value = val;
  }
}