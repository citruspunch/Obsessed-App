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
  final double iconPadding;

  const ClothingItemWidget({
    super.key,
    required this.item,
    this.imageWidth = 111,
    this.imageHeight = 111,
    this.titleFontSize = 20,
    this.subtitleFontSize = 16,
    this.iconSize = 21,
    this.iconColor = Colors.black,
    this.iconPadding = 2.5,
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
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          constraints: BoxConstraints(maxHeight: imageHeight + 160, maxWidth: imageWidth + 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 18.0, right: 18.0, bottom: 2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          isFavorite ? Icons.favorite : FeatherIcons.heart,
                          size: isFavorite ? iconSize + 3.5 : iconSize,
                          color: isFavorite ? Colors.red : iconColor,
                        ),
                      ],
                    ),
                    Text(
                      item.name,
                      style: GoogleFonts.poppins(fontStyle: FontStyle.italic, fontSize: subtitleFontSize - 3, color: Colors.grey[600]),
                    ),
                    /* 
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(fontSize: titleFontSize, fontWeight: FontWeight.bold, height: 1.3),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          isFavorite ? Icons.favorite : FeatherIcons.heart,
                          size: isFavorite ? iconSize + 3.5 : iconSize,
                          color: isFavorite ? Colors.red : iconColor,
                        ),
                      ],
                    ),
                    */
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Hero(
                    tag: 'hero-${item.id}',
                    transitionOnUserGestures: true,
                    child: Image.network(
                      item.imagePath,
                      fit: BoxFit.contain,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 18.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: iconPadding),
                          child: Icon(FeatherIcons.star, size: iconSize, color: Colors.amber),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item.rating['rate'].toString(),
                          style: GoogleFonts.poppins(fontSize: subtitleFontSize - 0.5, color: Colors.grey[600]),
                        ),
                        Text(
                          " (${item.rating['count']})",
                          style: GoogleFonts.poppins(fontSize: subtitleFontSize - 0.5, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(fontSize: subtitleFontSize + 1, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}