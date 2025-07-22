import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A glassmorphism-styled input field for duration values in seconds.
/// Allows users to input custom values with proper validation.
class GlassmorphismDurationInput extends StatefulWidget {
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

  @override
  State<GlassmorphismDurationInput> createState() => _GlassmorphismDurationInputState();
}

class _GlassmorphismDurationInputState extends State<GlassmorphismDurationInput> {

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
      padding: widget.padding!,
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
                      widget.labelText,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDisplayValue(widget.value),
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
    final dialogController = TextEditingController(text: widget.value.toString());
    
    showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.labelText),
        content: TextField(
          controller: dialogController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            labelText: 'Duration in ${widget.suffix}',
            hintText: 'Enter duration...',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              dialogController.dispose();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final text = dialogController.text.trim();
              final newValue = int.tryParse(text);
              
              if (newValue != null) {
                int constrainedValue = newValue;
                if (widget.minValue != null && constrainedValue < widget.minValue!) {
                  constrainedValue = widget.minValue!;
                }
                if (widget.maxValue != null && constrainedValue > widget.maxValue!) {
                  constrainedValue = widget.maxValue!;
                }
                
                dialogController.dispose();
                Navigator.of(context).pop();
                widget.onChanged?.call(constrainedValue);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
