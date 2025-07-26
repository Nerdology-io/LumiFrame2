import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/glassmorphism_dialog.dart';
import '../glassmorphism_container.dart';

/// A glassmorphism-styled input field for duration values in seconds.
/// Allows users to input custom values with proper validation.
class GlassmorphismDurationInput extends StatelessWidget {
  final String labelText;
  final int value;
  final ValueChanged<int>? onChanged;
  final EdgeInsetsGeometry? padding;
  final int? minValue;
  final int? maxValue;
  final String? suffix;

  const GlassmorphismDurationInput({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.minValue = 1,
    this.maxValue,
    this.suffix = 'seconds',
  });

  String _formatDisplayValue(int seconds) {
    if (seconds < 60) {
      return '$seconds second${seconds == 1 ? '' : 's'}';
    } else if (seconds < 3600) {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      if (remainingSeconds == 0) {
        return '$minutes minute${minutes == 1 ? '' : 's'}';
      } else {
        return '$minutes min ${remainingSeconds}s';
      }
    } else {
      final hours = seconds ~/ 3600;
      final remainingMinutes = (seconds % 3600) ~/ 60;
      if (remainingMinutes == 0) {
        return '$hours hour${hours == 1 ? '' : 's'}';
      } else {
        return '$hours hr ${remainingMinutes}m';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: InkWell(
        onTap: () => _showInputDialog(context),
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
                      _formatDisplayValue(value),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInputDialog(BuildContext context) {
    String inputValue = value.toString();
    
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => GlassmorphismDialog(
        title: Text(labelText),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: inputValue),
              decoration: InputDecoration(
                labelText: 'Duration in ${suffix ?? 'seconds'}',
                hintText: 'Enter duration...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autofocus: true,
              onChanged: (text) {
                inputValue = text;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GlassmorphismContainer.light(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Center(
                            child: Text(
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
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassmorphismContainer.light(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          final newValue = int.tryParse(inputValue.trim());
                          
                          if (newValue != null) {
                            int constrainedValue = newValue;
                            if (minValue != null && constrainedValue < minValue!) {
                              constrainedValue = minValue!;
                            }
                            if (maxValue != null && constrainedValue > maxValue!) {
                              constrainedValue = maxValue!;
                            }
                            
                            Navigator.of(context).pop();
                            onChanged?.call(constrainedValue);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Center(
                            child: Text(
                              'Save',
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
