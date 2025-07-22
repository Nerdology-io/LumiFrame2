import 'package:flutter/material.dart';
import 'dart:ui';
import '../widgets/nav_shell_background_wrapper.dart';

/// A glassmorphism container specifically designed for authentication screens.
/// Provides a beautiful, centered card with blur effects and proper constraints.
class GlassmorphismAuthWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const GlassmorphismAuthWrapper({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.maxWidth = 400,
    this.padding = const EdgeInsets.all(24.0),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return NavShellBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark 
                            ? Colors.white.withOpacity(0.08)
                            : Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.15)
                              : Colors.white.withOpacity(0.25),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: padding!,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header section
                            if (title != null || subtitle != null) ...[
                              Column(
                                children: [
                                  if (title != null)
                                    Text(
                                      title!,
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? Colors.white : Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  if (subtitle != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      subtitle!,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: isDark 
                                            ? Colors.white.withOpacity(0.7)
                                            : Colors.black.withOpacity(0.6),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 32),
                            ],
                            // Content
                            child,
                          ],
                        ),
                      ),
                    ),
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
