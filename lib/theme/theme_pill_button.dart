import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

/// Pill style button for theme mode selection
class ThemePillButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Color? iconColor;
  final String? tooltip;
  const ThemePillButton({
    required this.icon,
    required this.selected,
    required this.onTap,
    this.iconColor,
    this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary.withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Tooltip(
          message: tooltip ?? '',
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? (selected ? theme.colorScheme.primary : theme.iconTheme.color),
          ),
        ),
      ),
    );
  }
}

/// Row of theme mode pill buttons (System, Dark, Light)
class ThemeModePillRow extends StatelessWidget {
  const ThemeModePillRow({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final mode = themeController.themeMode.value;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemePillButton(
              icon: Icons.auto_mode, // or Icons.settings, or Icons.brightness_auto
              selected: mode == ThemeMode.system,
              onTap: () => themeController.switchTheme(ThemeMode.system),
              // Use same color logic as other icons: primary if selected, default otherwise
              iconColor: null,
              tooltip: 'System',
            ),
            const SizedBox(width: 4),
            ThemePillButton(
              icon: Icons.nightlight,
              selected: mode == ThemeMode.dark,
              onTap: () => themeController.switchTheme(ThemeMode.dark),
              tooltip: 'Dark',
            ),
            const SizedBox(width: 4),
            ThemePillButton(
              icon: Icons.wb_sunny,
              selected: mode == ThemeMode.light,
              onTap: () => themeController.switchTheme(ThemeMode.light),
              tooltip: 'Light',
            ),
          ],
        ),
      );
    });
  }
}
