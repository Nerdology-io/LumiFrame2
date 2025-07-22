import 'package:flutter/material.dart';
import 'dart:ui';

/// A beautiful glassmorphism-styled dialog with blur effect and modern styling.
/// Designed to match the app's glassmorphism aesthetic.
class GlassmorphismDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> actions;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  const GlassmorphismDialog({
    super.key,
    required this.title,
    required this.child,
    required this.actions,
    this.maxWidth = 340,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 340),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), // Increased blur for better glassmorphism effect
            child: Container(
              decoration: BoxDecoration(
                color: isDark 
                    ? Colors.black.withOpacity(0.2)
                    : Colors.white.withOpacity(0.4), // Reduced from 0.8 to 0.4 for glassmorphism effect
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.15), // Slightly increased border opacity
                  width: 1,
                ),
              ),
              padding: padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  child,
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A beautiful glassmorphism-styled button for dialog actions.
/// Supports primary and secondary styling variants.
class GlassmorphismDialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const GlassmorphismDialogButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
    this.width,
    this.height = 44,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isPrimary
            ? (isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1)) // Increased opacity for primary button in light mode
            : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.04)), // Increased opacity for secondary button in light mode
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPrimary
              ? (isDark ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3)) // Increased border opacity for primary button
              : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.12)), // Increased border opacity for secondary button
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            padding: padding,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: isPrimary 
                      ? (isDark ? Colors.white : Colors.black87)
                      : (isDark ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7)),
                  fontSize: 16,
                  fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A glassmorphism-styled text input field for use within dialogs.
/// Provides consistent styling with the app's design language.
class GlassmorphismTextInput extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final List<dynamic>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final TextStyle? style;
  final int? maxLines;

  const GlassmorphismTextInput({
    super.key,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.autofocus = false,
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              fontSize: 14.0,
              color: isDark 
                  ? Colors.white.withOpacity(0.8)
                  : Colors.black.withOpacity(0.9), // Increased opacity for better readability in light mode
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.05), // Increased opacity for better visibility while maintaining glassmorphism
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2), // Increased border opacity for better definition
              width: 1,
            ),
          ),
          child: TextFormField(
            initialValue: initialValue,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters?.cast(),
            style: style ?? TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
            ),
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDark 
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.6), // Increased opacity for better readability
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            autofocus: autofocus,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
