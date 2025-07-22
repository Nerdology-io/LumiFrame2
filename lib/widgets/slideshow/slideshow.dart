import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import '../../controllers/slideshow_controller.dart';
import '../../controllers/advanced_settings_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

// Custom transition for AnimatedSwitcher to animate both incoming and outgoing children
class SlideTransitionX extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final bool isIncoming;
  final Offset beginOffset;
  final Offset endOffset;

  const SlideTransitionX({
    required this.animation,
    required this.child,
    required this.isIncoming,
    required this.beginOffset,
    required this.endOffset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final offsetTween = isIncoming
        ? Tween<Offset>(begin: beginOffset, end: endOffset)
        : Tween<Offset>(begin: endOffset, end: beginOffset);
    return SlideTransition(
      position: offsetTween.animate(animation),
      child: child,
    );
  }
}

class Slideshow extends StatefulWidget {
  const Slideshow({super.key});

  @override
  State<Slideshow> createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  final slideshowController = Get.find<SlideshowController>();
  final List<String> slideshowItems = [
    "https://www.caseyscaptures.com/wp-content/uploads/DSC00785-Edit-3000-min.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DI9A4781-v2-3000@70-2.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC08653-3000-min.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC04799-3000.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSCF0728-3000@70v2.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC03479-C1-3000@VeryGood.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC04498-Edit.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSCF2743-3000@70.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC00801-3000-min.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC06999-3000v2-min.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC04863-3000-min.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC08885-3000-min.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSCF8411-3000@70v2-900px.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DSC04907-3000.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/DI9A9578-3000@80.jpg",
    "https://www.caseyscaptures.com/wp-content/uploads/IMG_6767-3000@70.jpg",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  ];

  Timer? _autoPlayTimer;
  List<String> _shuffledItems = [];
  List<String> _filteredItems = [];

  // For fading UI buttons
  double _buttonOpacity = 1.0;
  Timer? _fadeTimer;

  @override
  void initState() {
    super.initState();
    _applyFilters();
    _setupTimer();
    _resetFadeTimer();

    // Re-create the timer if settings change
    ever(slideshowController.shuffle, (bool isShuffled) {
      _applyFilters();
      slideshowController.resetPage();
      _setupTimer();
    });
    ever(slideshowController.slideDuration, (_) => _setupTimer());
    ever(slideshowController.transitionType, (_) {
      if (mounted) setState(() {});
    });
    ever(slideshowController.enablePhotos, (_) => _applyFiltersAndReset());
    ever(slideshowController.enableVideos, (_) => _applyFiltersAndReset());
  }

  Duration get _transitionDuration {
    switch (slideshowController.transitionSpeed.value) {
      case "slow":
        return const Duration(milliseconds: 1500);
      case "fast":
        return const Duration(milliseconds: 400);
      case "medium":
      default:
        return const Duration(milliseconds: 800);
    }
  }

  void _applyFilters() {
    if (!mounted) return;
    setState(() {
      _filteredItems = slideshowItems.where((item) {
        final isVideo = _isVideo(item);
        if (slideshowController.enablePhotos.value && !isVideo) {
          return true;
        }
        if (slideshowController.enableVideos.value && isVideo) {
          return true;
        }
        return false;
      }).toList();

      if (slideshowController.shuffle.value) {
        _shuffleItems();
      }
    });
  }

  void _applyFiltersAndReset() {
    _applyFilters();
    slideshowController.resetPage();
    _setupTimer();
  }

  void _shuffleItems() {
    _shuffledItems = List.from(_filteredItems);
    _shuffledItems.shuffle();
  }

  void _setupTimer() {
    _autoPlayTimer?.cancel();
    if (mounted && _filteredItems.isNotEmpty) {
      _autoPlayTimer = Timer.periodic(
        Duration(seconds: slideshowController.slideDuration.value),
        (timer) {
          if (!mounted || !slideshowController.isPlaying.value) return;

          final activeItems = slideshowController.shuffle.value ? _shuffledItems : _filteredItems;
          if (activeItems.isEmpty || _isVideo(activeItems[slideshowController.currentPage.value])) return;

          final didWrap = slideshowController.nextPage(activeItems.length);
          if (didWrap && slideshowController.shuffle.value) {
            _shuffleItems();
          }
        },
      );
    }
  }

