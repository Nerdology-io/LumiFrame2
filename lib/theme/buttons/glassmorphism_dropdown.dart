import 'package:flutter/material.dart';

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
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    
    showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy + renderBox.size.height + 300,
      ),
      items: items.map((item) {
        final displayText = itemDisplayText?.call(item) ?? _capitalizeWords(item.toString());
        return PopupMenuItem<T>(
          value: item,
          child: Text(displayText),
        );
      }).toList(),
    ).then((selectedValue) {
      if (selectedValue != null) {
        onChanged?.call(selectedValue);
      }
    });
  }
}
