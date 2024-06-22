import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentTitle extends StatelessWidget {
  const PaymentTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Payment',
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}