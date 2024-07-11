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
  final bool isFavoriteItem;
  final bool heroActivated;

  const ClothingItemWidget({
    super.key,
    required this.item,
    this.imageWidth = 100,
    this.imageHeight = 90,
    this.titleFontSize = 20,
    this.subtitleFontSize = 16,
    this.iconSize = 21,
    this.iconColor = Colors.black,
    this.iconPadding = 2.5,
    this.isFavoriteItem = false,
    this.heroActivated = true,
  });

  @override
  Widget build(BuildContext context) {
    var isFavorite =
        Provider.of<FavoritesProvider>(context).items.contains(item);
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
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 13.0, left: 18.0, right: 18.0, bottom: 7.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold),
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
                      style: GoogleFonts.poppins(
                          fontStyle: FontStyle.italic,
                          fontSize: subtitleFontSize - 3,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Center(
                  child: heroActivated
                      ? Hero(
                          tag: 'hero-${item.id}',
                          transitionOnUserGestures: true,
                          child: Image.network(
                            item.imagePath,
                            fit: BoxFit.contain,
                            width: imageWidth,
                            height: imageHeight,
                          ),
                        )
                      : Image.network(
                          item.imagePath,
                          fit: BoxFit.contain,
                          width: imageWidth,
                          height: imageHeight,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 18.0, bottom: 12.0, top: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: iconPadding),
                          child: Icon(FeatherIcons.star,
                              size: iconSize, color: Colors.amber),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.rating['rate'].toString(),
                          style: GoogleFonts.poppins(
                              fontSize: subtitleFontSize - 0.5,
                              color: Colors.grey[600]),
                        ),
                        if (isFavoriteItem)
                          Text(' (${item.rating['count']})',
                              style: GoogleFonts.poppins(
                                  fontSize: subtitleFontSize - 0.5,
                                  color: Colors.grey[600])),
                      ],
                    ),
                    Text(
                      item.price < 10
                          ? '\$0${item.price.toStringAsFixed(2)}'
                          : '\$${item.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                          fontSize: subtitleFontSize + 0.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
