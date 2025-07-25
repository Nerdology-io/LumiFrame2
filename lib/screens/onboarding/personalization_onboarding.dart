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
  
  // Controllers
  final slideshowController = Get.find<SlideshowController>();
  
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
  }

  Widget _buildPreferencesContent(bool isDark) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32), // Added extra padding under subtitle
          
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
    return Container(
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
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
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
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlideshowDurationSection(bool isDark) {
    return Obx(() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Change photo every',
              style: TextStyle(
                fontSize: 16,
                color: (isDark ? Colors.white : Colors.black87).withOpacity(0.8),
              ),
            ),
            Text(
              '${slideshowController.slideDuration.value}s',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppConstants.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppConstants.primaryColor,
            inactiveTrackColor: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
            thumbColor: AppConstants.primaryColor,
            overlayColor: AppConstants.primaryColor.withOpacity(0.2),
          ),
          child: Slider(
            value: slideshowController.slideDuration.value.toDouble(),
            min: 2.0,
            max: 30.0,
            divisions: 28,
            onChanged: (value) {
              slideshowController.setSlideDuration(value.toInt());
            },
          ),
        ),
      ],
    ));
  }

  Widget _buildTransitionSelector(bool isDark) {
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
                    gradient: isSelected ? LinearGradient(
                      colors: [
                        AppConstants.primaryColor.withOpacity(0.15),
                        AppConstants.primaryColor.withOpacity(0.05),
                      ],
                    ) : null,
                    border: Border.all(
                      color: isSelected 
                          ? AppConstants.primaryColor.withOpacity(0.6)
                          : (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        option.icon,
                        color: isSelected 
                            ? AppConstants.primaryColor 
                            : (isDark ? Colors.white : Colors.black87).withOpacity(0.7),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          option.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected 
                                ? AppConstants.primaryColor 
                                : (isDark ? Colors.white : Colors.black87),
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: AppConstants.primaryColor,
                          size: 24,
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
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: (isDark ? Colors.white : Colors.black87).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppConstants.primaryColor,
          activeTrackColor: AppConstants.primaryColor.withOpacity(0.3),
          inactiveThumbColor: (isDark ? Colors.white : Colors.black).withOpacity(0.4),
          inactiveTrackColor: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
        ),
      ],
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

class TransitionOption {
  final String id;
  final String name;
  final IconData icon;

  TransitionOption(this.id, this.name, this.icon);
}
