import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentTitle extends StatelessWidget {
  const PaymentTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Payment',
      style: GoogleFonts.poppins(
        fontSize: 27,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }
}