import 'package:flutter/material.dart';
import 'dart:ui';
import '../glassmorphism_container.dart';

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
      child: GlassmorphismContainer.light(
        enableGlow: false,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _showSliderDialog(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _defaultFormatValue(value),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.2),
                          Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        ],
                      ),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
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
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: GlassmorphismContainer.intense(
            enableGlow: true,
            glowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Adjust the value:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              const SizedBox(height: 16),
              GlassmorphismContainer.medium(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      Text(
                        _defaultFormatValue(currentValue),
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Theme.of(context).colorScheme.primary,
                          inactiveTrackColor: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                          thumbColor: Theme.of(context).colorScheme.primary,
                          overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                          valueIndicatorColor: Theme.of(context).colorScheme.primary,
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          trackHeight: 6.0,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 12.0,
                            elevation: 4.0,
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
                      const SizedBox(height: 12),
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _defaultFormatValue(max),
                            style: TextStyle(
                              color: isDark 
                                  ? Colors.white.withOpacity(0.6)
                                  : Colors.black.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GlassmorphismContainer.light(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: const Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GlassmorphismContainer.medium(
                        enableGlow: true,
                        glowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.of(context).pop();
                              onChanged?.call(currentValue);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                                    Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: const Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
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
            ),
          ),
        ),
      ),
    );
  }
}
