import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String? englishText;
  final String? spanishText;
  final String? text;
  final IconData icon;
  final double titleSize;
  final double iconSize;
  final double textSize;
  final bool isPurchaseHistory;
  final String? orderId;
  final List<dynamic>? products;
  final double? total;

  const InfoCard({
    super.key,
    required this.title,
    this.englishText,
    this.spanishText, 
    this.text,
    required this.icon,
    this.titleSize = 25,
    this.iconSize = 30,
    this.textSize = 18,
    this.isPurchaseHistory = false,
    this.orderId,
    this.products,
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: iconSize, color: Colors.blueGrey[800]),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.blueGrey[900],
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
              ],
            ),
            if(!isPurchaseHistory)
              const SizedBox(height: 16),
            if (text != null)
              Text(
                text!,
                style: GoogleFonts.poppins(
                  fontSize: textSize,
                ),
              ),
            if(isPurchaseHistory)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 32, thickness: 1),
                  Text(
                    'Order ID',
                    style: GoogleFonts.poppins(
                      fontSize: textSize + 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    orderId!,
                    style: GoogleFonts.poppins(
                      fontSize: textSize,
                    ),
                  ),
                  Text(
                    'Products:',
                    style: GoogleFonts.poppins(
                      fontSize: textSize + 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    products!.map((product) => '• $product').join('\n'),
                    style: GoogleFonts.poppins(
                      fontSize: textSize,
                    ),
                  ),
                  Text(
                    'Total:',
                    style: GoogleFonts.poppins(
                      fontSize: textSize + 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '\$${total!.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: textSize,
                    ),
                  ),
                ],
              ),
            if (englishText != null)
              Text(
                englishText!,
                style: GoogleFonts.poppins(
                  fontSize: textSize,
                ),
              ),
            if (englishText != null && spanishText != null)
              const Divider(height: 32, thickness: 1),
            if (spanishText != null)
              Text(
                spanishText!,
                style: GoogleFonts.poppins(
                  fontSize: textSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}