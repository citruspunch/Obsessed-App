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
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Card( 
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClothingItemWidget(
              item: item, 
              imageWidth: 200, 
              imageHeight: 200,
              titleFontSize: 30,
              subtitleFontSize: 18,
              iconSize: 30,
              iconColor: Colors.black,
            ),
          ),
        )).toList(),
      ),
    );
  }
}