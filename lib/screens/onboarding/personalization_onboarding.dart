import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' show ImageFilter;
import '../../controllers/theme_controller.dart';
import '../../controllers/slideshow_controller.dart';
import '../../utils/constants.dart';

class PersonalizationOnboarding extends StatefulWidget {
  const PersonalizationOnboarding({super.key});

  @override
  State<PersonalizationOnboarding> createState() => _PersonalizationOnboardingState();
}

class _PersonalizationOnboardingState extends State<PersonalizationOnboarding>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _selectionController;
  
  // Controllers - Use getter with safe initialization
  SlideshowController get slideshowController {
    try {
      return Get.find<SlideshowController>();
    } catch (e) {
      // If controller doesn't exist, create it
      return Get.put(SlideshowController());
    }
  }
  
  // Preferences (for features not yet in controller)
  bool _timeBasedThemes = true;
  bool _hideScreenshots = true;
  bool _quietHours = false;
  
  final List<TransitionOption> _transitionOptions = [
    TransitionOption('fade', 'Fade', Icons.blur_on),
    TransitionOption('slide_left', 'Slide Left', Icons.arrow_back),
    TransitionOption('slide_right', 'Slide Right', Icons.arrow_forward),
    TransitionOption('slide_up', 'Slide Up', Icons.arrow_upward),
    TransitionOption('slide_down', 'Slide Down', Icons.arrow_downward),
    TransitionOption('flip', 'Flip', Icons.flip),
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
    
    _selectionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  void _animateSelection() {
    _selectionController.reset();
    _selectionController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
      final isDark = themeController.themeMode.value == ThemeMode.dark ||
          (themeController.themeMode.value == ThemeMode.system &&
              MediaQuery.of(context).platformBrightness == Brightness.dark);
      
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
                    const Color(0xFF0B1426), // Deep space blue
                    const Color(0xFF1B2951), // Midnight blue  
                    const Color(0xFF2D5D87), // Arctic blue
                    const Color(0xFF4ECDC4), // Ethereal teal
                  ]
                : [
                    const Color(0xFFE8F8F5), // Polar white
                    const Color(0xFFB8E6B8), // Soft mint
                    const Color(0xFF96CEB4), // Aurora green
                    const Color(0xFF45B7D1), // Ice blue
                  ],
          ),
        ),
        child: Stack(
          children: [
            // Header
            Positioned(
              top: MediaQuery.of(context).padding.top + 24,
              left: 24,
              right: 24,
              child: AnimatedBuilder(
                animation: _fadeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeController.value,
                    child: Column(
                      children: [
                        Text(
                          'Make It Yours',
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
                          'Customize how your photos are displayed',
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
            
            // Preferences content
            Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              left: 24,
              right: 24,
              bottom: 120,
              child: AnimatedBuilder(
                animation: _slideController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - _slideController.value)),
                    child: Opacity(
                      opacity: _slideController.value,
                      child: _buildPreferencesContent(isDark),
                    ),
                  );
                },
              ),
            ),
            
            // Continue button
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 32,
              left: 32,
              right: 32,
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
        ),
      ),
    );
  });
  }

  Widget _buildPreferencesContent(bool isDark) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32), // Added extra padding under subtitle
          
          // Media Controls Section
          _buildPreferenceSection(
            'Media Controls',
            _buildMediaControls(isDark),
            isDark,
          ),
          const SizedBox(height: 20),
          
          // Slideshow Duration
          _buildPreferenceSection(
            'Slideshow Duration',
            _buildSlideshowDurationSection(isDark),
            isDark,
          ),
          const SizedBox(height: 20),
          
          // Transition Effects
          _buildPreferenceSection(
            'Transition Effects',
            _buildTransitionSelector(isDark),
            isDark,
          ),
          const SizedBox(height: 20),
          
          // Smart Features
          _buildPreferenceSection(
            'Smart Features',
            _buildSmartFeatures(isDark),
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceSection(String title, Widget content, bool isDark) {
    // Aurora borealis color palette
    const auroraColors = [
      Color(0xFF0B1426), // Deep space blue
      Color(0xFF1B2951), // Midnight blue
      Color(0xFF2D5D87), // Arctic blue
      Color(0xFF4ECDC4), // Ethereal teal
      Color(0xFF45B7D1), // Ice blue
      Color(0xFF96CEB4), // Aurora green
      Color(0xFFB8E6B8), // Soft mint
      Color(0xFFE8F8F5), // Polar white
    ];
    
    return Container(
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
              ? auroraColors[3].withOpacity(0.4) // Ethereal teal
              : auroraColors[4].withOpacity(0.5), // Ice blue
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? auroraColors[3].withOpacity(0.2) // Ethereal teal
                : auroraColors[4].withOpacity(0.3), // Ice blue
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: isDark 
                ? auroraColors[0].withOpacity(0.1) // Deep space blue
                : auroraColors[7].withOpacity(0.3), // Polar white
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
                  auroraColors[3].withOpacity(0.02), // Ethereal teal
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? auroraColors[6] : auroraColors[1], // Soft mint / Midnight blue
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: isDark 
                              ? auroraColors[3].withOpacity(0.2) // Ethereal teal
                              : auroraColors[4].withOpacity(0.2), // Ice blue
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  content,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlideshowDurationSection(bool isDark) {
    // Aurora borealis color palette
    const auroraColors = [
      Color(0xFF0B1426), // Deep space blue
      Color(0xFF1B2951), // Midnight blue
      Color(0xFF2D5D87), // Arctic blue
      Color(0xFF4ECDC4), // Ethereal teal
      Color(0xFF45B7D1), // Ice blue
      Color(0xFF96CEB4), // Aurora green
      Color(0xFFB8E6B8), // Soft mint
      Color(0xFFE8F8F5), // Polar white
    ];
    
    return Obx(() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Change photo every',
              style: TextStyle(
                fontSize: 16,
                color: isDark 
                    ? auroraColors[6].withOpacity(0.9) // Soft mint
                    : auroraColors[2].withOpacity(0.9), // Arctic blue
                letterSpacing: 0.3,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    isDark ? auroraColors[3].withOpacity(0.2) : auroraColors[4].withOpacity(0.2), // Ethereal teal / Ice blue
                    isDark ? auroraColors[4].withOpacity(0.1) : auroraColors[5].withOpacity(0.1), // Ice blue / Aurora green
                  ],
                ),
                border: Border.all(
                  color: isDark ? auroraColors[3].withOpacity(0.4) : auroraColors[4].withOpacity(0.4), // Ethereal teal / Ice blue
                  width: 1,
                ),
              ),
              child: Text(
                '${slideshowController.slideDuration.value}s',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? auroraColors[3] : auroraColors[2], // Ethereal teal / Arctic blue
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: isDark ? auroraColors[3] : auroraColors[4], // Ethereal teal / Ice blue
            inactiveTrackColor: isDark 
                ? auroraColors[6].withOpacity(0.2) // Soft mint
                : auroraColors[1].withOpacity(0.2), // Midnight blue
            thumbColor: isDark ? auroraColors[3] : auroraColors[4], // Ethereal teal / Ice blue
            overlayColor: isDark 
                ? auroraColors[3].withOpacity(0.2) // Ethereal teal
                : auroraColors[4].withOpacity(0.2), // Ice blue
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 4,
              pressedElevation: 6,
            ),
            trackHeight: 4,
          ),
          child: Slider(
            value: slideshowController.slideDuration.value.toDouble(),
            min: 1.0,
            max: 60.0,
            divisions: 59,
            onChanged: (value) {
              slideshowController.setSlideDuration(value.toInt());
            },
          ),
        ),
      ],
    ));
  }

  Widget _buildTransitionSelector(bool isDark) {
    // Aurora borealis color palette
    const auroraColors = [
      Color(0xFF0B1426), // Deep space blue
      Color(0xFF1B2951), // Midnight blue
      Color(0xFF2D5D87), // Arctic blue
      Color(0xFF4ECDC4), // Ethereal teal
      Color(0xFF45B7D1), // Ice blue
      Color(0xFF96CEB4), // Aurora green
      Color(0xFFB8E6B8), // Soft mint
      Color(0xFFE8F8F5), // Polar white
    ];
    
    return Obx(() => Column(
      children: _transitionOptions.map((option) {
        final isSelected = slideshowController.transitionType.value == option.id;
        return GestureDetector(
          onTap: () {
            slideshowController.setTransitionType(option.id);
            _animateSelection();
          },
          child: AnimatedBuilder(
            animation: _selectionController,
            builder: (context, child) {
              return Transform.scale(
                scale: isSelected ? 1.0 + (_selectionController.value * 0.02) : 1.0,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: isSelected 
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDark
                                ? [
                                    auroraColors[3].withOpacity(0.2), // Ethereal teal
                                    auroraColors[4].withOpacity(0.1), // Ice blue
                                    auroraColors[5].withOpacity(0.05), // Aurora green
                                  ]
                                : [
                                    auroraColors[5].withOpacity(0.2), // Aurora green
                                    auroraColors[4].withOpacity(0.1), // Ice blue
                                    auroraColors[3].withOpacity(0.05), // Ethereal teal
                                  ],
                          )
                        : null,
                    border: Border.all(
                      color: isSelected 
                          ? (isDark ? auroraColors[3] : auroraColors[4]).withOpacity(0.6) // Ethereal teal / Ice blue
                          : (isDark ? auroraColors[6] : auroraColors[2]).withOpacity(0.3), // Soft mint / Arctic blue
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: isDark 
                                  ? auroraColors[3].withOpacity(0.2) // Ethereal teal
                                  : auroraColors[4].withOpacity(0.2), // Ice blue
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    isDark ? auroraColors[3].withOpacity(0.3) : auroraColors[4].withOpacity(0.3), // Ethereal teal / Ice blue
                                    isDark ? auroraColors[4].withOpacity(0.1) : auroraColors[5].withOpacity(0.1), // Ice blue / Aurora green
                                  ],
                                )
                              : null,
                          color: !isSelected 
                              ? (isDark ? auroraColors[6] : auroraColors[2]).withOpacity(0.1) // Soft mint / Arctic blue
                              : null,
                        ),
                        child: Icon(
                          option.icon,
                          color: isSelected 
                              ? (isDark ? auroraColors[3] : auroraColors[2]) // Ethereal teal / Arctic blue
                              : (isDark ? auroraColors[6] : auroraColors[2]).withOpacity(0.7), // Soft mint / Arctic blue
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          option.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected 
                                ? (isDark ? auroraColors[3] : auroraColors[2]) // Ethereal teal / Arctic blue
                                : (isDark ? auroraColors[6] : auroraColors[1]), // Soft mint / Midnight blue
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                isDark ? auroraColors[3] : auroraColors[4], // Ethereal teal / Ice blue
                                isDark ? auroraColors[4] : auroraColors[5], // Ice blue / Aurora green
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark 
                                    ? auroraColors[3].withOpacity(0.4) // Ethereal teal
                                    : auroraColors[4].withOpacity(0.4), // Ice blue
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    ));
  }

  Widget _buildSmartFeatures(bool isDark) {
    return Column(
      children: [
        _buildToggleOption(
          'Time-based themes',
          'Automatically adjust colors throughout the day',
          _timeBasedThemes,
          (value) => setState(() => _timeBasedThemes = value),
          isDark,
        ),
        const SizedBox(height: 16),
        _buildToggleOption(
          'Hide screenshots',
          'Filter out screenshots and uninteresting photos',
          _hideScreenshots,
          (value) => setState(() => _hideScreenshots = value),
          isDark,
        ),
        const SizedBox(height: 16),
        _buildToggleOption(
          'Quiet hours',
          'Dim display and pause notifications during sleep',
          _quietHours,
          (value) => setState(() => _quietHours = value),
          isDark,
        ),
      ],
    );
  }

  Widget _buildToggleOption(String title, String description, bool value, 
      Function(bool) onChanged, bool isDark) {
    // Aurora borealis color palette
    const auroraColors = [
      Color(0xFF0B1426), // Deep space blue
      Color(0xFF1B2951), // Midnight blue
      Color(0xFF2D5D87), // Arctic blue
      Color(0xFF4ECDC4), // Ethereal teal
      Color(0xFF45B7D1), // Ice blue
      Color(0xFF96CEB4), // Aurora green
      Color(0xFFB8E6B8), // Soft mint
      Color(0xFFE8F8F5), // Polar white
    ];
    
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? auroraColors[6] : auroraColors[1], // Soft mint / Midnight blue
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark 
                      ? auroraColors[6].withOpacity(0.7) // Soft mint
                      : auroraColors[2].withOpacity(0.7), // Arctic blue
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: isDark ? auroraColors[3] : auroraColors[4], // Ethereal teal / Ice blue
          activeTrackColor: isDark 
              ? auroraColors[3].withOpacity(0.3) // Ethereal teal
              : auroraColors[4].withOpacity(0.3), // Ice blue
          inactiveThumbColor: isDark 
              ? auroraColors[6].withOpacity(0.4) // Soft mint
              : auroraColors[1].withOpacity(0.4), // Midnight blue
          inactiveTrackColor: isDark 
              ? auroraColors[6].withOpacity(0.2) // Soft mint
              : auroraColors[1].withOpacity(0.2), // Midnight blue
        ),
      ],
    );
  }

  Widget _buildMediaControls(bool isDark) {
    return Column(
      children: [
        // Enable Photos toggle
        _buildGlassmorphismToggle(
          icon: Icons.photo_library,
          title: 'Enable Photos',
          subtitle: 'Display your photo collection',
          value: slideshowController.enablePhotos,
          onChanged: slideshowController.setEnablePhotos,
          isDark: isDark,
          isEnabled: true,
        ),
        const SizedBox(height: 12),
        
        // Enable Videos toggle
        _buildGlassmorphismToggle(
          icon: Icons.videocam,
          title: 'Enable Videos',
          subtitle: 'Display your videos (Premium)',
          value: slideshowController.enableVideos,
          onChanged: (val) => _showSubscriptionDialog(),
          isDark: isDark,
          isEnabled: false, // Videos require subscription
        ),
      ],
    );
  }

  Widget _buildGlassmorphismToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required RxBool value,
    required Function(bool) onChanged,
    required bool isDark,
    required bool isEnabled,
  }) {
    // Aurora borealis color palette
    const auroraColors = [
      Color(0xFF0B1426), // Deep space blue
      Color(0xFF1B2951), // Midnight blue
      Color(0xFF2D5D87), // Arctic blue
      Color(0xFF4ECDC4), // Ethereal teal
      Color(0xFF45B7D1), // Ice blue
      Color(0xFF96CEB4), // Aurora green
      Color(0xFFB8E6B8), // Soft mint
      Color(0xFFE8F8F5), // Polar white
    ];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                  auroraColors[3].withOpacity(0.02), // Ethereal teal
                ]
              : [
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0.5),
                  auroraColors[6].withOpacity(0.1), // Soft mint
                ],
        ),
        border: Border.all(
          color: isDark 
              ? auroraColors[3].withOpacity(0.3) // Ethereal teal
              : auroraColors[4].withOpacity(0.4), // Ice blue
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? auroraColors[3].withOpacity(0.1) // Ethereal teal
                : auroraColors[4].withOpacity(0.2), // Ice blue
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Enhanced icon with aurora glow
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              auroraColors[3].withOpacity(0.2), // Ethereal teal
                              auroraColors[4].withOpacity(0.1), // Ice blue
                            ]
                          : [
                              auroraColors[5].withOpacity(0.2), // Aurora green
                              auroraColors[4].withOpacity(0.1), // Ice blue
                            ],
                    ),
                    border: Border.all(
                      color: isDark 
                          ? auroraColors[3].withOpacity(0.3) // Ethereal teal
                          : auroraColors[4].withOpacity(0.3), // Ice blue
                      width: 0.5,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isEnabled 
                        ? (isDark ? auroraColors[3] : auroraColors[2]) // Ethereal teal / Arctic blue
                        : (isDark ? auroraColors[6] : auroraColors[1]).withOpacity(0.5), // Soft mint / Midnight blue
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Enhanced text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isEnabled 
                              ? (isDark ? auroraColors[6] : auroraColors[1]) // Soft mint / Midnight blue
                              : (isDark ? auroraColors[6] : auroraColors[1]).withOpacity(0.5),
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: isEnabled 
                              ? (isDark ? auroraColors[6] : auroraColors[2]).withOpacity(0.8) // Soft mint / Arctic blue
                              : (isDark ? auroraColors[6] : auroraColors[2]).withOpacity(0.4),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Enhanced toggle switch with aurora colors
                isEnabled 
                    ? Obx(() => Switch(
                        value: value.value,
                        onChanged: onChanged,
                        activeColor: isDark ? auroraColors[3] : auroraColors[4], // Ethereal teal / Ice blue
                        inactiveThumbColor: (isDark ? auroraColors[6] : auroraColors[1]).withOpacity(0.5), // Soft mint / Midnight blue
                        inactiveTrackColor: (isDark ? auroraColors[6] : auroraColors[1]).withOpacity(0.2),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ))
                    : Switch(
                        value: false, // Always false when disabled
                        onChanged: (val) => _showSubscriptionDialog(),
                        activeColor: isDark ? auroraColors[3] : auroraColors[4], // Ethereal teal / Ice blue
                        inactiveThumbColor: (isDark ? auroraColors[6] : auroraColors[1]).withOpacity(0.5), // Soft mint / Midnight blue
                        inactiveTrackColor: (isDark ? auroraColors[6] : auroraColors[1]).withOpacity(0.2),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSubscriptionDialog() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    
    // Aurora borealis-inspired color palette
    final auroraColors = [
      const Color(0xFF0B1426), // Deep space blue
      const Color(0xFF1B2951), // Midnight blue
      const Color(0xFF2D5D87), // Arctic blue
      const Color(0xFF4ECDC4), // Ethereal teal
      const Color(0xFF45B7D1), // Ice blue
      const Color(0xFF96CEB4), // Aurora green
      const Color(0xFFB8E6B8), // Soft mint
      const Color(0xFFE8F8F5), // Polar white
    ];
    
    // Enhanced glassmorphism subscription dialog with aurora theme
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: auroraColors[0].withOpacity(0.4),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.5,
              colors: [
                auroraColors[7].withOpacity(isDark ? 0.15 : 0.95),
                auroraColors[6].withOpacity(isDark ? 0.12 : 0.85),
                auroraColors[4].withOpacity(isDark ? 0.08 : 0.75),
                auroraColors[2].withOpacity(isDark ? 0.05 : 0.65),
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
            border: Border.all(
              color: auroraColors[3].withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: auroraColors[3].withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 0,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: auroraColors[4].withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(isDark ? 0.08 : 0.15),
                      Colors.white.withOpacity(isDark ? 0.04 : 0.08),
                      auroraColors[3].withOpacity(0.02),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Enhanced premium icon with aurora glow
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            auroraColors[3].withOpacity(0.4),
                            auroraColors[4].withOpacity(0.3),
                            auroraColors[5].withOpacity(0.2),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 0.8, 1.0],
                        ),
                        border: Border.all(
                          color: auroraColors[3].withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: auroraColors[3].withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: auroraColors[4].withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Icon(
                            Icons.video_library_outlined,
                            size: 45,
                            color: auroraColors[3],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Enhanced title with aurora glow
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            auroraColors[3].withOpacity(0.1),
                            auroraColors[4].withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Text(
                        'Subscription Required',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: isDark ? auroraColors[6] : auroraColors[1],
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: auroraColors[3].withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Enhanced content with better styling
                    Text(
                      'Video support requires a premium subscription. Unlock this feature and illuminate your video memories like the northern lights!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: isDark ? auroraColors[6].withOpacity(0.9) : auroraColors[1].withOpacity(0.8),
                        height: 1.5,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    
                    // Enhanced action buttons with aurora styling
                    Row(
                      children: [
                        // Enhanced cancel button
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(isDark ? 0.15 : 0.8),
                                  Colors.white.withOpacity(isDark ? 0.08 : 0.6),
                                  auroraColors[7].withOpacity(isDark ? 0.05 : 0.4),
                                ],
                              ),
                              border: Border.all(
                                color: auroraColors[4].withOpacity(0.3),
                                width: 1.2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? auroraColors[5] : auroraColors[1],
                                          letterSpacing: 0.3,
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
                        const SizedBox(width: 16),
                        
                        // Enhanced upgrade button with aurora gradient
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  auroraColors[3],
                                  auroraColors[4],
                                  auroraColors[5],
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: auroraColors[3].withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: auroraColors[4].withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  // Navigate to subscription screen
                                  // Get.toNamed('/subscription');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    'Upgrade',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      shadows: [
                                        Shadow(
                                          color: auroraColors[1].withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(bool isDark) {
    // Aurora borealis color palette
    const auroraColors = [
      Color(0xFF0B1426), // Deep space blue
      Color(0xFF1B2951), // Midnight blue
      Color(0xFF2D5D87), // Arctic blue
      Color(0xFF4ECDC4), // Ethereal teal
      Color(0xFF45B7D1), // Ice blue
      Color(0xFF96CEB4), // Aurora green
      Color(0xFFB8E6B8), // Soft mint
      Color(0xFFE8F8F5), // Polar white
    ];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  auroraColors[3].withOpacity(0.2), // Ethereal teal
                  auroraColors[4].withOpacity(0.15), // Ice blue
                  auroraColors[5].withOpacity(0.1), // Aurora green
                ]
              : [
                  auroraColors[5].withOpacity(0.3), // Aurora green
                  auroraColors[4].withOpacity(0.2), // Ice blue
                  auroraColors[3].withOpacity(0.1), // Ethereal teal
                ],
        ),
        border: Border.all(
          color: isDark 
              ? auroraColors[3].withOpacity(0.4) // Ethereal teal
              : auroraColors[4].withOpacity(0.5), // Ice blue
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? auroraColors[3].withOpacity(0.4) // Ethereal teal
                : auroraColors[4].withOpacity(0.4), // Ice blue
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: isDark 
                ? auroraColors[1].withOpacity(0.2) // Midnight blue
                : auroraColors[5].withOpacity(0.2), // Aurora green
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
                        auroraColors[3].withOpacity(0.3), // Ethereal teal
                        auroraColors[4].withOpacity(0.2), // Ice blue
                        auroraColors[5].withOpacity(0.15), // Aurora green
                      ]
                    : [
                        auroraColors[5].withOpacity(0.4), // Aurora green
                        auroraColors[4].withOpacity(0.3), // Ice blue
                        auroraColors[3].withOpacity(0.2), // Ethereal teal
                      ],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                onTap: () {
                  // Navigate to final onboarding step (carousel)
                  Get.toNamed('/onboarding/carousel');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    'Complete Setup',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? auroraColors[6] : Colors.white, // Soft mint for dark, white for light
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          color: isDark 
                              ? auroraColors[0].withOpacity(0.5) // Deep space blue
                              : auroraColors[2].withOpacity(0.4), // Arctic blue
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

class TransitionOption {
  final String id;
  final String name;
  final IconData icon;

  TransitionOption(this.id, this.name, this.icon);
}
