import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' show ImageFilter;
import '../utils/constants.dart';
import '../controllers/theme_controller.dart';

class GlassmorphismDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final double? maxWidth;
  final double? maxHeight;
  final EdgeInsets? contentPadding;
  final bool barrierDismissible;

  const GlassmorphismDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.maxWidth,
    this.maxHeight,
    this.contentPadding,
    this.barrierDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 340,
          maxHeight: maxHeight ?? double.infinity,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (isDark ? Colors.white : Colors.black).withOpacity(0.15),
              (isDark ? Colors.white : Colors.black).withOpacity(0.08),
              (isDark ? Colors.white : Colors.black).withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : Colors.grey).withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 1.5),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (isDark ? Colors.white : Colors.black).withOpacity(0.08),
                    (isDark ? Colors.white : Colors.black).withOpacity(0.02),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                          letterSpacing: 0.5,
                        ),
                        child: title!,
                      ),
                    ),
                  ],
                  if (content != null) ...[
                    Flexible(
                      child: Padding(
                        padding: contentPadding ?? 
                          EdgeInsets.fromLTRB(24, title != null ? 0 : 24, 24, 16),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: (isDark ? Colors.white : Colors.black87).withOpacity(0.8),
                            height: 1.5,
                          ),
                          child: content!,
                        ),
                      ),
                    ),
                  ],
                  if (actions != null && actions!.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions!.map((action) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: _buildGlassmorphismButton(action, isDark),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphismButton(Widget action, bool isDark) {
    if (action is TextButton) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (isDark ? Colors.white : Colors.black).withOpacity(0.1),
              (isDark ? Colors.white : Colors.black).withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.15),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: TextButton(
              onPressed: action.onPressed,
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: isDark ? Colors.white : Colors.black87,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                ),
              ),
              child: action.child!,
            ),
          ),
        ),
      );
    }
    return action;
  }

  static Future<T?> show<T>({
    required Widget content,
    Widget? title,
    List<Widget>? actions,
    double? maxWidth,
    double? maxHeight,
    EdgeInsets? contentPadding,
    bool barrierDismissible = true,
  }) {
    return Get.dialog<T>(
      GlassmorphismDialog(
        title: title,
        content: content,
        actions: actions,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        contentPadding: contentPadding,
        barrierDismissible: barrierDismissible,
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}

// Helper widgets for common dialog types
class GlassmorphismSuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onConfirm;

  const GlassmorphismSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphismDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.3),
                  Colors.green.withOpacity(0.1),
                ],
              ),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onConfirm ?? () => Get.back(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class GlassmorphismErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onConfirm;

  const GlassmorphismErrorDialog({
    super.key,
    required this.title,
    required this.message,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphismDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.3),
                  Colors.red.withOpacity(0.1),
                ],
              ),
            ),
            child: const Icon(
              Icons.error,
              color: Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onConfirm ?? () => Get.back(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class GlassmorphismConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const GlassmorphismConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphismDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.blue.withOpacity(0.1),
                ],
              ),
            ),
            child: const Icon(
              Icons.help_outline,
              color: Colors.blue,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Get.back(result: false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onConfirm ?? () => Get.back(result: true),
          child: Text(confirmText),
        ),
      ],
    );
  }
}

class GlassmorphismLoadingDialog extends StatelessWidget {
  final String message;
  final bool showProgress;

  const GlassmorphismLoadingDialog({
    super.key,
    required this.message,
    this.showProgress = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark ||
        (themeController.themeMode.value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return GlassmorphismDialog(
      barrierDismissible: false,
      maxWidth: 280,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showProgress) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryColor.withOpacity(0.2),
                    AppConstants.accentColor.withOpacity(0.1),
                  ],
                ),
              ),
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark ? Colors.white : AppConstants.primaryColor,
                  ),
                  strokeWidth: 3,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: (isDark ? Colors.white : Colors.black87).withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassmorphismSnackbar {
  static void show({
    required String title,
    required String message,
    IconData? icon,
    Color? iconColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      (iconColor ?? Colors.orange).withOpacity(0.3),
                      (iconColor ?? Colors.orange).withOpacity(0.1),
                    ],
                  ),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        messageText: Text(
          message,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
          ),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.transparent,
        duration: duration,
        margin: const EdgeInsets.all(16),
        borderRadius: AppConstants.defaultRadius,
        backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.3),
          ],
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
        overlayBlur: 15,
        isDismissible: true,
      ),
    );
  }
}
