import 'package:flutter/material.dart';

class ReturnToHomeButton extends StatelessWidget {
  const ReturnToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        iconSize: 30,
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}