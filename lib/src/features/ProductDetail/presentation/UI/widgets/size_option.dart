import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SizeOption extends StatelessWidget {
  final String size;
  final Color backgroundColor;
  final bool isSelected;
  final VoidCallback onSelect;

  const SizeOption({
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.size, 
    required this.backgroundColor,
    });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onSelect,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(color: const Color.fromARGB(255, 93, 93, 93), width: 3.5) : null,
          ),
          child: Center(
            child: Text(
              size,
              style: GoogleFonts.poppins(
                color: isSelected ? const Color.fromARGB(255, 93, 93, 93) : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}