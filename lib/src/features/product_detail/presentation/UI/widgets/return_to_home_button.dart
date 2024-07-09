import 'package:flutter/material.dart';

class ReturnToHomeButton extends StatelessWidget {
  const ReturnToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
        ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}