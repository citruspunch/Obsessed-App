import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_body.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_footer.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_header.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
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
                  if (cart.items.isNotEmpty)
                    CartBody(cartItems: cart.items),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.7),
                ],
              ),
            ),
          ),
          if (cart.items.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CartFooter(totalPrice: cart.totalPrice),
            )
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your cart is empty',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 100,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}