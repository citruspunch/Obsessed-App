import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartConfirmationDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Item successfully added to cart.'),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}