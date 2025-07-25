import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'components/onboarding_indicator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/theme_controller.dart';
import '../../utils/constants.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel>
    with TickerProviderStateMixin {
  final _controller = PageController();
  int _currentPage = 0;
  
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
              ? [
                  const Color(0xFF0a0a1a),
                  const Color(0xFF1a1a2e),
                  const Color(0xFF16213e),
                  const Color(0xFF0f3460),
                ]
              : [
                  const Color(0xFFf0f8ff),
                  const Color(0xFFe6f3ff),
                  const Color(0xFFcce7ff),
                  const Color(0xFFb3daff),
                ],
          ),
        ),
        child: Stack(
          children: [
            // Main content
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                // Reset animations for new page
                _fadeController.reset();
                _slideController.reset();
                _fadeController.forward();
                _slideController.forward();
              },
              children: [
                _buildCompletionStep(isDark),
                _buildAccountStep(isDark),
              ],
            ),
            
            // Page indicator
            Positioned(
              bottom: _currentPage == 1 ? 180 : 100,
              left: 0,
              right: 0,
              child: Center(
                child: OnboardingIndicator(currentPage: _currentPage, pageCount: 2),
              ),
            ),
            
            // Account creation buttons (only on second page)
            if (_currentPage == 1)
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 32,
                left: 32,
                right: 32,
                child: AnimatedBuilder(
                  animation: _fadeController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeController.value,
                      child: _buildAccountButtons(isDark),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionStep(bool isDark) {
    return Center(
      child: AnimatedBuilder(
        animation: _slideController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - _slideController.value)),
            child: Opacity(
              opacity: _fadeController.value,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(40),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Success icon
                        Container(
                          padding: const EdgeInsets.all(24),
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
                            Icons.check_circle_outline,
                            size: 80,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Title
                        Text(
                          'You\'re All Set!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          'Your LumiFrame preferences are configured and ready to bring your memories to life.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: (isDark ? Colors.white : Colors.black87).withOpacity(0.8),
                            letterSpacing: 0.5,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        
                        // Continue Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppConstants.primaryColor.withOpacity(0.8),
                                AppConstants.accentColor.withOpacity(0.6),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppConstants.primaryColor.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                              onTap: () async {
                                // Mark onboarding as completed
                                final box = GetStorage();
                                await box.write('onboarding_completed', true);
                                
                                // Navigate to login screen
                                Get.offAllNamed('/auth/login');
                              },
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 2,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Optional swipe instruction
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.swipe_right,
                              color: AppConstants.primaryColor.withOpacity(0.5),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'or swipe to continue',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: AppConstants.primaryColor.withOpacity(0.6),
                                letterSpacing: 0.5,
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
          );
        },
      ),
    );
  }

  Widget _buildAccountStep(bool isDark) {
    return Center(
      child: AnimatedBuilder(
        animation: _slideController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - _slideController.value)),
            child: Opacity(
              opacity: _fadeController.value,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(40),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Account icon
                        Container(
                          padding: const EdgeInsets.all(24),
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
                            Icons.person_outline,
                            size: 80,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Title
                        Text(
                          'Create Your Account',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          'Sign in or create an account to save your settings and sync across devices.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: (isDark ? Colors.white : Colors.black87).withOpacity(0.8),
                            letterSpacing: 0.5,
                            height: 1.5,
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
    );
  }

  Widget _buildAccountButtons(bool isDark) {
    return Column(
      children: [
        // Create Account button
        Container(
          width: double.infinity,
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
                      final box = GetStorage();
                      box.write('onboarding_completed', true);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.offAllNamed('/auth/login');
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        'Create Account',
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
        const SizedBox(height: 16),
        
        // Sign In button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            border: Border.all(
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (isDark ? Colors.white : Colors.black).withOpacity(0.05),
                      (isDark ? Colors.white : Colors.black).withOpacity(0.02),
                    ],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                    onTap: () {
                      final box = GetStorage();
                      box.write('onboarding_completed', true);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.offAllNamed('/auth/login');
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: (isDark ? Colors.white : Colors.black87).withOpacity(0.8),
                          letterSpacing: 1,
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
    );
  }
}