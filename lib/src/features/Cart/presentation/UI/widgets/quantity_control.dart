import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/core/constants/constants.dart';
import 'package:obsessed_app/src/features/cart/domain/entities/cart_item.dart';
import 'package:obsessed_app/src/features/cart/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class QuantityControl extends StatelessWidget {
  final CartItem item;

  const QuantityControl({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Provider.of<CartProvider>(context, listen: false).decreaseItemQuantity(item),
          child: const Icon(FeatherIcons.minusCircle, color: Colors.black),
        ),
        Expanded(
          child: Text(
            '${item.quantity}',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16, 
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (item.quantity < initialStock) {
              Provider.of<CartProvider>(context, listen: false).increaseItemQuantity(item);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'You have reached the maximum quantity for this item.',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Icon(FeatherIcons.plusCircle, color: Colors.black),
        ),
      ],
    );
  }
}