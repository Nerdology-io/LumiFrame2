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
      color: const Color(0xFF4A7BA7), // Morning sky blue
    ),
    FeatureData(
      icon: Icons.palette_outlined,
      title: 'Dynamic Themes',
      subtitle: 'Adapts to time and mood',
      description: 'Background changes throughout the day automatically',
      color: const Color(0xFF64B5F6), // Morning blue
    ),
    FeatureData(
      icon: Icons.cast_outlined,
      title: 'Cast & Share',
      subtitle: 'Connect to any screen',
      description: 'Share memories on TV, displays, or other devices',
      color: const Color(0xFF3B5B8C), // Steel blue
    ),
    FeatureData(
      icon: Icons.smart_display_outlined,
      title: 'Smart Display',
      subtitle: 'Intelligent photo management',
      description: 'AI-powered organization and automatic slideshows',
      color: const Color(0xFF2C3E68), // Slate blue
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

  // Get cool morning blue-inspired time-adaptive colors
  List<Color> _getTimeAdaptiveColors() {
    // Cool morning blue color palette that changes throughout the day
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 8) {
      // Early dawn - soft morning awakening
      return [
        const Color(0xFFE3F2FD), // Light morning blue
        const Color(0xFFBBDEFB), // Soft sky blue
        const Color(0xFF90CAF9), // Cool blue
        const Color(0xFF64B5F6), // Morning blue
        const Color(0xFF4A7BA7), // Morning sky blue
      ];
    } else if (hour >= 8 && hour < 12) {
      // Morning - crisp blue energy
      return [
        const Color(0xFF64B5F6), // Morning blue
        const Color(0xFF4A7BA7), // Morning sky blue
        const Color(0xFF3B5B8C), // Steel blue
        const Color(0xFF2C3E68), // Slate blue
        const Color(0xFF1B2951), // Deep morning blue
      ];
    } else if (hour >= 12 && hour < 17) {
      // Midday - bright morning clarity
      return [
        const Color(0xFF4A7BA7), // Morning sky blue
        const Color(0xFF90CAF9), // Cool blue
        const Color(0xFFE3F2FD), // Light morning blue
        const Color(0xFF64B5F6), // Morning blue
        const Color(0xFF3B5B8C), // Steel blue
      ];
    } else if (hour >= 17 && hour < 20) {
      // Evening - twilight morning reflection
      return [
        const Color(0xFF2C3E68), // Slate blue
        const Color(0xFF4A7BA7), // Morning sky blue
        const Color(0xFF64B5F6), // Morning blue
        const Color(0xFF90CAF9), // Cool blue
        const Color(0xFF3B5B8C), // Steel blue
      ];
    } else {
      // Night - deep evening blue transition
      return [
        const Color(0xFF1B2951), // Deep morning blue
        const Color(0xFF2C3E68), // Slate blue
        const Color(0xFF3B5B8C), // Steel blue
        const Color(0xFF4A7BA7), // Morning sky blue
        const Color(0xFF64B5F6), // Morning blue
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
                    const Color(0xFF1B2951), // Deep morning blue
                    const Color(0xFF2C3E68), // Slate blue
                    const Color(0xFF3B5B8C), // Steel blue
                    const Color(0xFF4A7BA7), // Morning sky blue
                  ]
                : [
                    const Color(0xFFE3F2FD), // Light morning blue
                    const Color(0xFFBBDEFB), // Soft sky blue
                    const Color(0xFF90CAF9), // Cool blue
                    const Color(0xFF64B5F6), // Morning blue
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
    // Cool morning blue color palette that matches the duotone/monotone aesthetic  
    const morningBlueColors = [
      Color(0xFF1B2951), // Deep morning blue
      Color(0xFF2C3E68), // Slate blue
      Color(0xFF3B5B8C), // Steel blue
      Color(0xFF4A7BA7), // Morning sky blue
      Color(0xFF64B5F6), // Morning blue
      Color(0xFF90CAF9), // Cool blue
      Color(0xFFBBDEFB), // Soft sky blue
      Color(0xFFE3F2FD), // Light morning blue
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
                  Colors.white.withOpacity(0.15), // Increased opacity for better contrast
                  Colors.white.withOpacity(0.12),
                  Colors.white.withOpacity(0.08),
                ]
              : [
                  Colors.white.withOpacity(0.9), // Higher opacity for better text readability
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.6),
                ],
        ),
        border: Border.all(
          color: isDark 
              ? morningBlueColors[4].withOpacity(0.4) // Morning blue
              : morningBlueColors[6].withOpacity(0.5), // Soft sky blue
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
                ? morningBlueColors[0].withOpacity(0.1) // Deep morning blue
                : morningBlueColors[7].withOpacity(0.3), // Light morning blue
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
                  Colors.white.withOpacity(isDark ? 0.08 : 0.15), // Increased opacity for better text backdrop
                  Colors.white.withOpacity(isDark ? 0.05 : 0.10),
                  feature.color.withOpacity(0.03), // Slightly increased for subtle color hint
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
                
                // Enhanced text content with improved legibility
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : morningBlueColors[0], // White / Deep morning blue for better contrast
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: isDark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.8),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        feature.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? morningBlueColors[5] : morningBlueColors[1], // Cool blue / Slate blue for better visibility
                          letterSpacing: 0.3,
                          shadows: [
                            Shadow(
                              color: isDark ? Colors.black.withOpacity(0.3) : Colors.white.withOpacity(0.6),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        feature.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isDark 
                              ? Colors.white.withOpacity(0.9) // High contrast white
                              : morningBlueColors[1].withOpacity(0.9), // Deep morning blue for better readability
                          height: 1.4,
                          letterSpacing: 0.2,
                          shadows: [
                            Shadow(
                              color: isDark ? Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.7),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
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
    // Cool morning blue color palette that matches the duotone/monotone aesthetic
    const morningBlueColors = [
      Color(0xFF1B2951), // Deep morning blue
      Color(0xFF2C3E68), // Slate blue
      Color(0xFF3B5B8C), // Steel blue
      Color(0xFF4A7BA7), // Morning sky blue
      Color(0xFF64B5F6), // Morning blue
      Color(0xFF90CAF9), // Cool blue
      Color(0xFFBBDEFB), // Soft sky blue
      Color(0xFFE3F2FD), // Light morning blue
    ];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  morningBlueColors[4].withOpacity(0.2), // Morning blue
                  morningBlueColors[3].withOpacity(0.15), // Morning sky blue
                  morningBlueColors[2].withOpacity(0.1), // Steel blue
                ]
              : [
                  morningBlueColors[6].withOpacity(0.3), // Soft sky blue
                  morningBlueColors[5].withOpacity(0.2), // Cool blue
                  morningBlueColors[4].withOpacity(0.1), // Morning blue
                ],
        ),
        border: Border.all(
          color: isDark 
              ? morningBlueColors[4].withOpacity(0.4) // Morning blue
              : morningBlueColors[6].withOpacity(0.5), // Soft sky blue
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? morningBlueColors[4].withOpacity(0.4) // Morning blue
                : morningBlueColors[6].withOpacity(0.4), // Soft sky blue
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: isDark 
                ? morningBlueColors[1].withOpacity(0.2) // Slate blue
                : morningBlueColors[5].withOpacity(0.2), // Cool blue
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
                        morningBlueColors[4].withOpacity(0.3), // Morning blue
                        morningBlueColors[3].withOpacity(0.2), // Morning sky blue
                        morningBlueColors[2].withOpacity(0.15), // Steel blue
                      ]
                    : [
                        morningBlueColors[6].withOpacity(0.4), // Soft sky blue
                        morningBlueColors[5].withOpacity(0.3), // Cool blue
                        morningBlueColors[4].withOpacity(0.2), // Morning blue
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
                      color: isDark ? morningBlueColors[6] : Colors.white, // Soft sky blue for dark, white for light
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          color: isDark 
                              ? morningBlueColors[0].withOpacity(0.5) // Deep morning blue
                              : morningBlueColors[2].withOpacity(0.4), // Steel blue
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
