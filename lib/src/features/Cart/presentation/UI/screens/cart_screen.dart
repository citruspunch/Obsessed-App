import 'package:flutter/material.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_body.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_footer.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_header.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_item.dart';
import 'package:obsessed_app/src/features/Cart/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalPrice;
  const CartScreen({
    super.key, 
    required this.cartItems, 
    required this.totalPrice
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const CartHeader(),
                  CartBody(cartItems: cart.items),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CartFooter(totalPrice: cart.totalPrice),
          ),
        ],
      ),
    );
  }
}