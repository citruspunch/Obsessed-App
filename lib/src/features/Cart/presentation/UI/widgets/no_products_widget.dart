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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Icon(
              Icons.remove_shopping_cart,
              size: 80,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 20),
            if (backToHome)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Home(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
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
                  backgroundColor: const Color.fromARGB(255, 48, 48, 48),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
