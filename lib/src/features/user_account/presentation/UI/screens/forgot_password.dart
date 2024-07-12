// ignore_for_file: use_build_context_synchronously
/*
import 'package:flutter/material.dart';
import 'package:obsessed_app/main.dart';
import 'package:obsessed_app/src/core/constants/constants.dart';
import 'package:obsessed_app/src/features/user_account/presentation/UI/widgets/snackbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            myDialogBox(context);
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
  
  void myDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Text(
                      "Forgot Your Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter the Email",
                    hintText: "eg user@gmail.com",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    if (!validateEmail(email)) {
                      context.showSnackBar('Please enter a valid email', isError: true);
                      return;
                    }
                    try {
                      await supabase.auth.resetPasswordForEmail(email).then((value) {
                        showSnackBar(context,
                          "We have send you the reset password link to your email id, Please check it");
                      }).onError((error, stackTrace) {
                        showSnackBar(context, error.toString());
                      });
                    } catch (e) {
                      context.showSnackBar('An error occurred while sending reset link', isError: true);
                    }
                    Navigator.pop(context);
                    emailController.clear();
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}*/