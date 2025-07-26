import 'package:flutter/material.dart';
import '../theme/glassmorphism_container.dart';

/// Basic glassmorphism dialog component
class GlassmorphismDialog extends StatelessWidget {
  final Widget? title;
  final Widget? child;
  final Widget? content; // Alias for child for backward compatibility
  final List<Widget>? actions;

  const GlassmorphismDialog({
    super.key,
    this.title,
    this.child,
    this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final bodyWidget = child ?? content;
    if (bodyWidget == null) {
      throw ArgumentError('Either child or content must be provided');
    }

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
              if (title != null) ...[
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  child: title!,
                ),
                const SizedBox(height: 16),
              ],
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
                child: bodyWidget,
              ),
              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!
                      .map((action) => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: action,
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
