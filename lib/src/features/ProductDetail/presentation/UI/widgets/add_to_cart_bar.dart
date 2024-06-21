import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/screens/cart_screen.dart';
import 'package:obsessed_app/src/features/Cart/presentation/UI/widgets/cart_item.dart';
import 'package:obsessed_app/src/features/Cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/ProductDetail/presentation/UI/widgets/product_selection_modal.dart';
import 'package:provider/provider.dart';

class AddToCartBar extends StatelessWidget {
  final ClothingItem item;
  const AddToCartBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              var cartProvider = Provider.of<CartProvider>(context, listen: false);
              List<CartItem> cartItems = cartProvider.items;
              double totalPrice = cartProvider.totalPrice;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartItems: cartItems,
                    totalPrice: totalPrice,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.shopping_cart,
                size: 23,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => ProductSelectionModal(item: item),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 17),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Add to Cart',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}