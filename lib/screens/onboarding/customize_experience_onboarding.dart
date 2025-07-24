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
      duration: const Duration(milliseconds: 600),
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
    Future.delayed(const Duration(seconds: 2), () {
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
    
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
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
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Discover what makes LumiFrame special',
                            style: TextStyle(
                              fontSize: 16,
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
              
              // Main content area
              Expanded(
                child: Stack(
                  children: [
                    // Mock phone frame showing the app
                    Center(
                      child: AnimatedBuilder(
                        animation: _fadeController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 0.7 + (_fadeController.value * 0.3),
                            child: Opacity(
                              opacity: _fadeController.value,
                              child: _buildMockPhoneFrame(isDark),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Feature cards
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildFeatureSection(isDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMockPhoneFrame(bool isDark) {
    return Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
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
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: (isDark ? Colors.white : Colors.black).withOpacity(0.3),
                      ),
                      child: AnimatedBuilder(
                        animation: _photoController,
                        builder: (context, child) {
                          return FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _photoController.value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: AppConstants.primaryColor,
                              ),
                            ),
                          );
                        },
                      ),
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
          top: 60 + offset * 100,
          left: 40 + math.sin(offset * math.pi * 2) * 20,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Container(
              width: 220,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    _features[index % _features.length].color.withOpacity(0.3),
                    _features[index % _features.length].color.withOpacity(0.1),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Center(
                    child: Icon(
                      Icons.photo,
                      color: Colors.white.withOpacity(0.8),
                      size: 40,
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

  Widget _buildFeatureSection(bool isDark) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            (isDark ? Colors.black : Colors.white).withOpacity(0.95),
          ],
        ),
      ),
      child: Column(
        children: [
          // Feature indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_features.length, (index) {
              final isActive = index == _currentFeature;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isActive 
                      ? _features[_currentFeature].color
                      : (isDark ? Colors.white : Colors.black).withOpacity(0.3),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          
          // Current feature
          AnimatedBuilder(
            animation: _slideController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - _slideController.value)),
                child: Opacity(
                  opacity: _slideController.value,
                  child: _buildFeatureCard(_features[_currentFeature], isDark),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(FeatureData feature, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
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
