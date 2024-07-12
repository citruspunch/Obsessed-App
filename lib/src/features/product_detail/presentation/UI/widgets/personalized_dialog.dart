import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showPersonalizedDialog({
  required BuildContext context,
  required String text,
  required IconData icon,
  required Color iconColor,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.75),
    builder: (BuildContext context) {
      return _Content(
        text: text,
        icon: icon,
        iconColor: iconColor,
      );
    },
  );
}

class _Content extends StatelessWidget {
  const _Content({
    required this.text,
    required this.icon,
    required this.iconColor,
  });
  final String text;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      titlePadding: const EdgeInsets.only(left: 5, right: 5, bottom: 15),
      iconPadding: const EdgeInsets.only(top: 20, bottom: 13),
      title: Text(text),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      icon: Icon(
        icon,
        color: iconColor,
        size: 55,
      ),
      actions: [
        const Divider(
          color: Colors.white,
          thickness: 1,
          height: 0,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Center(
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
        ),
      ],
    );
  }
}
