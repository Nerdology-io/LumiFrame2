import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import '../../controllers/theme_controller.dart';
import '../../utils/constants.dart';

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
      color: const Color(0xFFB29BC8), // Lilac bloom
    ),
    FeatureData(
      icon: Icons.palette_outlined,
      title: 'Dynamic Themes',
      subtitle: 'Adapts to time and mood',
      description: 'Background changes throughout the day automatically',
      color: const Color(0xFFFFE5B4), // Soft peach
    ),
    FeatureData(
      icon: Icons.cast_outlined,
      title: 'Cast & Share',
      subtitle: 'Connect to any screen',
      description: 'Share memories on TV, displays, or other devices',
      color: const Color(0xFF8B6B9A), // Soft amethyst
    ),
    FeatureData(
      icon: Icons.smart_display_outlined,
      title: 'Smart Display',
      subtitle: 'Intelligent photo management',
      description: 'AI-powered organization and automatic slideshows',
      color: const Color(0xFF6B4C7A), // Lavender mist
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

  // Get spring sunrise-inspired time-adaptive colors
  List<Color> _getTimeAdaptiveColors() {
    // Spring sunrise color palette that changes throughout the day
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 8) {
      // Dawn - soft morning pastels
      return [
        const Color(0xFFFFF4E6), // Warm cream
        const Color(0xFFFFE5B4), // Soft peach
        const Color(0xFFD4C5E8), // Pale lavender
        const Color(0xFFB29BC8), // Lilac bloom
        const Color(0xFF8B6B9A), // Soft amethyst
      ];
    } else if (hour >= 8 && hour < 12) {
      // Morning - vibrant sunrise colors
      return [
        const Color(0xFFFFE5B4), // Soft peach
        const Color(0xFFB29BC8), // Lilac bloom
        const Color(0xFF8B6B9A), // Soft amethyst
        const Color(0xFF6B4C7A), // Lavender mist
        const Color(0xFF4A2C5A), // Violet morning
      ];
    } else if (hour >= 12 && hour < 17) {
      // Midday - bright spring bloom
      return [
        const Color(0xFFB29BC8), // Lilac bloom
        const Color(0xFFD4C5E8), // Pale lavender
        const Color(0xFFFFF4E6), // Warm cream
        const Color(0xFFFFE5B4), // Soft peach
        const Color(0xFF8B6B9A), // Soft amethyst
      ];
    } else if (hour >= 17 && hour < 20) {
      // Evening - mystical spring twilight
      return [
        const Color(0xFF6B4C7A), // Lavender mist
        const Color(0xFFB29BC8), // Lilac bloom
        const Color(0xFFD4C5E8), // Pale lavender
        const Color(0xFFFFE5B4), // Soft peach
        const Color(0xFF8B6B9A), // Soft amethyst
      ];
    } else {
      // Night - deep spring evening colors
      return [
        const Color(0xFF2D1B42), // Deep purple dawn
        const Color(0xFF4A2C5A), // Violet morning
        const Color(0xFF6B4C7A), // Lavender mist
        const Color(0xFFB29BC8), // Lilac bloom
        const Color(0xFF8B6B9A), // Soft amethyst
      ];
    }
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
                    const Color(0xFF2D1B42), // Deep purple dawn
                    const Color(0xFF4A2C5A), // Violet morning
                    const Color(0xFF6B4C7A), // Lavender mist
                    const Color(0xFF8B6B9A), // Soft amethyst
                  ]
                : [
                    const Color(0xFFFFF4E6), // Warm cream
                    const Color(0xFFFFE5B4), // Soft peach
                    const Color(0xFFFFD1A3), // Light apricot
                    const Color(0xFFFFB682), // Golden sunrise
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
            // Enhanced mock slideshow background with time-adaptive colors
            AnimatedBuilder(
              animation: _photoController,
              builder: (context, child) {
                // Time-adaptive color palette that matches the main theme
                final timeColors = _getTimeAdaptiveColors();
                final animationValue = _photoController.value;
                
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.2,
                      colors: [
                        Color.lerp(
                          timeColors[0].withOpacity(0.15),
                          timeColors[1].withOpacity(0.12),
                          math.sin(animationValue * math.pi * 2) * 0.5 + 0.5,
                        )!,
                        Color.lerp(
                          timeColors[2].withOpacity(0.08),
                          timeColors[3].withOpacity(0.06),
                          math.cos(animationValue * math.pi * 1.5) * 0.5 + 0.5,
                        )!,
                        Color.lerp(
                          timeColors[4].withOpacity(0.04),
                          timeColors[0].withOpacity(0.02),
                          math.sin(animationValue * math.pi * 3) * 0.5 + 0.5,
                        )!,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              (isDark ? Colors.black : Colors.white).withOpacity(0.05),
                              (isDark ? Colors.black : Colors.white).withOpacity(0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            
            // Mock photo placeholders
            ...List.generate(3, (index) => _buildMockPhoto(index)),
            
            // Floating particles for added visual interest
            ...List.generate(6, (index) => _buildFloatingParticle(index)),
            
            // Enhanced glassmorphism overlay with depth
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    (isDark ? Colors.black : Colors.white).withOpacity(0.02),
                    (isDark ? Colors.black : Colors.white).withOpacity(0.05),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.03),
                          Colors.white.withOpacity(0.01),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Enhanced mock UI elements with glassmorphism
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.04),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white.withOpacity(0.9),
                            size: 18,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.tune_rounded,
                            color: Colors.white.withOpacity(0.9),
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
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
        final timeColors = _getTimeAdaptiveColors();
        
        return Positioned(
          top: 40 + offset * 80,
          left: 25 + math.sin(offset * math.pi * 2) * 15,
          child: Opacity(
            opacity: opacity * 0.9,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.03),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: timeColors[index % timeColors.length].withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.5),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1.2,
                        colors: [
                          timeColors[index % timeColors.length].withOpacity(0.4),
                          timeColors[(index + 1) % timeColors.length].withOpacity(0.2),
                          timeColors[(index + 2) % timeColors.length].withOpacity(0.1),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.photo_outlined,
                          color: Colors.white.withOpacity(0.8),
                          size: 26,
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

  Widget _buildFloatingParticle(int index) {
    return AnimatedBuilder(
      animation: _photoController,
      builder: (context, child) {
        final timeColors = _getTimeAdaptiveColors();
        final offset = (_photoController.value * 0.3 + index * 0.15) % 1.0;
        final size = 2.0 + (index % 3) * 1.5;
        final opacity = (math.sin(offset * math.pi * 2) * 0.5 + 0.5) * 0.4;
        
        return Positioned(
          top: 20 + (offset * 300) % 280,
          left: 20 + (math.sin(offset * math.pi * 4 + index) * 100 + 100) % 200,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    timeColors[index % timeColors.length].withOpacity(0.6),
                    timeColors[index % timeColors.length].withOpacity(0.0),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: timeColors[index % timeColors.length].withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
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
    // Spring sunrise color palette  
    const springColors = [
      Color(0xFF2D1B42), // Deep purple dawn
      Color(0xFF4A2C5A), // Violet morning
      Color(0xFF6B4C7A), // Lavender mist
      Color(0xFF8B6B9A), // Soft amethyst
      Color(0xFFB29BC8), // Lilac bloom
      Color(0xFFD4C5E8), // Pale lavender
      Color(0xFFFFE5B4), // Soft peach
      Color(0xFFFFF4E6), // Warm cream
    ];
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Colors.white.withOpacity(0.12),
                  Colors.white.withOpacity(0.08),
                  Colors.white.withOpacity(0.04),
                ]
              : [
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.4),
                ],
        ),
        border: Border.all(
          color: isDark 
              ? springColors[4].withOpacity(0.4) // Lilac bloom
              : springColors[6].withOpacity(0.5), // Soft peach
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: feature.color.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: isDark 
                ? springColors[0].withOpacity(0.1) // Deep purple dawn
                : springColors[7].withOpacity(0.3), // Warm cream
            blurRadius: 12,
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
                  Colors.white.withOpacity(isDark ? 0.05 : 0.1),
                  Colors.white.withOpacity(isDark ? 0.02 : 0.05),
                  feature.color.withOpacity(0.02),
                ],
              ),
            ),
            child: Row(
              children: [
                // Enhanced icon with aurora glow
                AnimatedBuilder(
                  animation: _iconController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_iconController.value * 0.1),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              feature.color.withOpacity(0.3),
                              feature.color.withOpacity(0.1),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                          ),
                          border: Border.all(
                            color: feature.color.withOpacity(0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: feature.color.withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Icon(
                              feature.icon,
                              color: feature.color,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 20),
                
                // Enhanced text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark ? springColors[5] : springColors[1], // Pale lavender / Violet morning
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: feature.color.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        feature.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: feature.color,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        feature.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: isDark 
                              ? springColors[5].withOpacity(0.8) // Pale lavender
                              : springColors[2].withOpacity(0.8), // Lavender mist
                          height: 1.4,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(bool isDark) {
    // Spring sunrise color palette
    const springColors = [
      Color(0xFF2D1B42), // Deep purple dawn
      Color(0xFF4A2C5A), // Violet morning
      Color(0xFF6B4C7A), // Lavender mist
      Color(0xFF8B6B9A), // Soft amethyst
      Color(0xFFB29BC8), // Lilac bloom
      Color(0xFFD4C5E8), // Pale lavender
      Color(0xFFFFE5B4), // Soft peach
      Color(0xFFFFF4E6), // Warm cream
    ];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  springColors[4].withOpacity(0.2), // Lilac bloom
                  springColors[3].withOpacity(0.15), // Soft amethyst
                  springColors[2].withOpacity(0.1), // Lavender mist
                ]
              : [
                  springColors[6].withOpacity(0.3), // Soft peach
                  springColors[5].withOpacity(0.2), // Pale lavender
                  springColors[4].withOpacity(0.1), // Lilac bloom
                ],
        ),
        border: Border.all(
          color: isDark 
              ? springColors[4].withOpacity(0.4) // Lilac bloom
              : springColors[6].withOpacity(0.5), // Soft peach
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? springColors[4].withOpacity(0.4) // Lilac bloom
                : springColors[6].withOpacity(0.4), // Soft peach
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: isDark 
                ? springColors[1].withOpacity(0.2) // Violet morning
                : springColors[5].withOpacity(0.2), // Pale lavender
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
                colors: isDark
                    ? [
                        springColors[4].withOpacity(0.3), // Lilac bloom
                        springColors[3].withOpacity(0.2), // Soft amethyst
                        springColors[2].withOpacity(0.15), // Lavender mist
                      ]
                    : [
                        springColors[6].withOpacity(0.4), // Soft peach
                        springColors[5].withOpacity(0.3), // Pale lavender
                        springColors[4].withOpacity(0.2), // Lilac bloom
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
                      color: isDark ? springColors[5] : Colors.white, // Pale lavender for dark, white for light
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          color: isDark 
                              ? springColors[0].withOpacity(0.5) // Deep purple dawn
                              : springColors[2].withOpacity(0.4), // Lavender mist
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
