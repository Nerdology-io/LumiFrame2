import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' show ImageFilter;
import '../../controllers/theme_controller.dart';
import '../../utils/constants.dart';
import '../../services/media_auth_service.dart';
import '../../widgets/glassmorphism_dialog.dart';

class MediaSourceSelectionOnboarding extends StatefulWidget {
  const MediaSourceSelectionOnboarding({super.key});

  @override
  State<MediaSourceSelectionOnboarding> createState() => _MediaSourceSelectionOnboardingState();
}

class _MediaSourceSelectionOnboardingState extends State<MediaSourceSelectionOnboarding>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _connectionController;
  
  late MediaAuthService _authService;
  
  final List<MediaSource> _mediaSources = [
    MediaSource(
      name: 'Google Photos',
      icon: Icons.photo_library,
      color: const Color(0xFF4285F4),
      description: 'Sync your Google Photos library',
      isConnected: false,
      sourceType: MediaSourceType.googlePhotos,
    ),
    MediaSource(
      name: 'iCloud Photos',
      icon: Icons.cloud,
      color: const Color(0xFF007AFF),
      description: 'Access your iCloud photo collection',
      isConnected: false,
      sourceType: MediaSourceType.iCloud,
    ),
    MediaSource(
      name: 'Device Gallery',
      icon: Icons.photo,
      color: const Color(0xFF34C759),
      description: 'Use photos from this device',
      isConnected: false, // Will be updated from auth service
      sourceType: MediaSourceType.deviceGallery,
    ),
    MediaSource(
      name: 'Instagram',
      icon: Icons.camera_alt,
      color: const Color(0xFFE4405F),
      description: 'Import from your Instagram',
      isConnected: false,
      sourceType: MediaSourceType.instagram,
    ),
    MediaSource(
      name: 'Dropbox',
      icon: Icons.folder,
      color: const Color(0xFF0061FF),
      description: 'Connect your Dropbox photos',
      isConnected: false,
      sourceType: MediaSourceType.dropbox,
    ),
    MediaSource(
      name: 'OneDrive',
      icon: Icons.cloud_upload,
      color: const Color(0xFF0078D4),
      description: 'Sync with Microsoft OneDrive',
      isConnected: false,
      sourceType: MediaSourceType.oneDrive,
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize auth service
    _authService = Get.find<MediaAuthService>();
    
    // Add app lifecycle observer to detect when returning from Settings
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _connectionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _pulseController.repeat();
    
    // Update media sources based on auth service state
    _updateConnectionStates();
    
    // Listen to auth service changes - access the reactive properties directly
    ever(_authService.isGooglePhotosConnectedRx, (_) => _updateConnectionStates());
    ever(_authService.isDeviceGalleryConnectedRx, (_) => _updateConnectionStates());
  }
  
  void _updateConnectionStates() {
    // Don't auto-update connection states during onboarding
    // Let users explicitly choose their media sources by tapping buttons
    // The isConnected state will only be set when users actively tap the buttons
    print('📱 MediaSourceSelection: Skipping auto-connection updates during onboarding');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    _connectionController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // When app becomes active again (e.g., returning from Settings)
    if (state == AppLifecycleState.resumed) {
      // Recheck permissions to see if user enabled them in Settings
      _authService.recheckPermissions();
    }
  }

  void _toggleConnection(int index) async {
    final source = _mediaSources[index];
    
    if (source.isConnected) {
      // Handle disconnection
      switch (source.sourceType) {
        case MediaSourceType.googlePhotos:
          await _authService.disconnectFromGooglePhotos();
          break;
        case MediaSourceType.deviceGallery:
          await _authService.disconnectFromDeviceGallery();
          break;
        default:
          // For other sources, show coming soon message
          _showComingSoonMessage(source.name);
          return;
      }
      
      // Update local state
      setState(() {
        _mediaSources[index] = _mediaSources[index].copyWith(isConnected: false);
      });
    } else {
      // Handle connection
      bool success = false;
      switch (source.sourceType) {
        case MediaSourceType.googlePhotos:
          print('🔗 Connecting to Google Photos...');
          success = await _authService.connectToGooglePhotos();
          break;
        case MediaSourceType.deviceGallery:
          print('🔗 Connecting to Device Gallery...');
          success = await _authService.connectToDeviceGallery();
          break;
        default:
          // For other sources, show coming soon message
          _showComingSoonMessage(source.name);
          return;
      }
      
      // Update local state only if connection was successful
      if (success) {
        setState(() {
          _mediaSources[index] = _mediaSources[index].copyWith(isConnected: true);
        });
      }
    }
    
    _connectionController.reset();
    _connectionController.forward();
  }
  
  void _showComingSoonMessage(String sourceName) {
    GlassmorphismSnackbar.show(
      title: 'Coming Soon',
      message: '$sourceName integration will be available in a future update.',
      icon: Icons.info_outline,
      iconColor: Colors.orange,
    );
  }

  int get _connectedCount => _mediaSources.where((source) => source.isConnected).length;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1a1a2e),
                    const Color(0xFF16213e),
                    const Color(0xFF0f3460),
                  ]
                : [
                    const Color(0xFFf0f8ff),
                    const Color(0xFFe6f3ff),
                    const Color(0xFFcce7ff),
                  ],
          ),
        ),
        child: Stack(
          children: [
            // Header
            Positioned(
              top: MediaQuery.of(context).padding.top + (isLandscape ? 24 : 40), // Increased spacing
              left: 20,
              right: 20,
              child: AnimatedBuilder(
                animation: _fadeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeController.value,
                    child: Column(
                      children: [
                        // Header section with improved clarity
            Column(
              children: [
                Text(
                  'Where Are Your Memories?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Connect your photo sources (optional)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: (isDark ? Colors.white : Colors.black87).withOpacity(0.7),
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'You can set this up later in Settings',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: (isDark ? Colors.white : Colors.black87).withOpacity(0.5),
                    letterSpacing: 0.3,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Media sources grid - centered between header and continue button
            Positioned.fill(
              top: isLandscape ? screenHeight * 0.32 : screenHeight * 0.2, // Adjusted positioning
              bottom: isLandscape ? 90 : 140, // Increased bottom spacing to accommodate new button position
              child: AnimatedBuilder(
                animation: _slideController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - _slideController.value)),
                    child: Opacity(
                      opacity: _slideController.value,
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: screenHeight * 0.5, // Limit max height
                            maxWidth: MediaQuery.of(context).size.width - 32,
                          ),
                          child: _buildMediaSourcesGrid(isDark, isLandscape),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Continue button positioned at bottom edge of screen
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _fadeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeController.value,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        left: 32,
                        right: 32,
                        top: 32,
                        bottom: MediaQuery.of(context).padding.bottom + 32,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            (isDark ? Colors.black : Colors.white).withOpacity(0.1),
                            (isDark ? Colors.black : Colors.white).withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Connection status
                          if (_connectedCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFF34C759).withOpacity(0.1),
                                border: Border.all(
                                  color: const Color(0xFF34C759).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '$_connectedCount source${_connectedCount == 1 ? '' : 's'} connected',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF34C759),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  (isDark ? Colors.white : Colors.black).withOpacity(0.15),
                                  (isDark ? Colors.white : Colors.black).withOpacity(0.08),
                                  (isDark ? Colors.white : Colors.black).withOpacity(0.05),
                                ],
                              ),
                              border: Border.all(
                                color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppConstants.primaryColor.withOpacity(0.3),
                                  blurRadius: 25,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 8),
                                ),
                                BoxShadow(
                                  color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppConstants.primaryColor.withOpacity(0.2),
                                        AppConstants.accentColor.withOpacity(0.15),
                                        AppConstants.primaryColor.withOpacity(0.1),
                                      ],
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                                      onTap: () {
                                        // Navigate to personalization screen whether sources are connected or not
                                        Get.toNamed('/onboarding/personalization');
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(vertical: 18),
                                        child: Text(
                                          _connectedCount > 0 ? 'Continue' : 'Skip for Now',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: isDark ? Colors.white : Colors.white,
                                            letterSpacing: 1,
                                            shadows: [
                                              Shadow(
                                                offset: const Offset(0, 2),
                                                blurRadius: 8,
                                                color: Colors.black.withOpacity(0.3),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaSourcesGrid(bool isDark, bool isLandscape) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true, // Allow grid to size itself based on content
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling since it's centered
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 3 : 2, // 3 columns in landscape, 2 in portrait
        childAspectRatio: isLandscape ? 1.4 : 1.3, // Increased aspect ratio to make cards shorter
        crossAxisSpacing: isLandscape ? 12 : 16,
        mainAxisSpacing: isLandscape ? 12 : 16,
      ),
      itemCount: _mediaSources.length,
      itemBuilder: (context, index) {
        return _buildMediaSourceCard(_mediaSources[index], index, isDark, isLandscape);
      },
    );
  }

  Widget _buildMediaSourceCard(MediaSource source, int index, bool isDark, bool isLandscape) {
    return AnimatedBuilder(
      animation: _connectionController,
      builder: (context, child) {
        return Transform.scale(
          scale: source.isConnected ? 1.0 + (_connectionController.value * 0.05) : 1.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                  (isDark ? Colors.white : Colors.black).withOpacity(0.05),
                ],
              ),
              border: Border.all(
                color: source.isConnected 
                    ? source.color.withOpacity(0.6)
                    : (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                width: source.isConnected ? 2 : 1.5,
              ),
              boxShadow: source.isConnected ? [
                BoxShadow(
                  color: source.color.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
              ] : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: source.isConnected ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        source.color.withOpacity(0.1),
                        source.color.withOpacity(0.05),
                      ],
                    ) : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                      onTap: () => _toggleConnection(index),
                      child: Padding(
                        padding: EdgeInsets.all(isLandscape ? 8 : 12), // Reduced padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon with connection indicator
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(isLandscape ? 8 : 12), // Reduced padding
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        source.color.withOpacity(0.2),
                                        source.color.withOpacity(0.1),
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    source.icon,
                                    size: isLandscape ? 20 : 28, // Reduced icon size
                                    color: source.isConnected 
                                        ? source.color 
                                        : (isDark ? Colors.white : Colors.black87).withOpacity(0.7),
                                  ),
                                ),
                                if (source.isConnected)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: AnimatedBuilder(
                                      animation: _pulseController,
                                      builder: (context, child) {
                                        return Container(
                                          width: isLandscape ? 14 : 18, // Reduced indicator size
                                          height: isLandscape ? 14 : 18, // Reduced indicator size
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: const Color(0xFF34C759),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF34C759).withOpacity(0.6 * _pulseController.value),
                                                blurRadius: 8 * _pulseController.value,
                                                spreadRadius: 2 * _pulseController.value,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            size: isLandscape ? 10 : 12,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: isLandscape ? 4 : 6), // Reduced spacing
                            
                            // Source name
                            Flexible(
                              child: Text(
                                source.name,
                                style: TextStyle(
                                  fontSize: isLandscape ? 12 : 14, // Reduced font size
                                  fontWeight: FontWeight.w600,
                                  color: source.isConnected 
                                      ? source.color 
                                      : (isDark ? Colors.white : Colors.black87),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: isLandscape ? 1 : 2), // Reduced spacing
                            
                            // Description
                            Flexible(
                              child: Text(
                                source.description,
                                style: TextStyle(
                                  fontSize: isLandscape ? 9 : 11, // Reduced font size
                                  fontWeight: FontWeight.w300,
                                  color: (isDark ? Colors.white : Colors.black87).withOpacity(0.6),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum MediaSourceType {
  googlePhotos,
  iCloud,
  deviceGallery,
  instagram,
  dropbox,
  oneDrive,
}

class MediaSource {
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final bool isConnected;
  final MediaSourceType sourceType;

  MediaSource({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
    required this.isConnected,
    required this.sourceType,
  });
  
  MediaSource copyWith({
    String? name,
    IconData? icon,
    Color? color,
    String? description,
    bool? isConnected,
    MediaSourceType? sourceType,
  }) {
    return MediaSource(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      description: description ?? this.description,
      isConnected: isConnected ?? this.isConnected,
      sourceType: sourceType ?? this.sourceType,
    );
  }
}
