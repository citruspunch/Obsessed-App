import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsForm extends StatelessWidget {
  const OrderDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final List<CartItem> cartItems = cart.items;
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                cartItems[index].name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                cartItems[index].price.toStringAsFixed(2),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )
              ),
              trailing: Text(
                cartItems[index].quantity.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}