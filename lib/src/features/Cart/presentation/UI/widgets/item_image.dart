import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String imageUrl;

  const ItemImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Container(
        height: 70,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}