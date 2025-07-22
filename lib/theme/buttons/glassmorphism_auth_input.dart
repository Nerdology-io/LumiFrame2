import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A glassmorphism-styled text input field specifically designed for authentication.
/// Features beautiful blur effects, validation states, and consistent styling.
class GlassmorphismAuthInput extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool autofocus;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? margin;

  const GlassmorphismAuthInput({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLength,
    this.autofocus = false,
    this.onChanged,
    this.margin = const EdgeInsets.only(bottom: 16.0),
  });

  @override
  State<GlassmorphismAuthInput> createState() => _GlassmorphismAuthInputState();
}

class _GlassmorphismAuthInputState extends State<GlassmorphismAuthInput> {
  bool _isFocused = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.labelText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark 
                    ? Colors.white.withOpacity(0.9)
                    : Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          
          // Input field
          Container(
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _errorText != null
                    ? Colors.red.withOpacity(0.7)
                    : _isFocused
                        ? (isDark ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.3))
                        : (isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1)),
                width: _isFocused ? 1.5 : 1.0,
              ),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: isDark 
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLength,
              autofocus: widget.autofocus,
              onChanged: (value) {
                widget.onChanged?.call(value);
                // Clear error when user starts typing
                if (_errorText != null) {
                  setState(() {
                    _errorText = null;
                  });
                }
              },
              onTap: () {
                setState(() {
                  _isFocused = true;
                });
              },
              onEditingComplete: () {
                setState(() {
                  _isFocused = false;
                });
                // Validate on editing complete
                if (widget.validator != null) {
                  final error = widget.validator!(widget.controller?.text);
                  setState(() {
                    _errorText = error;
                  });
                }
              },
              validator: (value) {
                final error = widget.validator?.call(value);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _errorText = error;
                    });
                  }
                });
                return error;
              },
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: isDark 
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.4),
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                counterText: '', // Hide counter
              ),
            ),
          ),
          
          // Error text
          if (_errorText != null) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                _errorText!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A glassmorphism-styled button specifically designed for authentication.
class GlassmorphismAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;
  final Widget? icon;
  final EdgeInsetsGeometry? margin;

  const GlassmorphismAuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.icon,
    this.margin = const EdgeInsets.only(bottom: 12.0),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: margin,
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? (isDark 
                  ? Colors.white.withOpacity(0.15)
                  : Colors.black.withOpacity(0.8))
              : (isDark 
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.15)),
          foregroundColor: isPrimary
              ? (isDark ? Colors.white : Colors.white)
              : (isDark ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7)),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark ? Colors.white : Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isPrimary
                          ? (isDark ? Colors.white : Colors.white)
                          : (isDark ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// A glassmorphism-styled text button for secondary actions.
class GlassmorphismAuthTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;

  const GlassmorphismAuthTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.margin = const EdgeInsets.only(bottom: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isDark 
              ? Colors.white.withOpacity(0.7)
              : Colors.black.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
