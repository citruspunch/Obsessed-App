import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_item.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_item_widget.dart';

class CartBody extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartBody({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: cartItems.map((item) => CartItemWidget(item: item)).toList(),
      ),
    );
  }
}