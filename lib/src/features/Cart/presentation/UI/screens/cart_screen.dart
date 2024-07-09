import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_body.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/cart_footer.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/widgets/no_products_widget.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
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
        toolbarHeight: 80,
        backgroundColor: cart.items.isEmpty ? const Color(0xFFF1F1F1) : null,
        centerTitle: true,
        leading: const ReturnToHomeButton(),
        title: Text('Cart', style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        )),
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
            const NoProductsWidget(backToHome: true, text: 'Your cart is empty')
        ],
      ),
    );
  }
}