import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;
import '../../controllers/theme_controller.dart';
import '../../utils/constants.dart';

class TimeAdaptiveOnboarding extends StatefulWidget {
  const TimeAdaptiveOnboarding({super.key});

  @override
  State<TimeAdaptiveOnboarding> createState() => _TimeAdaptiveOnboardingState();
}

class _TimeAdaptiveOnboardingState extends State<TimeAdaptiveOnboarding>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late AnimationController _timeController;
  late AnimationController _textFadeController;
  
  // Time of day simulation (0.0 = midnight, 1.0 = next midnight)
  double _timeOfDay = 0.2; // Start at early morning (around 5 AM)

  @override
  void initState() {
    super.initState();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _fadeController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    
    _textFadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // Slow time progression (24 seconds = full day cycle for demo)
    _timeController = AnimationController(
      duration: const Duration(seconds: 24),
      vsync: this,
    )..repeat();
    
    _timeController.addListener(() {
      setState(() {
        _timeOfDay = _timeController.value;
      });
    });
    
    // Start text fade animation
    _textFadeController.forward();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    _fadeController.dispose();
    _timeController.dispose();
    _textFadeController.dispose();
    super.dispose();
  }
  
  // Get time-based gradient colors that work with light/dark theme
  List<Color> _getTimeBasedGradient() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    // Base colors - adjust opacity and intensity based on theme
    final baseMultiplier = isDark ? 0.8 : 1.0;
    final opacityMultiplier = isDark ? 0.9 : 0.7;
    
    if (_timeOfDay < 0.15) {
      // Night - Deep blues and purples
      return [
        Color(0xFF0a0a1a).withOpacity(baseMultiplier),
        Color(0xFF1a1a2e).withOpacity(baseMultiplier),
        Color(0xFF16213e).withOpacity(baseMultiplier),
        Color(0xFF0f3460).withOpacity(baseMultiplier),
        Color(0xFF533483).withOpacity(baseMultiplier),
        Color(0xFF7209b7).withOpacity(opacityMultiplier),
        Color(0xFF560bad).withOpacity(opacityMultiplier),
        Color(0xFF480ca8).withOpacity(opacityMultiplier),
        Color(0xFF3a0ca3).withOpacity(opacityMultiplier),
      ];
    } else if (_timeOfDay < 0.25) {
      // Early Morning - Purple to pink dawn
      double progress = (_timeOfDay - 0.15) / 0.1;
      return _interpolateGradients([
        Color(0xFF0a0a1a).withOpacity(baseMultiplier),
        Color(0xFF1a1a2e).withOpacity(baseMultiplier),
        Color(0xFF16213e).withOpacity(baseMultiplier),
        Color(0xFF0f3460).withOpacity(baseMultiplier),
        Color(0xFF533483).withOpacity(baseMultiplier),
        Color(0xFF7209b7).withOpacity(opacityMultiplier),
        Color(0xFF560bad).withOpacity(opacityMultiplier),
        Color(0xFF480ca8).withOpacity(opacityMultiplier),
        Color(0xFF3a0ca3).withOpacity(opacityMultiplier),
      ], [
        Color(0xFF1a1c3a).withOpacity(baseMultiplier),
        Color(0xFF2d1b69).withOpacity(baseMultiplier),
        Color(0xFF4a148c).withOpacity(baseMultiplier),
        Color(0xFF6a1b9a).withOpacity(baseMultiplier),
        Color(0xFFad1457).withOpacity(baseMultiplier),
        Color(0xFFd81b60).withOpacity(opacityMultiplier),
        Color(0xFFf06292).withOpacity(opacityMultiplier),
        Color(0xFFffa726).withOpacity(opacityMultiplier),
        Color(0xFFffcc02).withOpacity(opacityMultiplier),
      ], progress);
    } else if (_timeOfDay < 0.4) {
      // Morning - Warm sunrise colors
      double progress = (_timeOfDay - 0.25) / 0.15;
      return _interpolateGradients([
        Color(0xFF1a1c3a).withOpacity(baseMultiplier),
        Color(0xFF2d1b69).withOpacity(baseMultiplier),
        Color(0xFF4a148c).withOpacity(baseMultiplier),
        Color(0xFF6a1b9a).withOpacity(baseMultiplier),
        Color(0xFFad1457).withOpacity(baseMultiplier),
        Color(0xFFd81b60).withOpacity(opacityMultiplier),
        Color(0xFFf06292).withOpacity(opacityMultiplier),
        Color(0xFFffa726).withOpacity(opacityMultiplier),
        Color(0xFFffcc02).withOpacity(opacityMultiplier),
      ], [
        Color(0xFF87ceeb).withOpacity(isDark ? 0.6 : 1.0),
        Color(0xFF98d8e8).withOpacity(isDark ? 0.6 : 1.0),
        Color(0xFFb8e6b8).withOpacity(isDark ? 0.6 : 1.0),
        Color(0xFFffb347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
      ], progress);
    } else if (_timeOfDay < 0.6) {
      // Afternoon - Bright blues and whites (adjusted for dark theme)
      if (isDark) {
        return [
          Color(0xFF4a90e2).withOpacity(0.6),
          Color(0xFF5ba3f5).withOpacity(0.6),
          Color(0xFF6bb6ff).withOpacity(0.6),
          Color(0xFF7cc8ff).withOpacity(0.6),
          Color(0xFF8dd9ff).withOpacity(0.6),
          Color(0xFF9eeaff).withOpacity(0.6),
          Color(0xFFaffbff).withOpacity(0.6),
          Color(0xFFc0ffff).withOpacity(0.6),
          Color(0xFFd1ffff).withOpacity(0.6),
        ];
      } else {
        return [
          const Color(0xFF87ceeb),
          const Color(0xFF87cefa),
          const Color(0xFF98d8e8),
          const Color(0xFFb8e6b8),
          const Color(0xFFe0ffff),
          const Color(0xFFf0f8ff),
          const Color(0xFFf5f5dc),
          const Color(0xFFfffacd),
          const Color(0xFFffffff),
        ];
      }
    } else if (_timeOfDay < 0.75) {
      // Late Afternoon - Golden hour
      double progress = (_timeOfDay - 0.6) / 0.15;
      final fromColors = isDark ? [
        Color(0xFF4a90e2).withOpacity(0.6),
        Color(0xFF5ba3f5).withOpacity(0.6),
        Color(0xFF6bb6ff).withOpacity(0.6),
        Color(0xFF7cc8ff).withOpacity(0.6),
        Color(0xFF8dd9ff).withOpacity(0.6),
        Color(0xFF9eeaff).withOpacity(0.6),
        Color(0xFFaffbff).withOpacity(0.6),
        Color(0xFFc0ffff).withOpacity(0.6),
        Color(0xFFd1ffff).withOpacity(0.6),
      ] : [
        const Color(0xFF87ceeb),
        const Color(0xFF87cefa),
        const Color(0xFF98d8e8),
        const Color(0xFFb8e6b8),
        const Color(0xFFe0ffff),
        const Color(0xFFf0f8ff),
        const Color(0xFFf5f5dc),
        const Color(0xFFfffacd),
        const Color(0xFFffffff),
      ];
      
      return _interpolateGradients(fromColors, [
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff7f50).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFdc143c).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFb22222).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFF8b0000).withOpacity(isDark ? 0.7 : 1.0),
      ], progress);
    } else if (_timeOfDay < 0.85) {
      // Evening - Sunset colors
      return [
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff7f50).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFdc143c).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFb22222).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFF8b0000).withOpacity(isDark ? 0.7 : 1.0),
      ];
    } else if (_timeOfDay < 0.95) {
      // Late Evening - Deep oranges to purples
      double progress = (_timeOfDay - 0.85) / 0.1;
      return _interpolateGradients([
        Color(0xFFffd700).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFffa500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff8c00).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff7f50).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff6347).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFff4500).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFdc143c).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFFb22222).withOpacity(isDark ? 0.7 : 1.0),
        Color(0xFF8b0000).withOpacity(isDark ? 0.7 : 1.0),
      ], [
        Color(0xFF4b0082).withOpacity(baseMultiplier),
        Color(0xFF483d8b).withOpacity(baseMultiplier),
        Color(0xFF6a5acd).withOpacity(baseMultiplier),
        Color(0xFF7b68ee).withOpacity(baseMultiplier),
        Color(0xFF9370db).withOpacity(baseMultiplier),
        Color(0xFFba55d3).withOpacity(opacityMultiplier),
        Color(0xFFda70d6).withOpacity(opacityMultiplier),
        Color(0xFFdda0dd).withOpacity(opacityMultiplier),
        Color(0xFFe6e6fa).withOpacity(opacityMultiplier),
      ], progress);
    } else {
      // Night - Return to deep night colors
      double progress = (_timeOfDay - 0.95) / 0.05;
      return _interpolateGradients([
        Color(0xFF4b0082).withOpacity(baseMultiplier),
        Color(0xFF483d8b).withOpacity(baseMultiplier),
        Color(0xFF6a5acd).withOpacity(baseMultiplier),
        Color(0xFF7b68ee).withOpacity(baseMultiplier),
        Color(0xFF9370db).withOpacity(baseMultiplier),
        Color(0xFFba55d3).withOpacity(opacityMultiplier),
        Color(0xFFda70d6).withOpacity(opacityMultiplier),
        Color(0xFFdda0dd).withOpacity(opacityMultiplier),
        Color(0xFFe6e6fa).withOpacity(opacityMultiplier),
      ], [
        Color(0xFF0a0a1a).withOpacity(baseMultiplier),
        Color(0xFF1a1a2e).withOpacity(baseMultiplier),
        Color(0xFF16213e).withOpacity(baseMultiplier),
        Color(0xFF0f3460).withOpacity(baseMultiplier),
        Color(0xFF533483).withOpacity(baseMultiplier),
        Color(0xFF7209b7).withOpacity(opacityMultiplier),
        Color(0xFF560bad).withOpacity(opacityMultiplier),
        Color(0xFF480ca8).withOpacity(opacityMultiplier),
        Color(0xFF3a0ca3).withOpacity(opacityMultiplier),
      ], progress);
    }
  }
  
  // Interpolate between two gradient arrays
  List<Color> _interpolateGradients(List<Color> from, List<Color> to, double t) {
    List<Color> result = [];
    for (int i = 0; i < from.length && i < to.length; i++) {
      result.add(Color.lerp(from[i], to[i], t)!);
    }
    return result;
  }
  
  // Get luminosity multiplier based on time of day and theme
  double _getLuminosityMultiplier() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    // Adjust luminosity based on theme
    final baseMultiplier = isDark ? 1.2 : 1.0;
    
    // Darkest at night (0.3), brightest at midday (1.0)
    if (_timeOfDay < 0.15 || _timeOfDay > 0.9) {
      return (0.3 * baseMultiplier).clamp(0.0, 1.0); // Night
    } else if (_timeOfDay < 0.25) {
      return (0.4 + (_timeOfDay - 0.15) * 2) * baseMultiplier; // Early morning rising
    } else if (_timeOfDay < 0.4) {
      return (0.6 + (_timeOfDay - 0.25) * 2.67) * baseMultiplier; // Morning brightening
    } else if (_timeOfDay < 0.6) {
      return (1.0 * baseMultiplier).clamp(0.0, 1.0); // Full daylight
    } else if (_timeOfDay < 0.85) {
      return (1.0 - (_timeOfDay - 0.6) * 2.8) * baseMultiplier; // Evening dimming
    } else {
      return (0.3 + (0.9 - _timeOfDay) * 4) * baseMultiplier; // Late evening to night
    }
  }
  
  // Get adaptive text colors based on time, luminosity, and theme
  List<Color> _getAdaptiveTextColors() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    // During bright periods, use darker colors for contrast
    if (_timeOfDay >= 0.4 && _timeOfDay < 0.6) {
      // Afternoon - use dark colors for contrast against bright background
      if (isDark) {
        return [
          const Color(0xFFe3f2fd), // Light blue
          const Color(0xFFbbdefb), // Lighter blue
          const Color(0xFF90caf9), // Even lighter blue
        ];
      } else {
        return [
          const Color(0xFF1a237e), // Deep blue
          const Color(0xFF0d47a1), // Blue
          const Color(0xFF01579b), // Light blue
        ];
      }
    } else if (_timeOfDay >= 0.25 && _timeOfDay < 0.4) {
      // Morning - warm but readable colors
      if (isDark) {
        return [
          const Color(0xFFfff3e0), // Light orange
          const Color(0xFFffe0b2), // Lighter orange
          const Color(0xFFffcc80), // Even lighter orange
        ];
      } else {
        return [
          const Color(0xFF3e2723), // Dark brown
          const Color(0xFF5d4037), // Brown
          const Color(0xFF8d6e63), // Light brown
        ];
      }
    } else if (_timeOfDay >= 0.6 && _timeOfDay < 0.75) {
      // Late afternoon - golden hour colors
      if (isDark) {
        return [
          const Color(0xFFf3e5f5), // Light purple
          const Color(0xFFe1bee7), // Lighter purple
          const Color(0xFFce93d8), // Even lighter purple
        ];
      } else {
        return [
          const Color(0xFF4a148c), // Deep purple
          const Color(0xFF6a1b9a), // Purple
          const Color(0xFF8e24aa), // Light purple
        ];
      }
    } else if (_timeOfDay >= 0.75 && _timeOfDay < 0.85) {
      // Evening - complementary colors
      if (isDark) {
        return [
          const Color(0xFFe8eaf6), // Light indigo
          const Color(0xFFc5cae9), // Lighter indigo
          const Color(0xFF9fa8da), // Even lighter indigo
        ];
      } else {
        return [
          const Color(0xFF1a237e), // Deep blue (contrast to orange)
          const Color(0xFF3f51b5), // Indigo
          const Color(0xFF5c6bc0), // Light indigo
        ];
      }
    } else {
      // Night, early morning, late evening - light colors
      if (isDark) {
        return [
          const Color(0xFFffffff), // White
          const Color(0xFFf8bbd9), // Light pink
          const Color(0xFFe1bee7), // Light purple
        ];
      } else {
        return [
          const Color(0xFFffffff), // White
          const Color(0xFFf8bbd9), // Light pink
          const Color(0xFFe1bee7), // Light purple
        ];
      }
    }
  }
  
  // Get main title color with dynamic adaptation
  Color _getTitleColor() {
    final adaptiveColors = _getAdaptiveTextColors();
    final luminosity = _getLuminosityMultiplier();
    
    // For bright times, ensure good contrast
    if (luminosity > 0.7) {
      return adaptiveColors[0].withOpacity(0.9);
    } else {
      return adaptiveColors[0].withOpacity(0.9);
    }
  }
  
  // Get subtitle color with gradient effect
  Color _getSubtitleColor() {
    final adaptiveColors = _getAdaptiveTextColors();
    final luminosity = _getLuminosityMultiplier();
    
    if (luminosity > 0.7) {
      return adaptiveColors[1].withOpacity(0.8);
    } else {
      return adaptiveColors[1].withOpacity(0.7);
    }
  }
  
  // Get info text color
  Color _getInfoTextColor() {
    final adaptiveColors = _getAdaptiveTextColors();
    final luminosity = _getLuminosityMultiplier();
    
    if (luminosity > 0.7) {
      return adaptiveColors[2].withOpacity(0.7);
    } else {
      return adaptiveColors[2].withOpacity(0.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeBasedColors = _getTimeBasedGradient();
    final luminosity = _getLuminosityMultiplier();
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: timeBasedColors.map((color) => 
              Color.lerp(isDark ? Colors.black : Colors.white, color, luminosity)!
            ).toList(),
            stops: const [0.0, 0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.85, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated floating orbs with time-based colors
            ...List.generate(6, (index) => _buildFloatingOrb(index, timeBasedColors, luminosity)),
            
            // Subtle particle effects with time-based intensity
            ...List.generate(12, (index) => _buildParticle(index, luminosity)),
            
            // Center content area with glassmorphism effect
            Center(
              child: AnimatedBuilder(
                animation: _textFadeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textFadeController.value,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (isDark ? Colors.black : Colors.white).withOpacity(0.15),
                            (isDark ? Colors.black : Colors.white).withOpacity(0.08),
                          ],
                        ),
                        border: Border.all(
                          color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // App logo/icon
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppConstants.primaryColor.withOpacity(0.3),
                                        AppConstants.accentColor.withOpacity(0.3),
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.photo_camera_outlined,
                                    size: 60,
                                    color: _getTitleColor().withOpacity(0.8),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                
                                // Main title
                                Text(
                                  'Dynamic Ambiance',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w300,
                                    color: _getTitleColor(),
                                    letterSpacing: 2,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 2),
                                        blurRadius: 8,
                                        color: (isDark ? Colors.white : Colors.black).withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                
                                // Subtitle
                                Text(
                                  'that adapts to time...',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w200,
                                    color: _getSubtitleColor(),
                                    letterSpacing: 1.5,
                                    fontStyle: FontStyle.italic,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 6,
                                        color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),
                                
                                // Description
                                Text(
                                  '${AppConstants.appName} adapts to the natural rhythm of your day,\ncreating the perfect ambiance for your memories.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: _getInfoTextColor(),
                                    letterSpacing: 0.5,
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Continue button positioned at bottom of screen
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 32,
              left: 32,
              right: 32,
              child: AnimatedBuilder(
                animation: _textFadeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textFadeController.value,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor.withOpacity(0.8),
                            AppConstants.accentColor.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                          onTap: () {
                            // Continue to the next onboarding step or main carousel
                            Get.back(); // Go back to onboarding carousel
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.black : Colors.white,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Back button in top-left corner
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.arrow_back,
                        color: _getTitleColor(),
                        size: 24,
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
  }

  Widget _buildFloatingOrb(int index, List<Color> timeColors, double luminosity) {
    final size = 120.0 + (index * 20);
    
    // Use colors from the current time-based palette
    final orbColors = [
      [timeColors[7].withOpacity(0.3 * luminosity), timeColors[6].withOpacity(0.1 * luminosity)],
      [timeColors[8].withOpacity(0.25 * luminosity), timeColors[7].withOpacity(0.1 * luminosity)],
      [timeColors[5].withOpacity(0.2 * luminosity), timeColors[4].withOpacity(0.1 * luminosity)],
      [timeColors[3].withOpacity(0.15 * luminosity), timeColors[2].withOpacity(0.08 * luminosity)],
      [timeColors[2].withOpacity(0.18 * luminosity), timeColors[1].withOpacity(0.09 * luminosity)],
      [timeColors[1].withOpacity(0.12 * luminosity), timeColors[0].withOpacity(0.06 * luminosity)],
    ];

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 
              (0.1 + (index * 0.15) + (_floatingController.value * 0.1)),
          left: MediaQuery.of(context).size.width * 
              (0.1 + (index * 0.12) + (math.sin(_floatingController.value * math.pi) * 0.05)),
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: size * (0.8 + (_pulseController.value * 0.4)),
                height: size * (0.8 + (_pulseController.value * 0.4)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: orbColors[index % orbColors.length],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildParticle(int index, double luminosity) {
    final size = 4.0 + (index % 3) * 2;
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 
              ((index * 0.08) + (_floatingController.value * 0.3)) % 1.0,
          left: MediaQuery.of(context).size.width * 
              ((index * 0.07) + (math.sin(_floatingController.value * math.pi + index) * 0.1)) % 1.0,
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDark ? Colors.white : Colors.white).withOpacity(0.4 * _fadeController.value * luminosity),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.white : Colors.white).withOpacity(0.2 * luminosity),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
