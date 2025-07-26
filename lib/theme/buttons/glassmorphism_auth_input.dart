import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../glassmorphism_container.dart';
import '../core/glassmorphism_config.dart';

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
          
          // Input field with enhanced glassmorphism
          GlassmorphismContainer(
            config: _errorText != null
                ? GlassmorphismConfig.light.withGlow(Colors.red, 8.0)
                : _isFocused
                    ? GlassmorphismConfig.medium.withGlow(
                        Theme.of(context).colorScheme.primary, 
                        12.0
                      )
                    : GlassmorphismConfig.light,
            enableGlow: _isFocused || _errorText != null,
            glowColor: _errorText != null 
                ? Colors.red.withOpacity(0.4)
                : Theme.of(context).colorScheme.primary.withOpacity(0.3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // Additional gradient overlay for better depth
                gradient: _isFocused
                    ? LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          Theme.of(context).colorScheme.primary.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                border: _errorText != null
                    ? Border.all(
                        color: Colors.red.withOpacity(0.6),
                        width: 1.5,
                      )
                    : _isFocused
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                            width: 1.5,
                          )
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
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white.withOpacity(0.95) : Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: isDark 
                        ? Colors.white.withOpacity(0.4)
                        : Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: widget.prefixIcon != null 
                      ? Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: widget.prefixIcon,
                        )
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: widget.suffixIcon,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  counterText: '', // Hide counter
                ),
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
class GlassmorphismAuthButton extends StatefulWidget {
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
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: widget.margin,
      width: double.infinity,
      height: 56,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GlassmorphismContainer(
              config: widget.isPrimary
                  ? GlassmorphismConfig.medium.withGlow(
                      Theme.of(context).colorScheme.primary,
                      8.0 + (_glowAnimation.value * 4.0),
                    )
                  : GlassmorphismConfig.light,
              enableGlow: widget.isPrimary,
              glowColor: Theme.of(context).colorScheme.primary.withOpacity(
                0.3 + (_glowAnimation.value * 0.2),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTapDown: (_) => _animationController.forward(),
                  onTapUp: (_) => _animationController.reverse(),
                  onTapCancel: () => _animationController.reverse(),
                  onTap: widget.isLoading ? null : widget.onPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: widget.isPrimary
                          ? LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                                Theme.of(context).colorScheme.primary.withOpacity(0.6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [
                                (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                                (isDark ? Colors.white : Colors.black).withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      border: Border.all(
                        color: widget.isPrimary
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                            : (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: widget.isLoading
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  widget.isPrimary ? Colors.white : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.icon != null) ...[
                                  widget.icon!,
                                  const SizedBox(width: 12),
                                ],
                                Text(
                                  widget.text,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: widget.isPrimary
                                        ? Colors.white
                                        : (isDark ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.8)),
                                  ),
                                ),
                              ],
                            ),
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
