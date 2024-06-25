import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ItemActions extends StatelessWidget {
  final CartItem item;

  const ItemActions({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Provider.of<CartProvider>(context, listen: false).removeItem(item),
            child: const Icon(Icons.delete, color: Colors.black),
          ),
        ],
      ),
    );
  }
}