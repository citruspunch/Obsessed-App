import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoItemsFoundWidget extends StatelessWidget {
  final String message;
  final String? subMessage;

  const NoItemsFoundWidget({
    super.key,
    this.message = 'No items found',
    this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 120, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          if (subMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              subMessage!,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}