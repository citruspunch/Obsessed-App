import 'package:flutter/material.dart';

class AddToFavoritesButton extends StatelessWidget {
  const AddToFavoritesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        iconSize: 32,
        icon: const Icon(
          Icons.favorite_border,
          color: Colors.black,
          ),
        onPressed: () {},
      ),
    );
  }
}