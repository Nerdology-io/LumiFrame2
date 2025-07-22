import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A reusable title header component for screens with back button and title
class ScreenTitleHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Color? titleColor;
  final Color? backButtonColor;

  const ScreenTitleHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.titleColor,
    this.backButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // Back button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onBackPressed ?? () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: backButtonColor ?? defaultColor,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Title
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: titleColor ?? defaultColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
