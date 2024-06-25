import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class AddToFavoritesButton extends StatelessWidget {
  final ClothingItem item;
  const AddToFavoritesButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    var isFavorite = Provider.of<FavoritesProvider>(context).items.contains(item);
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : FeatherIcons.heart,
          size: isFavorite ? 33 : 30,
          color: isFavorite ? Colors.red : Colors.black,
        ),
        onPressed: () {
          if (!isFavorite) {
            Provider.of<FavoritesProvider>(context, listen: false).add(item);
          } else {
            Provider.of<FavoritesProvider>(context, listen: false).remove(item);
          }
        },
      ),
    );
  }
}