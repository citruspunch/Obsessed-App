import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class AddToFavoritesButton extends StatefulWidget {
  final ClothingItem item;
  const AddToFavoritesButton({super.key, required this.item});

  @override
  State<AddToFavoritesButton> createState() => _AddToFavoritesButtonState();
}

class _AddToFavoritesButtonState extends State<AddToFavoritesButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1600), vsync: this);
    var isFavorite = Provider.of<FavoritesProvider>(context, listen: false)
        .items
        .contains(widget.item);

    _controller.value = isFavorite ? 1.0 : 0.0;
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.085;
    var isFavorite =
        Provider.of<FavoritesProvider>(context).items.contains(widget.item);
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
        child: Lottie.asset(
          'assets/animations/Animation - 1720753354218.json',
          //'assets/animations/heart_animation.json',
          fit: BoxFit.cover,
          controller: _controller,
          height: size,
          width: size,
        ),
        onTap: () {
          if (!isFavorite) {
            Provider.of<FavoritesProvider>(context, listen: false)
                .add(widget.item);
            _controller.forward();
          } else {
            Provider.of<FavoritesProvider>(context, listen: false)
                .remove(widget.item);
            _controller.reverse();
          }
        },
      ),
    );
  }
}
