import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_body.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_footer.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_header.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_title.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/screens/home.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/return_to_home_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalPrice;

  const CartScreen({
    super.key, 
    required this.cartItems, 
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: cart.items.isEmpty ? const Color(0xFFF1F1F1) : null,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 20.0, bottom: 20.0),
          child: ReturnToHomeButton(),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 140, top: 20.0),
          child: CartTitle(),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(42),
          child: CartHeader(),
        ),
        forceMaterialTransparency: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  if (cart.items.isNotEmpty)
                    CartBody(cartItems: cart.items),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 680),
                  ),
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
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 90,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800, 
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Start Shopping',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}