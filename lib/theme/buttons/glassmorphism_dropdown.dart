import 'package:flutter/material.dart';
import '../../widgets/glassmorphism_dialog.dart';
import '../glassmorphism_container.dart';

/// A glassmorphism-styled dropdown widget that matches the app's design theme.
/// Removes underlines and provides clean, minimal appearance.
class GlassmorphismDropdown<T> extends StatelessWidget {
  final String labelText;
  final T value;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemDisplayText;
  final EdgeInsetsGeometry? padding;
  final bool capitalizeText;

  const GlassmorphismDropdown({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemDisplayText,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.capitalizeText = true,
  });

  /// Capitalizes the first letter of each word
  String _capitalizeWords(String text) {
    if (!capitalizeText) return text;
    
    return text
        .split('_') // Handle snake_case
        .map((word) => word.split(' ')) // Handle spaces
        .expand((words) => words) // Flatten the list
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = itemDisplayText?.call(value) ?? _capitalizeWords(value.toString());
    
    return Padding(
      padding: padding!,
      child: InkWell(
        onTap: () => _showDropdownMenu(context),
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
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayValue,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    T? selectedValue = value;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => GlassmorphismDialog(
        title: Text(labelText),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select an option:',
              style: TextStyle(
                fontSize: 14.0,
                color: isDark 
                    ? Colors.white.withOpacity(0.8)
                    : Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    final displayText = itemDisplayText?.call(item) ?? _capitalizeWords(item.toString());
                    final isSelected = item == selectedValue;
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? (isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.15))
                            : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03)),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? (isDark ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.2))
                              : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            selectedValue = item;
                            Navigator.of(context).pop();
                            onChanged?.call(item);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    displayText,
                                    style: TextStyle(
                                      color: isSelected 
                                          ? (isDark ? Colors.white : Colors.black87)
                                          : (isDark ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7)),
                                      fontSize: 16,
                                      fontWeight: isSelected 
                                          ? FontWeight.w600 
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check,
                                    color: isDark ? Colors.white : Colors.black87,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GlassmorphismContainer.light(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