  void _resetTimer() {
    _setupTimer();
  }

  void _resetFadeTimer() {
    _fadeTimer?.cancel();
    setState(() => _buttonOpacity = 1.0);
    _fadeTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _buttonOpacity = 0.2);
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _fadeTimer?.cancel();
    slideshowController.resetPage(); // Reset the page index
    super.dispose();
  }

  Widget _buildFlipTransition(Widget child, Animation<double> animation) {
    final rotation = Tween(begin: 0.0, end: 1.0).animate(animation);

    return AnimatedBuilder(
      animation: rotation,
      builder: (context, widget) {
        final isUnder = (ValueKey(widget) != child.key);
        var tilt = ((rotation.value - 0.5).abs() - 0.5) * 0.003;
        tilt = tilt < 0.0 ? 0.0 : tilt;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, tilt)
            ..rotateY(pi * rotation.value),
          alignment: Alignment.center,
          child: isUnder
              ? Transform(
                  transform: Matrix4.identity()..rotateY(pi),
                  alignment: Alignment.center,
                  child: widget,
                )
              : widget,
        );
      },
    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final transitionType = slideshowController.transitionType.value;
    final isReverse = animation.status == AnimationStatus.reverse;

    switch (transitionType.toLowerCase()) {
      case 'slide_left':
        return SlideTransitionX(
          animation: animation,
          isIncoming: !isReverse,
          beginOffset: const Offset(1, 0),
          endOffset: Offset.zero,
          child: child,
        );
      case 'slide_right':
        return SlideTransitionX(
          animation: animation,
          isIncoming: !isReverse,
          beginOffset: const Offset(-1, 0),
          endOffset: Offset.zero,
          child: child,
        );
      case 'slide_up':
        return SlideTransitionX(
          animation: animation,
          isIncoming: !isReverse,
          beginOffset: const Offset(0, 1),
          endOffset: Offset.zero,
          child: child,
        );
      case 'slide_down':
        return SlideTransitionX(
          animation: animation,
          isIncoming: !isReverse,
          beginOffset: const Offset(0, -1),
          endOffset: Offset.zero,
          child: child,
        );
      case 'flip':
        return _buildFlipTransition(child, animation);
      case 'fade':
      default:
        return FadeTransition(opacity: animation, child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // By wrapping the GestureDetector in Obx, the drag callbacks will always
      // have the most up-to-date 'activeItems' list, fixing the shuffle bug.
      final activeItems = slideshowController.shuffle.value ? _shuffledItems : _filteredItems;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _resetFadeTimer,
        onPanDown: (_) => _resetFadeTimer(),
        onHorizontalDragEnd: (details) {
          if (activeItems.isEmpty) return;
          if (details.primaryVelocity! > 0) {
            slideshowController.previousPage();
            _resetTimer();
          } else if (details.primaryVelocity! < 0) {
            final didWrap = slideshowController.nextPage(activeItems.length);
            if (didWrap && slideshowController.shuffle.value) {
              _shuffleItems();
            }
            _resetTimer();
          }
        },
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 200) {
            Get.back();
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Stack(
            children: [
              if (activeItems.isEmpty)
                Center(
                  child: Text(
                    'No items to display. Check your filter settings.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                    ),
                  ),
                )
              else
                AnimatedSwitcher(
                  duration: _transitionDuration,
                  transitionBuilder: _transitionBuilder,
                  child: Stack(
                    // Using Obx value for the key ensures AnimatedSwitcher works correctly
                    key: ValueKey<String>(activeItems[slideshowController.currentPage.value]),
                    children: [
                      _buildBackground(activeItems[slideshowController.currentPage.value]),
                      Center(
                        child: _isVideo(activeItems[slideshowController.currentPage.value])
                            ? _VideoPlayerItem(
                                key: ValueKey<String>(activeItems[slideshowController.currentPage.value]),
                                path: activeItems[slideshowController.currentPage.value],
                                itemCount: activeItems.length,
                              )
                            : _AnimatedPhoto(
                                path: activeItems[slideshowController.currentPage.value],
                                duration: _transitionDuration,
                              ),
                      ),
                    ],
                  ),
                ),
              // Close button (top right, styled like mute, smaller, fade)
              Positioned(
                top: 40,
                right: 20,
                child: SafeArea(
                  child: AnimatedOpacity(
                    opacity: _buttonOpacity,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 32),
                        iconSize: 44,
                        onPressed: () => Get.back(),
                        tooltip: 'Close',
                      ),
                    ),
                  ),
                ),
              ),
              // Mute button (top left, smaller, fade, main UI only)
              if (_isVideo(activeItems[slideshowController.currentPage.value]))
                Positioned(
                  top: 40,
                  left: 20,
                  child: SafeArea(
                    child: AnimatedOpacity(
                      opacity: _buttonOpacity,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            slideshowController.muteAudio.value ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                            size: 32,
                          ),
                          iconSize: 44,
                          onPressed: () {
                            final newMute = !slideshowController.muteAudio.value;
                            slideshowController.setMuteAudio(newMute);
                          },
                          tooltip: slideshowController.muteAudio.value ? 'Unmute' : 'Mute',
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBackground(String imagePath) {
    final bgEffect = slideshowController.backgroundEffect.value;
    return bgEffect == "blur"
        ? _buildBlurredLayer(imagePath)
        : _buildSolidBackground(bgEffect);
  }

  Widget _buildBlurredLayer(String imagePath) {
    return Transform.scale(
      key: ValueKey<String>(imagePath),
      scale: 1.1,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: SizedBox.expand(
          child: CachedNetworkImage(
            imageUrl: imagePath,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.black),
            errorWidget: (context, url, error) => Container(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildSolidBackground(String colorName) {
    Color bgColor;
    switch (colorName) {
      case "white":
        bgColor = Colors.white;
        break;
      case "custom":
        bgColor = slideshowController.backgroundCustomColor.value;
        break;
      case "black":
      default:
        bgColor = Colors.black;
    }
    return Container(key: ValueKey<String>('$colorName-${bgColor.toARGB32()}'), color: bgColor);
  }

  bool _isVideo(String path) {
    return path.endsWith('.mp4') || path.endsWith('.mov') || path.endsWith('.avi');
  }
}

class _VideoPlayerItem extends StatefulWidget {
  final String path;
  final int itemCount;

  const _VideoPlayerItem({super.key, required this.path, required this.itemCount});

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<_VideoPlayerItem> {
  late VideoPlayerController _videoController;
  final SlideshowController _slideshowController = Get.find();
  Uint8List? _thumbnailBytes;
  bool _isGeneratingThumbnail = false;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.path))
      ..initialize().then((_) {
        setState(() {});
        _setVolume();
        if (_slideshowController.autoPlay.value) {
          _videoController.play();
        }
      });
    _videoController.addListener(_videoListener);
    ever(_slideshowController.muteAudio, (_) => _setVolume());
    ever(_slideshowController.defaultVolume, (_) => _setVolume());
  }

  Future<void> _generateThumbnail() async {
    if (!Get.isRegistered<AdvancedSettingsController>()) {
      Get.put(AdvancedSettingsController());
    }
    final advancedController = Get.find<AdvancedSettingsController>();
    
    if (!advancedController.useVideoThumbnail.value) return;
    
    setState(() {
      _isGeneratingThumbnail = true;
    });

    try {
      final thumbnailBytes = await VideoThumbnail.thumbnailData(
        video: widget.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 1920,
        quality: 85,
        timeMs: 1000, // Get frame at 1 second
      );
      
      if (mounted) {
        setState(() {
          _thumbnailBytes = thumbnailBytes;
          _isGeneratingThumbnail = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGeneratingThumbnail = false;
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant _VideoPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      // Reset thumbnail for new video
      _thumbnailBytes = null;
      _generateThumbnail();
      
      // Dispose old controller and listeners
      _videoController.removeListener(_videoListener);
      _videoController.dispose();
      // Create new controller for new path
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.path))
        ..initialize().then((_) {
          setState(() {});
          _setVolume();
          if (_slideshowController.autoPlay.value) {
            _videoController.play();
          }
        });
      _videoController.addListener(_videoListener);
    }
    // Do NOT call _setVolume here unless path changes
  }

  void _videoListener() {
    if (_videoController.value.position >= _videoController.value.duration && !_videoController.value.isBuffering) {
      final didWrap = _slideshowController.nextPage(widget.itemCount);
      if (didWrap && _slideshowController.shuffle.value) {
        // Optionally reshuffle here
      }
    }
  }

  void _setVolume() {
    if (!mounted) return;
    if (!_videoController.value.isInitialized) {
      return;
    }
    final isMuted = _slideshowController.muteAudio.value;
    final setTo = isMuted ? 0.0 : _slideshowController.defaultVolume.value;
    _videoController.setVolume(setTo).then((_) {
      if (!isMuted && !_videoController.value.isPlaying && _videoController.value.isInitialized) {
        _videoController.play();
      }
    });
  }

  @override
  void dispose() {
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      } else {
        _videoController.play();
        _setVolume(); // Ensure volume is set after play
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show thumbnail while video is not initialized
    if (!_videoController.value.isInitialized) {
      if (_thumbnailBytes != null) {
        return GestureDetector(
          onTap: () {
            // Do nothing during loading, or optionally show a message
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(_thumbnailBytes!),
                fit: BoxFit.contain,
              ),
            ),
            child: Stack(
              children: [
                // Optional: Add a subtle play icon overlay to indicate it's a video
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                // Loading indicator in bottom right
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        // Fallback: Show a simple placeholder while thumbnail is generating
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Center(
            child: _isGeneratingThumbnail
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Loading video...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                : const Icon(
                    Icons.videocam,
                    color: Colors.white54,
                    size: 64,
                  ),
          ),
        );
      }
    }
    
    // Video is initialized, show the actual video player
    return GestureDetector(
      onTap: _togglePlayPause,
      child: AspectRatio(
        aspectRatio: _videoController.value.aspectRatio,
        child: VideoPlayer(_videoController),
      ),
    );
  }
}

class _AnimatedPhoto extends StatefulWidget {
  final String path;
  final Duration duration;

  const _AnimatedPhoto({
    required this.path,
    required this.duration,
  });

  @override
  _AnimatedPhotoState createState() => _AnimatedPhotoState();
}

class _AnimatedPhotoState extends State<_AnimatedPhoto>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  final slideshowController = Get.find<SlideshowController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: slideshowController.slideDuration.value),
      vsync: this,
    );
    _setupAnimation();
    if (slideshowController.photoAnimation.value != 'none') {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedPhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _animationController.duration = Duration(seconds: slideshowController.slideDuration.value);
      _setupAnimation();
      if (slideshowController.photoAnimation.value != 'none') {
        _animationController.forward(from: 0.0);
      }
    }
  }

  void _setupAnimation() {
    final animationType = slideshowController.photoAnimation.value;
    double scaleBegin = 1.0, scaleEnd = 1.0;
    Offset slideBegin = Offset.zero, slideEnd = Offset.zero;

    switch (animationType) {
      case 'zoom_in':
        scaleEnd = 1.2;
        break;
      case 'zoom_out':
        scaleBegin = 1.2;
        break;
      case 'pan_left':
        scaleBegin = 1.2; // Zoom in to pan
        scaleEnd = 1.2;
        slideEnd = const Offset(-0.1, 0); // Pan left
        break;
      case 'pan_right':
        scaleBegin = 1.2;
        scaleEnd = 1.2;
        slideEnd = const Offset(0.1, 0); // Pan right
        break;
    }

    _scaleAnimation = Tween<double>(begin: scaleBegin, end: scaleEnd).animate(_animationController);
    _slideAnimation = Tween<Offset>(begin: slideBegin, end: slideEnd).animate(_animationController);

    if (animationType != 'none') {
      _animationController.forward(from: 0);
    } else {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      BoxFit getBoxFit() {
        final animationType = slideshowController.photoAnimation.value;
        final contentMode = slideshowController.contentMode.value.toLowerCase();

        // If any animation is active, 'cover' is needed to avoid black bars from clipping.
        if (animationType != 'none') {
          return BoxFit.cover;
        }

        switch (contentMode) {
          case 'fill':
            return BoxFit.cover;
          case 'stretch':
            return BoxFit.fill;
          case 'fit':
          default:
            return BoxFit.contain;
        }
      }

      return SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: CachedNetworkImage(
            key: ValueKey<String>(widget.path),
            imageUrl: widget.path,
            fit: getBoxFit(),
            placeholder: (context, url) => Container(), // No loading indicator
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, size: 64, color: Colors.red),
          ),
        ),
      );
    });
  }
}

