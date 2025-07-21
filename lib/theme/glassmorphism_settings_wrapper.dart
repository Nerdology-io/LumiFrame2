import 'package:flutter/material.dart';
import 'glassmorphism_container.dart';

class GlassmorphismSettingsWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final double maxWidth;
  final double blurSigma;
  final double opacity;

  const GlassmorphismSettingsWrapper({
    super.key,
    required this.child,
    this.title,
    this.maxWidth = 500,
    this.blurSigma = 16.0,
    this.opacity = 0.18,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: GlassmorphismContainer(
          borderRadius: BorderRadius.circular(32),
          blurSigma: blurSigma,
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
