// ignore_for_file: use_build_context_synchronously

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/features/product_detail/presentation/UI/widgets/personalized_dialog.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/edit_account_page.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/screens/login_screen.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/personalized_button.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/snackbar.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
      if (res.user != null) {
        animateTransition(
            context,
            const EditAccountPage(
              isFirstTime: true,
            ));
        showPersonalizedDialog(
            context: context,
            text: 'Complete your profile',
            icon: FeatherIcons.alertCircle,
            iconColor: Colors.yellow);
      } else {
        showSnackBar(context, "Registration failed. Please try again.");
      }
    } catch (e) {
      showSnackBar(context, "An error occurred: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 110.0),
                      child: SizedBox(
                        width: height / 2.8,
                        height: height / 3.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: GoogleFonts.cinzel(
                                fontSize:
                                    MediaQuery.of(context).size.width / 5.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  const Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.white38,
                                    offset: Offset(2.8, 2.8),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 0.5,
                              indent: 15,
                              endIndent: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFieldInput(
                        icon: Icons.email,
                        textEditingController: emailController,
                        hintText: 'Enter your email',
                        focus: true,
                        textInputType: TextInputType.text),
                    TextFieldInput(
                      icon: Icons.lock,
                      textEditingController: passwordController,
                      hintText: 'Enter your passord',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    MyButtons(onTap: signupUser, text: "Sign Up"),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              animateTransition(context, const LoginScreen());
                            },
                            child: Text(
                              " Login",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
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
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
