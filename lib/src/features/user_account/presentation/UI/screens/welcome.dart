import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/login_screen.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/Obsessed icon.png'),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
                child: Text(
                  'Welcome to the Obsessed App!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, left: 40, right: 40),
                child: Text(
                  'Please login or sign up\nto continue',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  animateTransition(context, const LoginScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5, // Añade sombra
                  padding:
                      const EdgeInsets.symmetric(horizontal: 87, vertical: 13),
                ),
                child: Text(
                  'LOG IN',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  animateTransition(context, const SignupScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                ),
                child: Text(
                  'SIGN UP',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void animateTransition(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 700),
      ),
    );
  }
}
