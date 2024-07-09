import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/widgets/clothing_item_widget.dart';

class FavoritesBody extends StatelessWidget {
  final List<ClothingItem> favoriteItems;

  const FavoritesBody({super.key, required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: favoriteItems.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12, right: 20, left: 20),
          child: Card( 
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClothingItemWidget(
              item: item, 
              imageWidth: 160, 
              imageHeight: 160,
              titleFontSize: 23,
              subtitleFontSize: 20,
              iconSize: 27,
              iconColor: Colors.black,
              iconPadding: 4.0,
              isFavoriteItem: true,
              heroActivated: false,
            ),
          ),
        )).toList(),
      ),
    );
  }
}