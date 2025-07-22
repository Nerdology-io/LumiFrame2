import 'package:flutter/material.dart';

/// A glassmorphism-styled divider with text for authentication screens.
class GlassmorphismAuthDivider extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? margin;

  const GlassmorphismAuthDivider({
    super.key,
    this.text = 'OR',
    this.margin = const EdgeInsets.symmetric(vertical: 24.0),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: margin,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: isDark 
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark 
                    ? Colors.white.withOpacity(0.6)
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: isDark 
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}
