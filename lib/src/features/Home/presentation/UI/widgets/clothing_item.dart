import 'package:feather_icons/feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Home/domain/entities/clothing_item.dart';

class ClothingItemWidget extends StatelessWidget {
  final ClothingItem item;

  const ClothingItemWidget({super.key, required this.item});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: Stack(children: [
        const Positioned(
            right: 1,
            top: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 6, right: 9),
              child: Icon(FeatherIcons.heart, size: 20),
            )),
        Positioned(
            top: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/${item.imagePath}",
                  fit: BoxFit.contain,
                  width: 111,
                  height: 111,
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  item.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "SHOP NOW",
                  style: GoogleFonts.dmSerifText(
                    fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  height: 2,
                  width: 88,
                  color: Colors.black,
                )
              ],
            )),
      ]),
    );
  }
}