import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/quantity_control.dart';

class ItemDetails extends StatelessWidget {
  final CartItem item;

  const ItemDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name,
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            capitalizeFirstLetter(item.category),
            style: GoogleFonts.poppins(
              letterSpacing: 0,
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          Text(
            'Size: ${item.size}',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black.withOpacity(0.7)),
          ),
          Text(
            'Color: ${getColorName(item.color)}',
            style: GoogleFonts.poppins(fontSize: 14, color: (item.color != Colors.black) ? item.color?.withOpacity(0.7) : Colors.black, fontWeight: (item.color == Colors.black) ? FontWeight.w500 : FontWeight.normal),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 80,
            child: QuantityControl(item: item)
          ),
          const SizedBox(height: 10),
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(fontSize: 17.3, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String getColorName(Color? color) {
    Map<Color, String> colorNames = {
      Colors.black: "Black",
      Colors.blue: "Blue",
      Colors.red: "Red",
      Colors.teal: "Teal",
    };
    return colorNames[color] ?? "Unknown Color";
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}