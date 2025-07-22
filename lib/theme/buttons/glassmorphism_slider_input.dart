import 'package:flutter/material.dart';
import 'glassmorphism_dialog.dart';

/// A glassmorphism-styled slider input for numeric values.
/// Provides beautiful dialog-based interface for precise value selection.
class GlassmorphismSliderInput extends StatelessWidget {
  final String labelText;
  final double value;
  final ValueChanged<double>? onChanged;
  final EdgeInsetsGeometry? padding;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double)? formatValue;

  const GlassmorphismSliderInput({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.formatValue,
  });

  String _defaultFormatValue(double value) {
    if (formatValue != null) {
      return formatValue!(value);
    }
    
    // Default formatting for percentages
    if (max == 1.0 && min == 0.0) {
      return '${(value * 100).round()}%';
    }
    
    // Default formatting for other ranges
    return value.toStringAsFixed(divisions != null ? 1 : 2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: InkWell(
        onTap: () => _showSliderDialog(context),
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
                      _defaultFormatValue(value),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.tune,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSliderDialog(BuildContext context) {
    double currentValue = value;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog<double>(
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
                'Adjust the value:',
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: isDark 
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      _defaultFormatValue(currentValue),
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: isDark 
                            ? Colors.white.withOpacity(0.8)
                            : Colors.black.withOpacity(0.7),
                        inactiveTrackColor: isDark 
                            ? Colors.white.withOpacity(0.2)
                            : Colors.black.withOpacity(0.2),
                        thumbColor: isDark ? Colors.white : Colors.black87,
                        overlayColor: isDark 
                            ? Colors.white.withOpacity(0.2)
                            : Colors.black.withOpacity(0.1),
                        valueIndicatorColor: isDark 
                            ? Colors.white.withOpacity(0.9)
                            : Colors.black.withOpacity(0.8),
                        valueIndicatorTextStyle: TextStyle(
                          color: isDark ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Slider(
                        value: currentValue,
                        min: min,
                        max: max,
                        divisions: divisions,
                        label: _defaultFormatValue(currentValue),
                        onChanged: (newValue) {
                          setState(() {
                            currentValue = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _defaultFormatValue(min),
                          style: TextStyle(
                            color: isDark 
                                ? Colors.white.withOpacity(0.6)
                                : Colors.black.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          _defaultFormatValue(max),
                          style: TextStyle(
                            color: isDark 
                                ? Colors.white.withOpacity(0.6)
                                : Colors.black.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                onChanged?.call(currentValue);
              },
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}
