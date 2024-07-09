import 'package:flutter/material.dart';

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onSelect;

  const ColorOption({
    super.key, 
    required this.color,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onSelect,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.9) : color,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(color: const Color.fromARGB(255, 93, 93, 93), width: 3.5) : null,
          ),
        ),
      ),
    );
  }
}