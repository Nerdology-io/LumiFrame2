import 'package:flutter/material.dart';

/// A glassmorphism-styled inline slider for immediate value adjustment.
/// Perfect for volume controls and other settings that benefit from instant feedback.
class GlassmorphismInlineSlider extends StatelessWidget {
  final String labelText;
  final double value;
  final ValueChanged<double>? onChanged;
  final EdgeInsetsGeometry? padding;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double)? formatValue;
  final bool showValueLabel;

  const GlassmorphismInlineSlider({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.formatValue,
    this.showValueLabel = true,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label and value row - aligned with SwitchListTile
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelText,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (showValueLabel)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.2)
                            : Colors.black.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _defaultFormatValue(value),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Slider container
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.02),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: Column(
              children: [
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
                      fontSize: 12,
                    ),
                    trackHeight: 4.0,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8.0,
                      disabledThumbRadius: 6.0,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 16.0,
                    ),
                  ),
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: divisions,
                    label: _defaultFormatValue(value),
                    onChanged: onChanged,
                  ),
                ),
                
                // Min/Max labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
