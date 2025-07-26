import 'package:flutter/material.dart';
import '../../widgets/glassmorphism_dialog.dart';
import '../glassmorphism_container.dart';

/// A glassmorphism-styled action button for triggering actions with optional confirmation.
/// Provides beautiful dialog-based confirmation when needed.
class GlassmorphismActionButton extends StatelessWidget {
  final String labelText;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final bool requiresConfirmation;
  final String? confirmationTitle;
  final String? confirmationMessage;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final bool isDestructive;

  const GlassmorphismActionButton({
    super.key,
    required this.labelText,
    required this.onPressed,
    this.subtitle,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.requiresConfirmation = false,
    this.confirmationTitle,
    this.confirmationMessage,
    this.confirmButtonText = 'Confirm',
    this.cancelButtonText = 'Cancel',
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: InkWell(
        onTap: () => requiresConfirmation ? _showConfirmationDialog(context) : onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labelText,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: isDestructive ? Colors.red.withValues(alpha: 0.9) : null,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                icon ?? (isDestructive ? Icons.warning : Icons.arrow_forward_ios),
                color: isDestructive 
                    ? Colors.red.withValues(alpha: 0.9)
                    : Theme.of(context).iconTheme.color?.withValues(alpha: 0.6),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => GlassmorphismDialog(
        title: Text(
          confirmationTitle ?? 'Confirm Action',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              confirmationMessage ?? 'Are you sure you want to perform this action?',
              style: TextStyle(
                fontSize: 16.0,
                color: isDark 
                    ? Colors.white.withValues(alpha: 0.9)
                    : Colors.black.withValues(alpha: 0.9),
                height: 1.4,
              ),
            ),
            if (isDestructive) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.red.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red.withValues(alpha: 0.9),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This action cannot be undone.',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.red.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GlassmorphismContainer.light(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        cancelButtonText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassmorphismContainer.medium(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onPressed();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        confirmButtonText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
