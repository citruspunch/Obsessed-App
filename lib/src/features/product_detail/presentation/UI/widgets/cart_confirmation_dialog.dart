import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartConfirmationDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          titlePadding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
          iconPadding: const EdgeInsets.only(top: 20, bottom: 13),
          title: const Text('Item successfully\nadded to cart.'),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          icon: const Icon(
            FeatherIcons.checkCircle,
            color: Colors.green,
            size: 55,
          ),
          actions: [
            const Divider(
              color: Colors.white,
              thickness: 1,
              height: 0,
            ),
            const SizedBox(height: 10),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 23,
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
