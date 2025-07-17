import 'package:flutter/material.dart';

/// Reusable pill button for theme mode selection.
/// Displays label with selection highlight (border/color) and optional checkmark.
class ThemePillButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ThemePillButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary.withAlpha((0.18 * 255).round())
              : theme.brightness == Brightness.dark
                  ? Colors.white.withAlpha((0.04 * 255).round())
                  : Colors.black.withAlpha((0.04 * 255).round()),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: selected ? theme.colorScheme.primary : theme.textTheme.bodyLarge?.color,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                fontSize: 15,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 4),
              Icon(Icons.check, size: 16, color: theme.colorScheme.primary),
            ],
          ],
        ),
      ),
    );
  }
}