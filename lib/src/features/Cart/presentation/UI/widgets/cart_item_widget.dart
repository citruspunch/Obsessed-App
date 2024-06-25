import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/item_actions.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/item_details.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/item_image.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ItemImage(imageUrl: item.image),
          Expanded(child: ItemDetails(item: item)),
          ItemActions(item: item),
        ],
      ),
    );
  }
}