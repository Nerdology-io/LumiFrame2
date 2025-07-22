import 'package:flutter/material.dart';
import 'glassmorphism_dialog.dart';

/// A glassmorphism-styled radio selection input for choosing between options.
/// Provides beautiful dialog-based interface for option selection.
class GlassmorphismRadioInput<T> extends StatelessWidget {
  final String labelText;
  final T value;
  final List<T> options;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? optionDisplayText;
  final EdgeInsetsGeometry? padding;
  final bool capitalizeText;

  const GlassmorphismRadioInput({
    super.key,
    required this.labelText,
    required this.value,
    required this.options,
    required this.onChanged,
    this.optionDisplayText,
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

  String _getDisplayText(T option) {
    if (optionDisplayText != null) {
      return optionDisplayText!(option);
    }
    return _capitalizeWords(option.toString());
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = _getDisplayText(value);
    
    return Padding(
      padding: padding!,
      child: InkWell(
        onTap: () => _showRadioDialog(context),
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
                Icons.radio_button_checked,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRadioDialog(BuildContext context) {
    T? selectedValue = value;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => GlassmorphismDialog(
          title: labelText,
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
              Column(
                children: options.map((option) {
                  final displayText = _getDisplayText(option);
                  final isSelected = option == selectedValue;
                  
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
                          setState(() {
                            selectedValue = option;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected 
                                        ? (isDark ? Colors.white : Colors.black87)
                                        : (isDark ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)),
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: isDark ? Colors.white : Colors.black87,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            GlassmorphismDialogButton(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
              isPrimary: false,
            ),
            const SizedBox(width: 12),
            GlassmorphismDialogButton(
              text: 'Save',
              onPressed: () {
                Navigator.of(context).pop();
                onChanged?.call(selectedValue);
              },
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}
