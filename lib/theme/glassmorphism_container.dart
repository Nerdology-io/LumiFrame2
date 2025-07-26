import 'dart:ui'; // For ImageFilter.blur
import 'package:flutter/material.dart';
import 'core/glassmorphism_config.dart';

/// Enhanced glassmorphism container with multiple layers, gradients, and effects
class GlassmorphismContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool hasBorder;
  final Widget child;
  final double blurSigma;
  final double opacity;
  final GlassmorphismConfig? config;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? tintColor;
  final double tintStrength;
  final bool enableParticleEffect;
  final bool enableGlow;
  final Color? glowColor;

  const GlassmorphismContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.hasBorder = false,
    required this.child,
    this.blurSigma = 10.0,
    this.opacity = 0.1,
    this.config,
    this.padding,
    this.margin,
    this.alignment,
    this.tintColor,
    this.tintStrength = 0.1,
    this.enableParticleEffect = false,
    this.enableGlow = false,
    this.glowColor,
  });

  /// Named constructor for different styles
  const GlassmorphismContainer.deep({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding,
    this.margin,
    this.alignment,
    this.tintColor,
    this.enableGlow = false,
    this.glowColor,
  }) : config = GlassmorphismConfig.deep,
       borderRadius = null,
       hasBorder = true,
       blurSigma = 35.0,
       opacity = 0.12,
       tintStrength = 0.1,
       enableParticleEffect = false;

  const GlassmorphismContainer.medium({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding,
    this.margin,
    this.alignment,
    this.tintColor,
    this.enableGlow = false,
    this.glowColor,
  }) : config = GlassmorphismConfig.medium,
       borderRadius = null,
       hasBorder = true,
       blurSigma = 25.0,
       opacity = 0.08,
       tintStrength = 0.1,
       enableParticleEffect = false;

  const GlassmorphismContainer.light({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding,
    this.margin,
    this.alignment,
    this.tintColor,
    this.enableGlow = false,
    this.glowColor,
  }) : config = GlassmorphismConfig.light,
       borderRadius = null,
       hasBorder = true,
       blurSigma = 15.0,
       opacity = 0.06,
       tintStrength = 0.1,
       enableParticleEffect = false;

  const GlassmorphismContainer.intense({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding,
    this.margin,
    this.alignment,
    this.tintColor,
    this.enableGlow = false,
    this.glowColor,
  }) : config = GlassmorphismConfig.intense,
       borderRadius = null,
       hasBorder = true,
       blurSigma = 45.0,
       opacity = 0.16,
       tintStrength = 0.1,
       enableParticleEffect = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveConfig = _getEffectiveConfig(isDark);
    
    Widget container = _buildGlassmorphismStack(context, effectiveConfig, isDark);
    
    if (margin != null) {
      container = Container(
        margin: margin,
        child: container,
      );
    }
    
    return container;
  }

  GlassmorphismConfig _getEffectiveConfig(bool isDark) {
    GlassmorphismConfig baseConfig = config ?? GlassmorphismConfig(
      blurSigma: blurSigma,
      opacity: opacity,
      gradientColors: isDark 
        ? [Colors.black.withOpacity(opacity), Colors.black.withOpacity(opacity * 0.5)]
        : [Colors.white.withOpacity(opacity), Colors.white.withOpacity(opacity * 0.5)],
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(16)),
    );

    if (isDark) {
      baseConfig = baseConfig.darkMode();
    }

    if (tintColor != null) {
      baseConfig = baseConfig.withTint(tintColor!, tintStrength);
    }

    if (enableGlow && glowColor != null) {
      baseConfig = baseConfig.withGlow(glowColor!, 12.0);
    }

    return baseConfig;
  }

  Widget _buildGlassmorphismStack(BuildContext context, GlassmorphismConfig config, bool isDark) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: config.borderRadius,
        boxShadow: config.shadows,
      ),
      child: Stack(
        children: [
          // Background particle effect (optional)
          if (enableParticleEffect) _buildParticleEffect(config),
          
          // Main glassmorphism container
          ClipRRect(
            borderRadius: config.borderRadius,
            clipBehavior: Clip.hardEdge,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: config.blurSigma,
                sigmaY: config.blurSigma,
              ),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: config.gradientColors,
                    stops: config.gradientStops,
                  ),
                  borderRadius: config.borderRadius,
                  border: hasBorder ? Border.all(
                    color: config.borderColor ?? 
                           (isDark ? Colors.white : Colors.black).withOpacity(config.borderOpacity),
                    width: config.borderWidth,
                  ) : null,
                ),
                child: _buildContainerContent(),
              ),
            ),
          ),
          
          // Inner shadow overlay (optional)
          if (config.hasInnerShadow) _buildInnerShadow(config),
        ],
      ),
    );
  }

  Widget _buildContainerContent() {
    Widget content = child;
    
    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }
    
    if (alignment != null) {
      content = Align(
        alignment: alignment!,
        child: content,
      );
    }
    
    return content;
  }

  Widget _buildParticleEffect(GlassmorphismConfig config) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: config.borderRadius,
        child: Stack(
          children: List.generate(6, (index) {
            return Positioned(
              left: (index * 47.0) % 100,
              top: (index * 73.0) % 100,
              child: Container(
                width: 4 + (index % 3) * 2,
                height: 4 + (index % 3) * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1 + (index % 3) * 0.05),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildInnerShadow(GlassmorphismConfig config) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: config.borderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: config.borderRadius,
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.5,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.05),
                Colors.black.withOpacity(0.1),
              ],
              stops: const [0.0, 0.7, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}