import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';

class ProductLabel extends StatelessWidget {
  final ClothingItem item;
  const ProductLabel({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 145,
            child: Text(
              item.title,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                height: 1.4,
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),
              ),
            ),
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 255, 0, 0).withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}