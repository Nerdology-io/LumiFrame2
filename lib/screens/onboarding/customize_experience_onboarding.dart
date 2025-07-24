import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import '../../../controllers/theme_controller.dart';
import '../../../utils/constants.dart';

class CustomizeExperienceOnboarding extends StatefulWidget {
  const CustomizeExperienceOnboarding({super.key});

  @override
  State<CustomizeExperienceOnboarding> createState() => _CustomizeExperienceOnboardingState();
}

class _CustomizeExperienceOnboardingState extends State<CustomizeExperienceOnboarding>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _photoController;
  late AnimationController _iconController;
  
  int _currentFeature = 0;
  final List<FeatureData> _features = [
    FeatureData(
      icon: Icons.photo_library_outlined,
      title: 'Your Memories',
      subtitle: 'Display your photos beautifully',
      description: 'Import from gallery, cloud storage, or social media',
      color: Colors.blue,
    ),
    FeatureData(
      icon: Icons.palette_outlined,
      title: 'Dynamic Themes',
      subtitle: 'Adapts to time and mood',
      description: 'Background changes throughout the day automatically',
      color: Colors.purple,
    ),
    FeatureData(
      icon: Icons.cast_outlined,
      title: 'Cast & Share',
      subtitle: 'Connect to any screen',
      description: 'Share memories on TV, displays, or other devices',
      color: Colors.green,
    ),
    FeatureData(
      icon: Icons.smart_display_outlined,
      title: 'Smart Display',
      subtitle: 'Intelligent photo management',
      description: 'AI-powered organization and automatic slideshows',
      color: Colors.orange,
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _photoController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    
    _iconController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    // Start animations
    _fadeController.forward();
    _slideController.forward();
    
    // Auto-cycle through features
    _startFeatureCycle();
  }

  void _startFeatureCycle() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _nextFeature();
        _startFeatureCycle();
      }
    });
  }

  void _nextFeature() {
    if (mounted) {
      setState(() {
        _currentFeature = (_currentFeature + 1) % _features.length;
      });
      _slideController.reset();
      _slideController.forward();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _photoController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
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
        child: isLandscape 
            ? _buildLandscapeLayout(isDark, screenWidth, screenHeight)
            : _buildPortraitLayout(isDark, screenWidth, screenHeight),
      ),
    );
  }

  Widget _buildPortraitLayout(bool isDark, double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Header
        Positioned(
          top: MediaQuery.of(context).padding.top + 40, // Increased from 16 to 40
          left: 20,
          right: 20,
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeController.value,
                child: Column(
                  children: [
                    Text(
                      'Customize Your Experience',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8), // Increased from 6 to 8
                    Text(
                      'Discover what makes LumiFrame special',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: (isDark ? Colors.white : Colors.black87).withOpacity(0.7),
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        
        // Mock phone frame
        Positioned(
          top: screenHeight * 0.22, // Adjusted from 0.18 to 0.22
          left: 20,
          right: 20,
          child: Center(
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 0.8 + (_fadeController.value * 0.15),
                  child: Opacity(
                    opacity: _fadeController.value,
                    child: _buildMockPhoneFrame(isDark),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Feature cards
        Positioned(
          bottom: 120,
          left: 0,
          right: 0,
          child: _buildFeatureSection(isDark),
        ),
        
        // Continue button
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 24,
          left: 24,
          right: 24,
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeController.value,
                child: _buildContinueButton(isDark),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(bool isDark, double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Header
        Positioned(
          top: MediaQuery.of(context).padding.top + 24, // Increased from 12 to 24
          left: 20,
          right: 20,
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeController.value,
                child: Column(
                  children: [
                    Text(
                      'Customize Your Experience',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6), // Increased from 4 to 6
                    Text(
                      'Discover what makes LumiFrame special',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: (isDark ? Colors.white : Colors.black87).withOpacity(0.7),
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        
        // Side-by-side layout for landscape
        Positioned(
          top: screenHeight * 0.28, // Adjusted from 0.2 to 0.28
          left: 20,
          right: 20,
          bottom: 80,
          child: Row(
            children: [
              // Left side - Mock phone (smaller in landscape)
              Expanded(
                flex: 1,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 0.6 + (_fadeController.value * 0.1),
                        child: Opacity(
                          opacity: _fadeController.value,
                          child: _buildMockPhoneFrame(isDark),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(width: 20),
              
              // Right side - Feature info
              Expanded(
                flex: 1,
                child: _buildFeatureSection(isDark),
              ),
            ],
          ),
        ),
        
        // Continue button
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 20, // Increased from 16 to 20
          left: 24,
          right: 24,
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeController.value,
                child: _buildContinueButton(isDark),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMockPhoneFrame(bool isDark) {
    return Container(
      width: 240, // Increased from 200
      height: 360, // Increased from 300
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32), // Back to original size
        color: isDark ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // Mock slideshow background
            AnimatedBuilder(
              animation: _photoController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.lerp(
                          Colors.blue.withOpacity(0.3),
                          Colors.purple.withOpacity(0.3),
                          math.sin(_photoController.value * math.pi * 2) * 0.5 + 0.5,
                        )!,
                        Color.lerp(
                          Colors.purple.withOpacity(0.3),
                          Colors.pink.withOpacity(0.3),
                          math.cos(_photoController.value * math.pi * 2) * 0.5 + 0.5,
                        )!,
                      ],
                    ),
                  ),
                );
              },
            ),
            
            // Mock photo placeholders
            ...List.generate(3, (index) => _buildMockPhoto(index)),
            
            // Glassmorphism overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    (isDark ? Colors.black : Colors.white).withOpacity(0.1),
                  ],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(),
              ),
            ),
            
            // Mock UI elements
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: isDark ? Colors.white : Colors.black,
                      size: 20,
                    ),
                    Icon(
                      Icons.settings,
                      color: isDark ? Colors.white : Colors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMockPhoto(int index) {
    return AnimatedBuilder(
      animation: _photoController,
      builder: (context, child) {
        final offset = (_photoController.value + index * 0.33) % 1.0;
        final opacity = 1.0 - (offset * 2 - 1).abs();
        
        return Positioned(
          top: 40 + offset * 80, // Adjusted for larger frame
          left: 25 + math.sin(offset * math.pi * 2) * 15, // Back to original movement
          child: Opacity(
            opacity: opacity * 0.8,
            child: Container(
              width: 60, // Slightly larger photos for bigger frame
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _features[index % _features.length].color.withOpacity(0.6),
                        _features[index % _features.length].color.withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.photo,
                    color: Colors.white.withOpacity(0.7),
                    size: 24, // Appropriate icon size
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureSection(bool isDark) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          // Current feature
          AnimatedBuilder(
            animation: _slideController,
            builder: (context, child) {
              return Opacity(
                opacity: _slideController.value,
                child: _buildFeatureCard(_features[_currentFeature], isDark),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(FeatureData feature, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
        border: Border.all(
          color: feature.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          AnimatedBuilder(
            animation: _iconController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_iconController.value * 0.1),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        feature.color.withOpacity(0.2),
                        feature.color.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Icon(
                    feature.icon,
                    color: feature.color,
                    size: 32,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: feature.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: (isDark ? Colors.white : Colors.black87).withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(bool isDark) {
    return Container(
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
                  // Navigate to media source selection
                  Get.toNamed('/onboarding/media-sources');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    'Continue',
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
    );
  }
}

class FeatureData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color color;

  FeatureData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.color,
  });
}
