import 'package:feather_icons/feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/screens/product_detail.dart';
import 'package:provider/provider.dart';

class ClothingItemWidget extends StatelessWidget {
  final ClothingItem item;
  final double imageWidth;
  final double imageHeight;
  final double titleFontSize;
  final double subtitleFontSize;
  final double iconSize;
  final Color iconColor;

  const ClothingItemWidget({
    super.key,
    required this.item,
    this.imageWidth = 111, // Valores por defecto
    this.imageHeight = 111,
    this.titleFontSize = 24, 
    this.subtitleFontSize = 15, 
    this.iconSize = 21, 
    this.iconColor = Colors.black, 
  });

  @override
  Widget build(BuildContext context) {
    var isFavorite = Provider.of<FavoritesProvider>(context).items.contains(item);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(item: item),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: BoxConstraints(maxHeight: imageHeight + 140, maxWidth: imageWidth + 189),
          color: Colors.white,
          child: Stack(children: [
            Positioned(
                right: 1,
                top: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 11),
                  child: Icon(
                    isFavorite ? Icons.favorite : FeatherIcons.heart,
                    size: isFavorite ? iconSize + 4 : iconSize,
                    color: isFavorite ? Colors.red : iconColor,
                  ),
                )),
            Positioned(
                top: 20,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Image.network(
                      item.imagePath,
                      fit: BoxFit.contain,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        item.title,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: titleFontSize, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                      "SHOP NOW",
                      style: GoogleFonts.dmSerifText(
                        fontSize: subtitleFontSize, fontWeight: FontWeight.w500),
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
        ),
      ),
    );
  }
}