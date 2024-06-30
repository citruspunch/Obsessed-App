import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTitle extends StatelessWidget {
  const CartTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Cart',
      style: GoogleFonts.poppins(
        fontSize: 27,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}