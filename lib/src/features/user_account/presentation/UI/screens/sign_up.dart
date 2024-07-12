// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/features/home/presentation/UI/screens/home.dart';
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 2.8,
                      child:
                          Image.asset('assets/images/signupilustration.webp'),
                    ),
                    TextFieldInput(
                        icon: Icons.email,
                        textEditingController: emailController,
                        hintText: 'Enter your email',
                        textInputType: TextInputType.text),
                    TextFieldInput(
                      icon: Icons.lock,
                      textEditingController: passwordController,
                      hintText: 'Enter your passord',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    MyButtons(onTap: signupUser, text: "Sign Up"),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            " Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
/*
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
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      final AuthResponse res = await supabase.auth.signUp(
          email: emailController.text, password: passwordController.text);
      // Si el registro es exitoso, result.user no será null.
      if (res.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        // Si result.user es null, muestra un mensaje de error genérico.
        showSnackBar(context, "Registration failed. Please try again.");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height / 2.8,
              child: Image.asset('assets/images/signupilustration.webp'),
            ),
            TextFieldInput(
                icon: Icons.email,
                textEditingController: emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.text),
            TextFieldInput(
              icon: Icons.lock,
              textEditingController: passwordController,
              hintText: 'Enter your passord',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            MyButtons(onTap: signupUser, text: "Sign Up"),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
*/