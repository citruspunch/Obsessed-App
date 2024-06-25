import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesTitle extends StatelessWidget {
  const FavoritesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Favorites',
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}