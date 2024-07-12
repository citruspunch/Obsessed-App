import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/core/entities/clothing_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/UI/screens/cart_screen.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/product_selection_modal.dart';
import 'package:provider/provider.dart';

class AddToCartBar extends StatelessWidget {
  final ClothingItem item;
  const AddToCartBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () {
                var cartProvider =
                    Provider.of<CartProvider>(context, listen: false);
                List<CartItem> cartItems = cartProvider.items;
                double totalPrice = cartProvider.totalPrice;
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CartScreen(
                      cartItems: cartItems,
                      totalPrice: totalPrice,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 400),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 16,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.white54],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 21,
                  color: Colors.black,
                ),
              )),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => ProductSelectionModal(item: item),
              );
            },
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.35,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Add to Cart',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
