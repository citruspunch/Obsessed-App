import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/screens/home.dart';

class NoProductsWidget extends StatelessWidget {
  final bool backToHome;
  final String text;
  final String subtitle;

  const NoProductsWidget({
    super.key,
    required this.backToHome,
    required this.text,
    this.subtitle = 'Start Shopping',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.remove_shopping_cart,
            size: 80,
            color: Colors.grey.shade500,
          ),
          const SizedBox(height: 30),
          if (backToHome)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const Home(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                    (Route<dynamic> route) => false,
                  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800, 
                foregroundColor: Colors.white,
              ),
              child: Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}