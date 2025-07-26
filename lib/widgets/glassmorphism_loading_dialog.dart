import 'package:flutter/material.dart';
import '../theme/glassmorphism_container.dart';

/// A glassmorphism-styled loading dialog with spinner and message
class GlassmorphismLoadingDialog extends StatelessWidget {
  final String message;
  final Color? loadingColor;

  const GlassmorphismLoadingDialog({
    super.key,
    required this.message,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassmorphismContainer.medium(
        enableGlow: true,
        glowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    loadingColor ?? Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
