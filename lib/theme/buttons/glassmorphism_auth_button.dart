import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import '../../utils/constants.dart';
import '../core/glassmorphism_config.dart';
import '../effects/shadow_effects.dart';

class GlassmorphismAuthButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final GlassmorphismConfig? config;
  final bool enableGlow;

  const GlassmorphismAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.config,
    this.enableGlow = true,
  });

  @override
  State<GlassmorphismAuthButton> createState() => _GlassmorphismAuthButtonState();
}

class _GlassmorphismAuthButtonState extends State<GlassmorphismAuthButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveConfig = _getEffectiveConfig();
    final effectiveBackgroundColor = widget.backgroundColor ?? AppConstants.primaryColor;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: effectiveConfig.borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.backgroundColor != null 
                  ? [effectiveBackgroundColor, effectiveBackgroundColor.withOpacity(0.8)]
                  : [
                      AppConstants.primaryColor,
                      AppConstants.accentColor,
                    ],
              ),
              boxShadow: [
                ...effectiveConfig.shadows,
                if (widget.enableGlow) ...[
                  BoxShadow(
                    color: effectiveBackgroundColor.withOpacity(0.3 + _glowAnimation.value * 0.2),
                    blurRadius: 15 + _glowAnimation.value * 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ]
              ],
            ),
            child: ClipRRect(
              borderRadius: effectiveConfig.borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: effectiveConfig.blurSigma,
                  sigmaY: effectiveConfig.blurSigma,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: effectiveConfig.borderRadius,
                    onTap: widget.isLoading ? null : widget.onPressed,
                    onTapDown: widget.isLoading ? null : (_) => _animationController.forward(),
                    onTapUp: widget.isLoading ? null : (_) => _animationController.reverse(),
                    onTapCancel: () => _animationController.reverse(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: effectiveConfig.gradientColors,
                          stops: effectiveConfig.gradientStops,
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: effectiveConfig.borderWidth,
                        ),
                        borderRadius: effectiveConfig.borderRadius,
                      ),
                      child: Center(
                        child: widget.isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.textColor ?? Colors.white,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.icon != null) ...[
                                    Icon(
                                      widget.icon,
                                      color: widget.textColor ?? Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                  Text(
                                    widget.text,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: widget.textColor ?? Colors.white,
                                      letterSpacing: 0.5,
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

  GlassmorphismConfig _getEffectiveConfig() {
    return widget.config ?? GlassmorphismConfig(
      blurSigma: 12.0,
      opacity: 0.1,
      gradientColors: [
        Colors.white.withOpacity(0.15),
        Colors.white.withOpacity(0.08),
      ],
      borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      borderOpacity: 0.15,
      shadows: ShadowEffects.mediumShadow,
      borderWidth: 1.0,
    );
  }
}
